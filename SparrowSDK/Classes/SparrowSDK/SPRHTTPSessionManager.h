//
//  SPRHTTPSessionManager.h
//  AFNetworking
//
//  Created by 周凌宇 on 2018/3/9.
//

#import <AFNetworking/AFNetworking.h>

@interface SPRHTTPSessionManager : AFHTTPSessionManager

+ (SPRHTTPSessionManager *)defaultManager;

- (void)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(NSURLSessionDataTask * _Nonnull, id _Nullable))success
    failure:(void (^)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull))failure;

@end
