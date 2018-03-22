//
//  SparrowSDK.m
//  AFNetworking
//
//  Created by 周凌宇 on 2018/3/22.
//

#import "SparrowSDK.h"
#import "SPRURLProtocol.h"
#import "SPRFloatBallWindowManager.h"
#import "SPRCommonData.h"
#import "SPRControlCenterViewController.h"

@implementation SparrowSDK

+ (void)startWithOption:(SPROptions *)options {
    if (options.hostURL != nil) {
        [SPRCommonData setSparrowHost:options.hostURL];
    }
    [SPRURLProtocol start];
    [SPRFloatBallWindowManager showWindow:options.ballClickedCallback];
}

+ (UIViewController *)controlCenter {
    UIViewController *vc = [[SPRControlCenterViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    return nav;
}

@end
