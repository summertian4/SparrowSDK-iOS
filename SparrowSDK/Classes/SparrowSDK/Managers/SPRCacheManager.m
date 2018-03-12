//
//  SPRCacheManager.m
//  AFNetworking
//
//  Created by 周凌宇 on 2018/3/12.
//

#import "SPRCacheManager.h"
#import "SPRApi.h"

@implementation SPRCacheManager

- (NSArray *)apis {
    if (_apis == nil) {
        _apis = [SPRCacheManager getApisFromCache];
    }
    return _apis;
}

+ (instancetype)sharedInstance {
    static SPRCacheManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SPRCacheManager alloc] init];
    });
    return instance;
}

+ (void)load {
    NSString *cacheDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)
                            firstObject]
                           stringByAppendingString:@"/com.zhoulingyu.sparrow"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:cacheDir]) {
        [fileManager createDirectoryAtPath:cacheDir
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:nil];
    }
}

+ (NSString *)cacheDir {
    NSString *cacheDir = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)
                            firstObject]
                           stringByAppendingString:@"/com.zhoulingyu.sparrow"];
    return cacheDir;
}

+ (void)cacheApis:(NSArray<SPRApi *> *)apis {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:apis];
    BOOL result = [data writeToFile:[self apisPath] atomically:YES];

    if (result == NO) {
        NSLog(@"Caching API failed");
        return;
    }
    SPRCacheManager *manager = [SPRCacheManager sharedInstance];
    manager.apis = apis;
}

+ (NSArray<SPRApi *> *)getApisFromCache {
    NSData *data = [[NSData alloc]initWithContentsOfFile:[self apisPath]];
    NSArray<SPRApi *> *apis =  [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return apis;
}

+ (NSString *)apisPath {
    return [[self cacheDir] stringByAppendingString:@"/apis"];
}

@end
