//
//  SparrowSDK.h
//  AFNetworking
//
//  Created by 周凌宇 on 2018/3/22.
//

#import <Foundation/Foundation.h>
#import "SPROptions.h"

@class SPRControlCenterViewController;
@interface SparrowSDK : NSObject

+ (void)startWithOption:(SPROptions *)options;
+ (UIViewController *)controlCenter;

@end
