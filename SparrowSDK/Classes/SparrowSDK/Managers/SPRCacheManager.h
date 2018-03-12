//
//  SPRCacheManager.h
//  AFNetworking
//
//  Created by 周凌宇 on 2018/3/12.
//

#import <Foundation/Foundation.h>

@class SPRApi;
@interface SPRCacheManager : NSObject

@property (nonatomic, strong) NSArray<SPRApi *> *apis;

+ (instancetype)sharedInstance;
+ (void)cacheApis:(NSArray<SPRApi *> *)apis;
+ (NSArray<SPRApi *> *)getApisFromCache;

@end
