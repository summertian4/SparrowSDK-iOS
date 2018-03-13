//
//  SPRApi.h
//  AFNetworking
//
//  Created by 周凌宇 on 2018/3/12.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    Disabled = 0,
    Mock = 1,
    UseOther = 2
} SPRApiStatus;

@interface SPRApi : NSObject <NSCoding>

@property (nonatomic, assign) long api_id;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy) NSString *method;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *note;
@property (nonatomic, assign) SPRApiStatus status;
@property (nonatomic, assign) long project_id;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (NSMutableArray *)apisWithDictArray:(NSArray *)dictArr;

@end
