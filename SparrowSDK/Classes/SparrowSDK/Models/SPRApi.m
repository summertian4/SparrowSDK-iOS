//
//  SPRApi.m
//  AFNetworking
//
//  Created by 周凌宇 on 2018/3/12.
//

#import "SPRApi.h"

@implementation SPRApi

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        _api_id = [dict[@"api_id"] longValue];
        _path = dict[@"path"];
        _method = dict[@"method"];
        _name = dict[@"name"];
        _note = dict[@"note"];
        switch ([dict[@"status"] intValue]) {
            case 0:
                _status = Disabled;
                break;
            case 1:
                _status = Mock;
                break;
            case 2:
                _status = UseOther;
                break;
            default:
                break;
        }
    }
    return self;
}

+ (NSMutableArray *)apisWithDictArray:(NSArray *)dictArr {
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in dictArr) {
        SPRApi *api = [[SPRApi alloc] initWithDict:dic];
        [array addObject:api];
    }
    return array;
}

@end
