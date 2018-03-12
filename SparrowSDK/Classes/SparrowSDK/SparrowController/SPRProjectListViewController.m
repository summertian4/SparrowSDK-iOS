//
//  SPRManagerViewController.m
//  AFNetworking
//
//  Created by 周凌宇 on 2018/3/8.
//

#import "SPRProjectListViewController.h"
#import "SPRLoginViewController.h"
#import <Masonry/Masonry.h>
#import "SPRProjectCell.h"
#import "SPRProjectDetailViewController.h"
#import "SPRProject.h"
#import "SPRHTTPSessionManager.h"
#import "SPRProjectsData.h"

@interface SPRProjectListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SPRProjectsData *projectsData;
@property (nonatomic, assign) BOOL isSelecting;

@property (nonatomic, strong) NSMutableSet *seletedProjects;
@end

@implementation SPRProjectListViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"选择项目";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"选择"
                                                                              style:UIBarButtonItemStyleDone target:self
                                                                             action:@selector(startSelect)];

    [self.view addSubview:[self tableView]];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self loadProjects];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)startSelect {
    self.isSelecting = !self.isSelecting;
    NSString *text = @"";
    if (self.isSelecting) {
        text = @"完成";
    } else {
        text = @"选择";
        // 拉取 API

    }
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:text
                                                                              style:UIBarButtonItemStyleDone target:self
                                                                             action:@selector(startSelect)];
    [self.tableView reloadData];
}

- (void)loadProjects {
    SPRHTTPSessionManager *manager = [SPRHTTPSessionManager defaultManager];
    __weak __typeof(self)weakSelf = self;

    [manager GET:@"/frontend/project/list"
      parameters:@{@"current_page": @(self.projectsData.currentPage + 1), @"limit": @(self.projectsData.limit)}
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             __strong __typeof(weakSelf)strongSelf = weakSelf;
             if (strongSelf) {
                 SPRProjectsData *newPorjectsData = [[SPRProjectsData alloc] initWithDict:responseObject[@"projects_data"]];
                 [strongSelf.projectsData.projects addObjectsFromArray:newPorjectsData.projects];
                 strongSelf.projectsData.currentPage = newPorjectsData.currentPage;
                 [strongSelf.tableView reloadData];
             }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.isSelecting == NO) {
        return;
    }
    SPRProject *project = self.projectsData.projects[indexPath.row];
    project.isSelected = YES;
    [self.seletedProjects addObject:project];

    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.projectsData.projects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SPRProjectCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SPRProjectCell"];
    if (cell == nil) {
        cell = [[SPRProjectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SPRProjectCell"];
        cell.backgroundColor = self.view.backgroundColor;
    }
    cell.model = self.projectsData.projects[indexPath.row];
    cell.isSelecting = self.isSelecting;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footer = [[UIView alloc] init];
    UIButton *button = [[UIButton alloc] init];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    button.backgroundColor = [UIColor colorWithRed:90/256.0 green:206/256.0 blue:179/256.0 alpha:1];
    [button setTitle:@"加载更多" forState:UIControlStateNormal];
    [button setTitle:@"已加载全部" forState:UIControlStateDisabled];
    [footer addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(footer);
        make.centerY.equalTo(footer);
        make.height.equalTo(@(30));
        make.width.equalTo(@(100));
    }];
    [button addTarget:self action:@selector(loadProjects) forControlEvents:UIControlEventTouchUpInside];

    BOOL result = (self.projectsData.currentPage - 1) * self.projectsData.limit < self.projectsData.total;
    button.enabled = result;
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 45;
}

#pragma mark - Getter Setter

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = self.view.backgroundColor;
        _tableView.rowHeight = 100;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}

- (SPRProjectsData *)projectsData {
    if (_projectsData == nil) {
        _projectsData = [[SPRProjectsData alloc] init];
        _projectsData.currentPage = 0;
        _projectsData.limit = 10;
        _projectsData.total = 10;
        _projectsData.projects = [NSMutableArray array];
    }
    return _projectsData;
}

- (NSMutableSet *)seletedProjects {
    if (_seletedProjects == nil) {
        _seletedProjects = [NSMutableSet set];
    }
    return _seletedProjects;
}
@end
