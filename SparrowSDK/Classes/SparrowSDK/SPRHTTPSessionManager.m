//
//  SPRHTTPSessionManager.m
//  AFNetworking
//
//  Created by 周凌宇 on 2018/3/9.
//

#import "SPRHTTPSessionManager.h"

@implementation SPRHTTPSessionManager

+ (SPRHTTPSessionManager *)defaultManager {
    static SPRHTTPSessionManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SPRHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://localhost:8000"]];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
    });
    return manager;
}

- (void)GET:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                      failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
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
