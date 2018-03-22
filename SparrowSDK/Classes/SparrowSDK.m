//
//  SparrowSDK.m
//  AFNetworking
//
//  Created by 周凌宇 on 2018/3/22.
//

#import "SparrowSDK.h"
#import "SPRURLProtocol.h"
#import "SPRFloatBallWindowManager.h"

@implementation SparrowSDK

+ (void)startWithOption:(SPROptions *)options {
    [SPRURLProtocol start];
    [SPRFloatBallWindowManager showWindow];
}

@end
