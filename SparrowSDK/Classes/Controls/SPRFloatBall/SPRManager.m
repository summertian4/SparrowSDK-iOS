//
//  SPRFloatBallWindow.m
//  AFNetworking
//
//  Created by 周凌宇 on 2018/3/8.
//

#import "SPRManager.h"
#import "SPRFloatingBall.h"
#import "SPRFloatBallWindow.h"
#import "SPRControlCenterViewController.h"
#import "SPRLoginViewController.h"
#import "SPRProjectsData.h"
#import "SPRCommonData.h"

@interface SPRManager ()

@property (nonatomic, copy) BallClickedCustomCallback ballClickedCustomCallback;
@property (nonatomic, assign) BOOL showedManagerVC;
@property (nonatomic, strong) SPRFloatingBall *floatingBall;
@end

@implementation SPRManager

+ (instancetype)sharedInstance {
    static SPRManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SPRManager alloc] init];
    });
    return instance;
}

- (instancetype)init {
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(loginSuccess:)
                                                     name:kSPRnotificationLoginSuccess
                                                   object:nil];
    }
    return self;
}

#pragma mark - Public

+ (void)showWindow:(BallClickedCallback)ballClickedCallback {
    [[self sharedInstance] setBallClickedCustomCallback:ballClickedCallback];
    [[self sharedInstance] window].hidden = NO;
    [[self sharedInstance] window].rootViewController.view.userInteractionEnabled = YES;
}

+ (void)dismissWindow {
    [[self sharedInstance] window].hidden = YES;
}

+ (void)clickBall {
    [[[self sharedInstance] floatingBall] click];
}

- (void)addFloatBall {
    __weak __typeof(self)weakSelf = self;
    self.floatingBall = [[SPRFloatingBall alloc] initWithCallBack:^{
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (strongSelf) {
            if (strongSelf.ballClickedCustomCallback) {
                strongSelf.ballClickedCustomCallback();
                return;
            }
            if (strongSelf.showedManagerVC == NO) {
                SPRControlCenterViewController *vc = [[SPRControlCenterViewController alloc] init];
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                strongSelf.controlCenterVC = vc;
                [strongSelf.window.rootViewController
                 presentViewController:nav
                 animated:YES
                 completion:nil];
            } else {
                [strongSelf.window.rootViewController.presentedViewController
                 dismissViewControllerAnimated:YES
                 completion:^{
                     [strongSelf.window.rootViewController
                      dismissViewControllerAnimated:YES
                      completion:nil];
                 }];
            }
            self.showedManagerVC = !strongSelf.showedManagerVC;
        }
    }];
    self.floatingBall.frame = CGRectMake(0, 20, 50, 50);
    [self.window.rootViewController.view addSubview:self.floatingBall];
}

+ (void)jumpToLoginVC {
    [[SPRManager sharedInstance] jumpToLoginVC];
}

- (void)jumpToLoginVC {
    UIViewController *vc = [[SPRLoginViewController alloc] init];
    UIViewController *rootVC = [SPRManager sharedInstance].window.rootViewController;
    UIViewController *presentationVC;
    if (rootVC.presentedViewController) {
        presentationVC = rootVC.presentedViewController;
    } else {
        presentationVC = rootVC;
    }
    [presentationVC presentViewController:vc animated:YES completion:nil];
}

#pragma mark - Private

-(void)loginSuccess:(NSNotification *)notification {
    
}

- (UIWindow *)window {
    if (_window == nil) {
        _window = [[SPRFloatBallWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _window.windowLevel = CGFLOAT_MAX;

        UIViewController *rootVC = [UIViewController new];

        _window.rootViewController = rootVC;
        _window.rootViewController.view.backgroundColor = [UIColor clearColor];
        _window.rootViewController.view.userInteractionEnabled = NO;
        _window.hidden = YES;
        _window.userInteractionEnabled = YES;

        [self addFloatBall];
    }
    return _window;
}

@end
