//
//  SPRProject.h
//  AFNetworking
//
//  Created by 周凌宇 on 2018/3/9.
//

#import <Foundation/Foundation.h>

@interface SPRProject : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) int status;
@property (nonatomic, copy) NSString *note;
@property (nonatomic, assign) long project_id;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic, copy) NSString *createTime;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end
