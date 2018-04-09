//
//  SPRFloatingBall.h
//  AFNetworking
//
//  Created by 周凌宇 on 2018/3/8.
//

#import <UIKit/UIKit.h>

typedef void (^BallClickedCallback)(void);
typedef void (^BallClickedCustomCallback)(void);
@interface SPRFloatingBall : UIView

@property (nonatomic, copy, readonly) BallClickedCallback ballClickedCallback;
@property (nonatomic, copy) BallClickedCustomCallback ballClickedCustomCallback;

+ (void)dismiss;
- (instancetype)initWithCallBack:(BallClickedCallback)callback;
- (instancetype)initWithCustomCallBack:(BallClickedCustomCallback)callback;

@end
