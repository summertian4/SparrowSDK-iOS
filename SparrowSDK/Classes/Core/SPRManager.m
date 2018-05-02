//
//  SPRFloatBallWindow.m
//  AFNetworking
//
//  Created by 周凌宇 on 2018/3/8.
//

#import "SPRManager.h"
#import "SPRFloatingBall.h"
#import "SPRWindow.h"
#import "SPRControlCenterViewController.h"
#import "SPRLoginViewController.h"
#import "SPRProjectsData.h"
#import "SPRCommonData.h"
#import "SPRCacheManager.h"
#import "SPRProject.h"
#import "SPRProgressHUD.h"
#import "SPRHTTPSessionManager.h"
#import "SPRApi.h"

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
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(motionEnd:)
                                                     name:kSPRnotificationMotionEvent
                                                   object:nil];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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

-(void)motionEnd:(NSNotification *)notification {
    [self refreshApis];
}

- (void)refreshApis {
    __weak __typeof(self)weakSelf = self;

    NSSet *projects = [SPRCacheManager getProjectsFromCache];
    if (projects == nil || projects.count == 0) {
        [SPRToast showWithMessage:@"请先选择项目" from:self.window.rootViewController.view];
        return;
    }

    NSMutableArray *projectIds = [NSMutableArray array];
    for (SPRProject *project in projects) {
        [projectIds addObject:@(project.project_id)];
    }
    [SPRProgressHUD showHUDAddedTo:self.window.rootViewController.view animated:YES];
    [SPRHTTPSessionManager GET:@"/frontend/api/fetch"
                    parameters:@{@"project_id": projectIds}
                       success:^(NSURLSessionDataTask *task, SPRResponse *response) {
                           __strong __typeof(weakSelf)strongSelf = weakSelf;
                           if (strongSelf) {
                               [SPRProgressHUD hideHUDForView:strongSelf.window.rootViewController.view animated:YES];
                               NSMutableArray *apis = [SPRApi apisWithDictArray:response.data];
                               if (apis.count != 0) {
                                   [SPRCacheManager cacheApis:apis];
                                   [SPRToast showWithMessage:@"刷新数据成功" from:strongSelf.window.rootViewController.view];
                                   [[NSNotificationCenter defaultCenter] postNotificationName:kSPRnotificationNeedRefreshData object:nil];
                               }
                           }
                       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                           SPRLog(@"%@", error);
                           __strong __typeof(weakSelf)strongSelf = weakSelf;
                           if (strongSelf) {
                               [SPRProgressHUD hideHUDForView:strongSelf.window.rootViewController.view animated:YES];
                               [SPRToast showWithMessage:@"拉取 API 失败" from:strongSelf.window.rootViewController.view];
                           }
                       }];
}

- (UIWindow *)window {
    if (_window == nil) {
        _window = [[SPRWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
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
