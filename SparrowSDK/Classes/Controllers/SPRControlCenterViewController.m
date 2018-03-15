//
//  SPRControlCenterViewController.m
//  AFNetworking
//
//  Created by 周凌宇 on 2018/3/15.
//

#import "SPRControlCenterViewController.h"
#import <Masonry/Masonry.h>
#import "SPRCommonData.h"
#import "SPRProject.h"
#import "SPRApi.h"
#import "SPRCacheManager.h"
#import "SPRApiCell.h"
#import "SPRProjectListViewController.h"

@interface SPRControlCenterViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIButton *syncButton;
@property (nonatomic, strong) UIButton *clearCacheButton;
@property (nonatomic, strong) UIButton *reselectButton;

@property (nonatomic, strong) NSArray<SPRApi *> *apis;
@property (nonatomic, strong) UITableView *mainTable;
@end

@implementation SPRControlCenterViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Sparrow";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initSubviews];
}

- (void)initData {
    [self apis];
    [self.mainTable reloadData];
}

- (void)initSubviews {
    [self mainTable];
    [self syncButton];
    [self clearCacheButton];
    [self reselectButton];
}

#pragma mark - Action

- (void)reselectButtonClicked {
    SPRProjectListViewController *vc = [[SPRProjectListViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.apis.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SPRApiCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SPRApiCell"];
    if (cell == nil) {
        cell = [[SPRApiCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SPRApiCell"];
    }
    cell.model = self.apis[indexPath.row];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"API List";
}

#pragma mark - Getter Setter

- (UIButton *)syncButton {
    if (_syncButton == nil) {
        _syncButton = [[UIButton alloc] init];
        _syncButton.layer.shadowColor = [UIColor colorWithHexString:@"000000"].CGColor;
        _syncButton.layer.shadowOpacity = 0.2f;
        _syncButton.layer.shadowOffset = CGSizeMake(0,6);
        _syncButton.layer.shadowRadius = 12;

        _syncButton.layer.cornerRadius = 8;
        _syncButton.backgroundColor = [UIColor whiteColor];

        [_syncButton setTitle:@"同步" forState:UIControlStateNormal];
        [_syncButton setTitleColor:[UIColor colorWithHexString:@"545454"] forState:UIControlStateNormal];
        _syncButton.titleLabel.font = [UIFont systemFontOfSize:17];

        [self.view addSubview:_syncButton];
        [_syncButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(15);
            make.top.equalTo(self.mas_topLayoutGuide).offset(20);
            make.height.equalTo(@(92));
            make.right.equalTo(self.clearCacheButton.mas_left).offset(-28);
            make.width.equalTo(self.clearCacheButton);
        }];
    }
    return _syncButton;
}

- (UIButton *)clearCacheButton {
    if (_clearCacheButton == nil) {
        _clearCacheButton = [[UIButton alloc] init];
        _clearCacheButton.layer.shadowOpacity = 0.2f;
        _clearCacheButton.layer.shadowOffset = CGSizeMake(0,6);
        _clearCacheButton.layer.shadowRadius = 12;

        _clearCacheButton.layer.cornerRadius = 8;
        _clearCacheButton.backgroundColor = [UIColor whiteColor];

        [_clearCacheButton setTitle:@"清除缓存" forState:UIControlStateNormal];
        [_clearCacheButton setTitleColor:[UIColor colorWithHexString:@"545454"] forState:UIControlStateNormal];
        _clearCacheButton.titleLabel.font = [UIFont systemFontOfSize:17];

        [self.view addSubview:_clearCacheButton];
        [_clearCacheButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.view).offset(-15);
            make.top.bottom.equalTo(self.syncButton);
        }];
    }
    return _clearCacheButton;
}

- (UIButton *)reselectButton {
    if (_reselectButton == nil) {
        _reselectButton = [[UIButton alloc] init];
        [self.view addSubview:_reselectButton];

        _reselectButton.layer.shadowOpacity = 0.2f;
        _reselectButton.layer.shadowOffset = CGSizeMake(0,6);
        _reselectButton.layer.shadowRadius = 12;

        _reselectButton.layer.cornerRadius = 8;
        _reselectButton.backgroundColor = SPRThemeColor;

        [_reselectButton setTitle:@"重选项目" forState:UIControlStateNormal];
        [_reselectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _reselectButton.titleLabel.font = [UIFont systemFontOfSize:17];

        [_reselectButton addTarget:self action:@selector(reselectButtonClicked)
                  forControlEvents:UIControlEventTouchUpInside];

        [_reselectButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.syncButton.mas_bottom).offset(12);
            make.left.equalTo(self.syncButton);
            make.right.equalTo(self.clearCacheButton);
            make.height.equalTo(@(45));
        }];
    }
    return _reselectButton;
}

- (UITableView *)mainTable {
    if (_mainTable == nil) {
        _mainTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _mainTable.backgroundColor = self.view.backgroundColor;
        _mainTable.rowHeight = 57;
        _mainTable.delegate = self;
        _mainTable.dataSource = self;
        _mainTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTable.sectionHeaderHeight = 30;

        [self.view addSubview:_mainTable];
        [_mainTable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.reselectButton.mas_bottom).offset(15);
            make.left.right.bottom.equalTo(self.view);
        }];
    }
    return _mainTable;
}

- (NSArray<SPRApi *> *)apis {
    if (_apis == nil) {
        _apis = [SPRCacheManager getApisFromCache];
    }
    return _apis;
}

@end
