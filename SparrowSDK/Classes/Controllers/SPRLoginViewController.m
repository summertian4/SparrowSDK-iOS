//
//  SPRLoginViewController.m
//  AFNetworking
//
//  Created by 周凌宇 on 2018/4/8.
//

#import "SPRLoginViewController.h"
#import "SPRHTTPSessionManager.h"
#import "SPRAccount.h"
#import "SPRCacheManager.h"

@interface SPRLoginViewController () <UITextFieldDelegate>
@property (nonatomic, strong) UIView *frontBlockView;
@property (nonatomic, strong) UIView *backBlockView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *usernameTextField;
@property (nonatomic, strong) UIView *usernameLineView;
@property (nonatomic, strong) UITextField *passwordTextField;
@property (nonatomic, strong) UIView *passwordLineView;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIImageView *catImageView;
@property (nonatomic, strong) UIButton *dismissButton;
@end

@implementation SPRLoginViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initSubViews];
}

#pragma mark - Private

- (void)initSubViews {
    [self cornerLogo];
    [self backBlockView];
    [self frontBlockView];
    [self colorLineImageView];
    [self titleLabel];
    [self usernameLineView];
    [self usernameTextField];
    [self passwordLineView];
    [self passwordTextField];
    [self loginButton];
    [self catImageView];
    [self dismissButton];
}

- (UIImageView *)cornerLogo {
    UIImage *image = [UIImage imageNamed:@"sparrow_corner_LOGO"
                                inBundle:[SPRCommonData bundle]
           compatibleWithTraitCollection:nil];
    UIImageView *_cornerLogo = [[UIImageView alloc] initWithImage:image];
    [self.view addSubview:_cornerLogo];
    [_cornerLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.view);
        make.width.equalTo(@(271));
        make.height.equalTo(@(145));
    }];
    return _cornerLogo;
}

- (UIImageView *)colorLineImageView {
    UIImage *image = [UIImage imageNamed:@"sparrow_color_line"
                                inBundle:[SPRCommonData bundle]
           compatibleWithTraitCollection:nil];
    UIImageView *_colorLineView = [[UIImageView alloc] initWithImage:image];
    [self.view addSubview:_colorLineView];
    [_colorLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.frontBlockView);
        make.bottom.equalTo(self.frontBlockView.mas_top).equalTo(@(-6));
        make.height.equalTo(@(6));
    }];
    return _colorLineView;
}

- (void)requestLogin {
    NSString *username = [self.usernameTextField.text
                          stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceCharacterSet]];
    NSString *password = [self.passwordTextField.text
                          stringByTrimmingCharactersInSet:
                          [NSCharacterSet whitespaceCharacterSet]];

    __weak __typeof(self)weakSelf = self;
    [self showHUD];
    [SPRHTTPSessionManager POST:@"/frontend/account/login" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFormData:[username dataUsingEncoding:NSUTF8StringEncoding]
                                    name:@"username"];
        [formData appendPartWithFormData:[password dataUsingEncoding:NSUTF8StringEncoding]
                                    name:@"password"];
    } progress:nil success:^(NSURLSessionDataTask *task, SPRResponse *response) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf dismissHUD];
            [SPRToast showWithMessage:@"登录成功" from:strongSelf.view];
            SPRAccount *account = [[SPRAccount alloc] initWithDict:response.data];
            [SPRCacheManager cacheAccount:account];
            [strongSelf dismissVCCompletion:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:kSPRnotificationLoginSuccess object:nil];
            }];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        SPRLog(@"%@", error);
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf dismissHUD];
            [SPRToast showWithMessage:error.domain from:strongSelf.view];
        }
    }];
}

#pragma mark - Action

- (void)dismissButtonClicked {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dismissVCCompletion: (void (^ __nullable)(void))completion {
    [self dismissViewControllerAnimated:YES completion:completion];
}

- (void)loginButtonClicked {
    [self requestLogin];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    UIImage *image = [UIImage imageNamed:@"sparrow_cat_with_closed_eyes"
                                inBundle:[SPRCommonData bundle]
           compatibleWithTraitCollection:nil];
    self.catImageView.image = image;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    UIImage *image = [UIImage imageNamed:@"sparrow_cat_with_openi_eyes"
                                inBundle:[SPRCommonData bundle]
           compatibleWithTraitCollection:nil];
    self.catImageView.image = image;
}

#pragma mark - Getter Setter

- (UIView *)backBlockView {
    if (_backBlockView == nil) {
        _backBlockView = [[UIView alloc] init];
        [self.view addSubview:_backBlockView];
        _backBlockView.layer.shadowColor = [UIColor colorWithHexString:@"000000"].CGColor;
        _backBlockView.layer.shadowOpacity = 0.2f;
        _backBlockView.layer.shadowOffset = CGSizeMake(0,6);
        _backBlockView.layer.shadowRadius = 14;

        _backBlockView.layer.cornerRadius = 8;
        _backBlockView.backgroundColor = [UIColor whiteColor];
        [_backBlockView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_centerY);
            make.centerX.equalTo(self.view);
            make.width.equalTo(@(220));
            make.height.equalTo(@(200));
        }];
    }
    return _backBlockView;
}

