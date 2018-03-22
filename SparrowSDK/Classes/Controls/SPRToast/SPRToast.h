//
//  SPRToast.h
//  AFNetworking
//
//  Created by 周凌宇 on 2018/3/16.
//

#import <UIKit/UIKit.h>

@interface SPRToast : UIView

+ (void)showWithMessage:(NSString *)message;
+ (void)showHUD;
+ (void)dismissHUD;

@end
