//
//  SPRToast.m
//  AFNetworking
//
//  Created by 周凌宇 on 2018/3/16.
//

#import "SPRToast.h"
#import <SVProgressHUD/SVProgressHUD.h>

@implementation SPRToast

+ (void)showWithMessage:(NSString *)message {
    [SVProgressHUD showInfoWithStatus:message];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
                       [SVProgressHUD dismiss];
                   });
}

+ (void)showHUD {
    [SVProgressHUD show];
}

+ (void)dismissHUD {
    [SVProgressHUD dismiss];
}

@end
