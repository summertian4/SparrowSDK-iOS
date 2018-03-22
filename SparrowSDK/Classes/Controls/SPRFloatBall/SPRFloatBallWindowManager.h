//
//  SPRFloatBallWindow.h
//  AFNetworking
//
//  Created by 周凌宇 on 2018/3/8.
//

#import <UIKit/UIKit.h>

typedef void (^BallClickedCallback)(void);
@interface SPRFloatBallWindowManager : NSObject

+ (void)showWindow:(BallClickedCallback)ballClickedCallback;
+ (void)dismissWindow;

+ (void)showFloatBall;
+ (void)dismissFloatBall;

@end
