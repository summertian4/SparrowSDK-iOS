//
//  SPRSettingViewController.m
//  AFNetworking
//
//  Created by 周凌宇 on 2018/3/20.
//

#import "SPRSettingViewController.h"

@interface SPRSettingViewController ()
@property (nonatomic, strong) UILabel *hostTitleLabel;
@property (nonatomic, strong) UITextField *hostTextField;
@property (nonatomic, strong) UIButton *hostConfirmButton;
@property (nonatomic, strong) UIView *hostContentView;
@end

@implementation SPRSettingViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"设置";
    [self initSubviews];
}

#pragma mark - Private

- (void)initSubviews {
    [self hostTitleLabel];
    [self hostContentView];
    [self hostTextField];
    [self hostConfirmButton];
}

- (void)hostConfirmButtonClicked {
    NSString *hostStr = [self.hostTextField.text
                         stringByTrimmingCharactersInSet:
                         [NSCharacterSet whitespaceCharacterSet]];
    if ([hostStr hasSuffix:@"/"]) {
        hostStr = [hostStr substringToIndex: hostStr.length - 1];
    }
    [SPRCommonData setSparrowHost:hostStr];
    [SPRToast showWithMessage:@"设置 host 成功"];
}

#pragma mark - Getter Setter

- (UILabel *)hostTitleLabel {
    if (_hostTitleLabel == nil) {
        _hostTitleLabel = [[UILabel alloc] init];
        _hostTitleLabel.text = @"Host 设置";
        _hostTitleLabel.font = [UIFont systemFontOfSize:17];
        _hostTitleLabel.textColor = [UIColor colorWithHexString:@"545454"];

        [self.view addSubview:_hostTitleLabel];
        [_hostTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_topLayoutGuide).offset(15);
            make.left.equalTo(self.view).offset(15);
        }];
    }
    return _hostTitleLabel;
}

- (UIView *)hostContentView {
    if (_hostContentView == nil) {
        _hostContentView = [[UIView alloc] init];
        [self.view addSubview:_hostContentView];
        [_hostContentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view).offset(15);
            make.top.equalTo(self.hostTitleLabel.mas_bottom).offset(8);
            make.right.equalTo(self.view).offset(-15);
            make.height.equalTo(@(50));
        }];

        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor colorWithHexString:@"EEECEC"];
        [_hostContentView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(_hostContentView);
            make.height.equalTo(@(1));
        }];
    }
    return _hostContentView;
}

- (UITextField *)hostTextField {
    if (_hostTextField == nil) {
        _hostTextField = [[UITextField alloc] init];
        _hostTextField.text = [SPRCommonData sparrowHost];
        _hostTextField.font = [UIFont systemFontOfSize:17];
        _hostTextField.textColor = [UIColor colorWithHexString:@"4B4B4B"];
        [self.hostContentView addSubview:_hostTextField];
        [_hostTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.hostContentView).offset(8);
            make.bottom.equalTo(self.hostContentView).offset(-6);
            make.right.equalTo(self.hostConfirmButton.mas_left).offset(8);
        }];
    }
    return _hostTextField;
}

- (UIButton *)hostConfirmButton {
    if (_hostConfirmButton == nil) {
        _hostConfirmButton = [[UIButton alloc] init];
        _hostConfirmButton.backgroundColor = SPRThemeColor;
        _hostConfirmButton.layer.cornerRadius = 5;
        _hostConfirmButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_hostConfirmButton setTitle:@"确认" forState:UIControlStateNormal];
        [_hostConfirmButton addTarget:self action:@selector(hostConfirmButtonClicked)
                     forControlEvents:UIControlEventTouchUpInside];
        [self.hostContentView addSubview:_hostConfirmButton];
        [_hostConfirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.hostContentView).offset(-8);
            make.bottom.equalTo(self.hostContentView).offset(-6);
            make.width.equalTo(@(45));
            make.height.equalTo(@(30));
        }];
    }
    return _hostConfirmButton;
}

@end
