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

+ (void)clearApisFromCache {
    NSFileManager *fileMger = [NSFileManager defaultManager];
    NSString *path = [self apisPath];

    BOOL exist = [fileMger fileExistsAtPath:path];
    if (exist) {
        NSError *err;
        [fileMger removeItemAtPath:path error:&err];
        if (err) {
            NSLog(@"删除 Projects 缓存失败");
        } else {
            [SPRCacheManager sharedInstance].apis = nil;
        }
    }
}

+ (void)cacheProjects:(NSSet<SPRProject *> *)projects {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:projects];
    BOOL result = [data writeToFile:[self projectsPath] atomically:YES];

    if (result == NO) {
        NSLog(@"Caching API failed");
        return;
    }
    SPRCacheManager *manager = [SPRCacheManager sharedInstance];
    manager.projects = projects;
}

+ (NSSet<SPRProject *> *)getProjectsFromCache {
    NSData *data = [[NSData alloc]initWithContentsOfFile:[self projectsPath]];
    NSSet<SPRProject *> *projects =  [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return projects;
}

+ (void)clearProjectsFromCache {
    NSFileManager *fileMger = [NSFileManager defaultManager];
    NSString *path = [self projectsPath];

    BOOL exist = [fileMger fileExistsAtPath:path];
    if (exist) {
        NSError *err;
        [fileMger removeItemAtPath:path error:&err];
        if (err) {
            NSLog(@"删除 Projects 缓存失败");
        } else {
            [SPRCacheManager sharedInstance].apis = nil;
        }
    }
}

+ (NSString *)apisPath {
    return [[self cacheDir] stringByAppendingString:@"/apis"];
}

+ (NSString *)projectsPath {
    return [[self cacheDir] stringByAppendingString:@"/projects"];
}

@end
