//
//  SPRHTTPSessionManager.h
//  AFNetworking
//
//  Created by 周凌宇 on 2018/3/9.
//

#import <AFNetworking/AFNetworking.h>

@interface SPRHTTPSessionManager : AFHTTPSessionManager

+ (SPRHTTPSessionManager * _Nullable)defaultManager;
+ (void)updateBaseURL;

+ (void)GET:(NSString * _Nullable)URLString
 parameters:(id _Nullable)parameters
    success:(void (^ _Nullable)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
    failure:(void (^ _Nullable)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure;

+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
     failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure;

+ (void)POST:(NSString *)URLString
                    parameters:(id)parameters
     constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
                      progress:(nullable void (^)(NSProgress * _Nonnull))uploadProgress
                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

@end