- (UIView *)frontBlockView {
    if (_frontBlockView == nil) {
        _frontBlockView = [[UIView alloc] init];
        [self.view addSubview:_frontBlockView];
        _frontBlockView.layer.shadowColor = [UIColor colorWithHexString:@"000000"].CGColor;
        _frontBlockView.layer.shadowOpacity = 0.2f;
        _frontBlockView.layer.shadowOffset = CGSizeMake(0,6);
        _frontBlockView.layer.shadowRadius = 14;

        _frontBlockView.layer.cornerRadius = 8;
        _frontBlockView.backgroundColor = [UIColor whiteColor];
        [_frontBlockView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.equalTo(self.view);
            make.width.equalTo(@(300));
            make.height.equalTo(@(300));
        }];
    }

    return _frontBlockView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"SIGN UP";
        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [self.frontBlockView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.frontBlockView).offset(20);
            make.left.equalTo(self.frontBlockView).offset(28);
        }];
    }
    return _titleLabel;
}

- (UIView *)usernameLineView {
    if (_usernameLineView == nil) {
        _usernameLineView = [[UIView alloc] init];
        _usernameLineView.backgroundColor = [UIColor colorWithHexString:@"DBDBDB"];
        [self.frontBlockView addSubview:_usernameLineView];
        [_usernameLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.frontBlockView.mas_top).offset(110);
            make.left.equalTo(self.frontBlockView).offset(28);
            make.right.equalTo(self.frontBlockView).offset(-28);
            make.height.equalTo(@(1));
        }];
    }
    return _usernameLineView;
}

- (UITextField *)usernameTextField {
    if (_usernameTextField == nil) {
        _usernameTextField = [[UITextField alloc] init];
        _usernameTextField.placeholder = @"username";
        _usernameTextField.font = [UIFont systemFontOfSize:14];
        _usernameTextField.keyboardType = UIKeyboardTypeASCIICapable;
        [self.frontBlockView addSubview:_usernameTextField];
        [_usernameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.usernameLineView.mas_top);
            make.left.equalTo(self.usernameLineView).offset(6);
            make.right.equalTo(self.usernameLineView);
        }];
    }
    return _usernameTextField;
}

- (UIView *)passwordLineView {
    if (_passwordLineView == nil) {
        _passwordLineView = [[UIView alloc] init];
        _passwordLineView.backgroundColor = [UIColor colorWithHexString:@"DBDBDB"];
        [self.frontBlockView addSubview:_passwordLineView];
        [_passwordLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.usernameLineView).offset(60);
            make.left.right.height.equalTo(self.usernameLineView);
            make.right.equalTo(self.frontBlockView).offset(-28);
        }];
    }
    return _passwordLineView;
}

- (UITextField *)passwordTextField {
    if (_passwordTextField == nil) {
        _passwordTextField = [[UITextField alloc] init];
        _passwordTextField.placeholder = @"password";
        _passwordTextField.font = [UIFont systemFontOfSize:14];
        _passwordTextField.secureTextEntry = YES;
        _passwordTextField.delegate = self;
        [self.frontBlockView addSubview:_passwordTextField];
        [_passwordTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.passwordLineView.mas_top);
            make.left.equalTo(self.passwordLineView).offset(6);
            make.right.equalTo(self.passwordLineView);
        }];
    }
    return _passwordTextField;
}

- (UIButton *)loginButton {
    if (_loginButton == nil) {
        UIImage *image = [UIImage imageNamed:@"sparrow_login_button"
                                    inBundle:[SPRCommonData bundle]
               compatibleWithTraitCollection:nil];
        _loginButton = [[UIButton alloc] init];
        _loginButton.backgroundColor = [UIColor clearColor];
        [_loginButton setImage:image forState:UIControlStateNormal];
        _loginButton.layer.masksToBounds = YES;
        _loginButton.layer.cornerRadius = 25;
        [_loginButton addTarget:self
                         action:@selector(loginButtonClicked)
               forControlEvents:UIControlEventTouchUpInside];

        UIView *shadowView = [[UIView alloc] init];
        shadowView.backgroundColor = [UIColor whiteColor];
        shadowView.layer.shadowColor = [UIColor colorWithHexString:@"000000"].CGColor;
        shadowView.layer.shadowOpacity = 0.2f;
        shadowView.layer.shadowOffset = CGSizeMake(0,6);
        shadowView.layer.shadowRadius = 14;
        shadowView.layer.cornerRadius = 25;

        [self.frontBlockView addSubview:shadowView];
        [self.frontBlockView addSubview:_loginButton];
        [_loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.frontBlockView);
            make.width.height.equalTo(@(50));
            make.bottom.equalTo(self.frontBlockView).offset(-25);
        }];
        [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_loginButton);
        }];
    }
    return _loginButton;
}

- (UIImageView *)catImageView {
    if (_catImageView == nil) {
        UIImage *image = [UIImage imageNamed:@"sparrow_cat_with_openi_eyes"
                                    inBundle:[SPRCommonData bundle]
               compatibleWithTraitCollection:nil];
        _catImageView = [[UIImageView alloc] initWithImage:image];
        [self.backBlockView addSubview:_catImageView];
        [_catImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.backBlockView);
            make.bottom.equalTo(self.backBlockView);
            make.width.equalTo(@(50));
            make.height.equalTo(@(28));
        }];
    }
    return _catImageView;
}

- (UIButton *)dismissButton {
    if (_dismissButton == nil) {
        _dismissButton = [[UIButton alloc] init];
        UIImage *image = [UIImage imageNamed:@"sparrow_login_dismiss_button"
                                    inBundle:[SPRCommonData bundle]
               compatibleWithTraitCollection:nil];
        [_dismissButton addTarget:self
                           action:@selector(dismissButtonClicked)
                 forControlEvents:UIControlEventTouchUpInside];
        [_dismissButton setImage:image forState:UIControlStateNormal];
        [self.view addSubview:_dismissButton];
        [_dismissButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX);
            make.bottom.equalTo(self.view).offset(-10);
            make.width.equalTo(@(116));
            make.height.equalTo(@(48));
        }];
    }
    return _dismissButton;
}

@end
