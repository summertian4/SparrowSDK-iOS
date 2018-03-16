//
//  SPRCacheManager.h
//  AFNetworking
//
//  Created by 周凌宇 on 2018/3/12.
//

#import <Foundation/Foundation.h>

@class SPRApi;
@class SPRProject;
@interface SPRCacheManager : NSObject

@property (nonatomic, strong) NSArray<SPRApi *> *apis;
@property (nonatomic, strong) NSSet<SPRProject *> *projects;

+ (instancetype)sharedInstance;

+ (void)cacheApis:(NSArray<SPRApi *> *)apis;
+ (NSArray<SPRApi *> *)getApisFromCache;

+ (void)cacheProjects:(NSSet<SPRProject *> *)projects;
+ (NSSet<SPRProject *> *)getProjectsFromCache;

@end
