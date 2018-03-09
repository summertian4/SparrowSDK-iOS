//
//  SPRProject.m
//  AFNetworking
//
//  Created by 周凌宇 on 2018/3/9.
//

#import "SPRProject.h"

@implementation SPRProject

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        _name = dict[@"name"];
        _status = [dict[@"status"] intValue];
        _note = dict[@"note"];
        _project_id = [dict[@"project_id"] longValue];
        _updateTime = dict[@"updateTime"];
        _createTime = dict[@"createTime"];
    }
    return self;
}

@end
