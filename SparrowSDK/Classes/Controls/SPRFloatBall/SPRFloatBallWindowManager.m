//
//  SPRFloatBallWindow.m
//  AFNetworking
//
//  Created by 周凌宇 on 2018/3/8.
//

#import "SPRFloatBallWindowManager.h"
#import "SPRFloatBall.h"
#import "SPRFloatBallWindow.h"

@interface SPRFloatBallWindowManager ()

@property (nonatomic, copy) BallClickedCallback ballClickedCallback;
@property (nonatomic, strong) UIWindow *window;

@end

@implementation SPRFloatBallWindowManager

+ (instancetype)sharedInstance {
    static SPRFloatBallWindowManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SPRFloatBallWindowManager alloc] init];
    });
    return instance;
}

#pragma mark - Public

+ (void)showWindow:(BallClickedCallback)ballClickedCallback {
    [[self sharedInstance] setBallClickedCallback:ballClickedCallback];
    [[self sharedInstance] window].hidden = NO;
    [[self sharedInstance] window].rootViewController.view.userInteractionEnabled = YES;
}

+ (void)dismissWindow {
    [[self sharedInstance] window].hidden = YES;
}

+ (void)showFloatBall {

}

- (void)addFloatBall {
    SPRFloatBall *ball = [[SPRFloatBall alloc] initWithCallBack:self.ballClickedCallback];
    [self.window.rootViewController.view addSubview:ball];
}

+ (void)dismissFloatBall {

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
        [_window makeKeyAndVisible];

        [self addFloatBall];
    }
    return _window;
}

@end
