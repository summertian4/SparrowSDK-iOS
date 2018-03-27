//
//  SPRViewController.m
//  SparrowSDK
//
//  Created by summertian4 on 03/07/2018.
//  Copyright (c) 2018 summertian4. All rights reserved.
//

#import "SPRViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface SPRViewController ()

@end

@implementation SPRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)getRequest {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    __weak __typeof(self)weakSelf = self;
    [manager GET:@"https://book.douban.com/ithil_j/activity/book_annual2017/widget/0"
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSData *unicodedStringData = [[responseObject description] dataUsingEncoding:NSUTF8StringEncoding];
             NSString *stringValue =  [[NSString alloc] initWithData:unicodedStringData encoding:NSNonLossyASCIIStringEncoding];
             [weakSelf showAlert:stringValue];
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             [weakSelf showAlert:error.domain];
         }];
}

- (IBAction)postRequest {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    __weak __typeof(self)weakSelf = self;
    [manager POST:@"https://www.zhihu.com/api/v4/home/sidebar"
      parameters:nil
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSData *unicodedStringData = [[responseObject description] dataUsingEncoding:NSUTF8StringEncoding];
             NSString *stringValue =  [[NSString alloc] initWithData:unicodedStringData encoding:NSNonLossyASCIIStringEncoding];
             [weakSelf showAlert:stringValue];
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             [weakSelf showAlert:error.domain];
         }];
}

- (IBAction)putRequest {
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] init];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    __weak __typeof(self)weakSelf = self;
    [manager PUT:@"https://www.baidu.com/s"
      parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
          NSData *unicodedStringData = [[responseObject description] dataUsingEncoding:NSUTF8StringEncoding];
          NSString *stringValue =  [[NSString alloc] initWithData:unicodedStringData encoding:NSNonLossyASCIIStringEncoding];
          [weakSelf showAlert:stringValue];
      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
          [weakSelf showAlert:error.domain];
      }];
}

- (void)showAlert:(NSString *)message {
    UIAlertController *uiAlertController=
    [UIAlertController alertControllerWithTitle:@""
                                        message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [uiAlertController addAction:action];
    [self presentViewController:uiAlertController animated:YES completion:nil];
}

@end
