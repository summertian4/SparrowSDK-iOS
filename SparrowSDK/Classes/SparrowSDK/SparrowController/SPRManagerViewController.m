//
//  SPRManagerViewController.m
//  AFNetworking
//
//  Created by 周凌宇 on 2018/3/8.
//

#import "SPRManagerViewController.h"
#import "SPRLoginViewController.h"
#import <Masonry/Masonry.h>
#import "SPRProjectCell.h"
#import "SPRProjectDetailViewController.h"
#import "SPRProject.h"
#import "SPRHTTPSessionManager.h"
#import "SPRProjectsData.h"

@interface SPRManagerViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SPRProjectsData *projectsData;
@end

@implementation SPRManagerViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    self.title = @"选择项目";
    [self.view addSubview:[self tableView]];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self loadProjects];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)loadProjects {
    SPRHTTPSessionManager *manager = [SPRHTTPSessionManager defaultManager];
    __weak __typeof(self)weakSelf = self;

    [manager GET:@"/frontend/project/list"
      parameters:@{@"current_page": @(1), @"limit": @(10)}
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             __strong __typeof(weakSelf)strongSelf = weakSelf;
             if (strongSelf) {
                 strongSelf.projectsData = [[SPRProjectsData alloc] initWithDict:responseObject[@"projects_data"]];
                 [strongSelf.tableView reloadData];
             }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.projectsData.projects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SPRProjectCell * cell = [tableView dequeueReusableCellWithIdentifier:@"SPRProjectCell"];
    if (cell == nil) {
        cell = [[SPRProjectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SPRProjectCell"];
        cell.backgroundColor = self.view.backgroundColor;
        cell.model = self.projectsData.projects[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:[SPRProjectDetailViewController new] animated:YES];
}

#pragma mark - Getter Setter

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.backgroundColor = self.view.backgroundColor;
        _tableView.rowHeight = 100;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

@end
