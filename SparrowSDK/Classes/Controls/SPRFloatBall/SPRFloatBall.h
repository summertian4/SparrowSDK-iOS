//
//  SPRFloatBall.h
//  AFNetworking
//
//  Created by 周凌宇 on 2018/3/8.
//

#import <UIKit/UIKit.h>

typedef void (^BallClickedCallback)(void);
@interface SPRFloatBall : UIView

@property (nonatomic, copy) BallClickedCallback ballClickedCallback;

+ (void)dismiss;
- (instancetype)initWithCallBack:(BallClickedCallback)callback;

@end
