//
//  SPRHTTPSessionManager.m
//  AFNetworking
//
//  Created by 周凌宇 on 2018/3/9.
//

#import "SPRHTTPSessionManager.h"
#import "SPRCommonData.h"

@implementation SPRHTTPSessionManager

static SPRHTTPSessionManager *manager;

+ (SPRHTTPSessionManager *)defaultManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SPRHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:[SPRCommonData sparrowHost]]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    });
    return manager;
}

+ (void)updateBaseURL {
    manager = [[SPRHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:[SPRCommonData sparrowHost]]];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
}

- (void)GET:(NSString * _Nullable)URLString
 parameters:(id _Nullable)parameters
    success:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
    failure:(void (^ _Nullable)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    [[SPRHTTPSessionManager defaultManager] GET:URLString
      parameters:parameters
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             if ([responseObject[@"code"] isEqual:@(200)]) {
                success(task, responseObject);
             } else {
                 NSString *domain = responseObject[@"message"];
                 NSError *error = [[NSError alloc] initWithDomain:domain
                                                             code:(NSInteger)responseObject[@"code"]
                                                         userInfo:@{}];
                 failure(task, error);
             }
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             failure(task, error);
         }];
}

@end
