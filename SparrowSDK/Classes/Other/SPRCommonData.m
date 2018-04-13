//
//  SPRCommonData.m
//  AFNetworking
//
//  Created by 周凌宇 on 2018/3/12.
//

#import "SPRCommonData.h"

NSString * const kSPRnotificationLoginSuccess = @"kSPRnotificationLoginSuccess";
NSString * const kSPRnotificationMotionEvent = @"kSPRnotificationMotionEvent";
NSString * const kSPRnotificationNeedRefreshData = @"kSPRnotificationNeedRefreshData";

NSString * const kSPRUDSyncWithShakeSwitch = @"kSPRUDSyncWithShakeSwitch";

NSString * const SparrowHostKey = @"SparrowHostKey";

@implementation SPRCommonData

+ (NSBundle *)bundle {
    NSString *bundlePath = [[NSBundle bundleForClass:[self class]].resourcePath
                            stringByAppendingPathComponent:@"/SparrowSDK.bundle"];
    NSBundle *resource_bundle = [NSBundle bundleWithPath:bundlePath];
    return resource_bundle;
}

+ (NSString *)sparrowHost {
    NSString *result = [[NSUserDefaults standardUserDefaults] objectForKey:SparrowHostKey];
    if (result == nil) {
        result = @"http://localhost:8000";
    }
    return result;
}

+ (void)setSparrowHost:(NSString *)hostStr {
    [[NSUserDefaults standardUserDefaults] setObject:hostStr forKey:SparrowHostKey];
}

@end
