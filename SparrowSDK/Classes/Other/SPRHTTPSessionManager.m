//
//  SPRHTTPSessionManager.m
//  AFNetworking
//
//  Created by 周凌宇 on 2018/3/9.
//

#import "SPRHTTPSessionManager.h"
#import "SPRCommonData.h"
#import "SPRManager.h"

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

+ (void)GET:(NSString * _Nullable)URLString
 parameters:(id _Nullable)parameters
    success:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
    failure:(void (^ _Nullable)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    [[SPRHTTPSessionManager defaultManager] GET:URLString
      parameters:parameters
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             [SPRHTTPSessionManager handleSuccessBlock:success
                                               failure:failure
                                                  task:task responseObject:responseObject];
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             failure(task, error);
         }];
}

+ (void)POST:(NSString *)URLString
                    parameters:(id)parameters
                       success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
                       failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure {
    [[SPRHTTPSessionManager defaultManager] POST:URLString
                                      parameters:parameters
                                        progress:nil
                                         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                             [SPRHTTPSessionManager handleSuccessBlock:success
                                                                               failure:failure
                                                                                  task:task responseObject:responseObject];
                                         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                                             failure(task, error);
                                         }
     ];
}

+ (void)POST:(NSString *)URLString
                    parameters:(id)parameters
     constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                      progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    [[SPRHTTPSessionManager defaultManager] POST:URLString
                                      parameters:parameters
                       constructingBodyWithBlock:block
                                        progress:uploadProgress
                                         success:^(NSURLSessionDataTask *task, id responseObject) {
                                             [SPRHTTPSessionManager handleSuccessBlock:success
                                                                               failure:failure
                                                                                  task:task responseObject:responseObject];
                                         }
                                         failure:failure];
}

+ (void)handleSuccessBlock:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                   failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
                      task:(NSURLSessionDataTask *)task
            responseObject:(id)responseObject {
    if ([responseObject[@"code"] isEqual:@(200)]) {
        success(task, responseObject);
    } else if ([responseObject[@"code"] isEqual:@(901)]) {
        NSString *domain = @"请先登录";
        NSError *error = [[NSError alloc] initWithDomain:domain
                                                    code:(NSInteger)responseObject[@"code"]
                                                userInfo:@{}];
        // 跳转登录
        [SPRManager jumpToLoginVC];
        failure(task, error);
    } else {
        NSString *domain = responseObject[@"message"];
        NSError *error = [[NSError alloc] initWithDomain:domain
                                                    code:(NSInteger)responseObject[@"code"]
                                                userInfo:@{}];
        failure(task, error);
    }
}

@end
