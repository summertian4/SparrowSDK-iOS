//
//  SPRFloatBallWindow.h
//  AFNetworking
//
//  Created by 周凌宇 on 2018/3/8.
//

#import <UIKit/UIKit.h>

@class SPRFloatBallWindow;
@class SPRControlCenterViewController;

typedef void (^BallClickedCustomCallback)(void);
@interface SPRFloatBallWindowManager : NSObject

@property (nonatomic, strong) SPRFloatBallWindow *window;
@property (nonatomic, strong) SPRControlCenterViewController *controlCenterVC;

+ (instancetype)sharedInstance;
+ (void)showWindow:(BallClickedCustomCallback)ballClickedCustomCallback;
+ (void)dismissWindow;

+ (void)clickBall;

+ (void)jumpToLoginVC;

@end
