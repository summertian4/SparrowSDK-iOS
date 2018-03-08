//
//  SPRProjectsData.m
//  AFNetworking
//
//  Created by 周凌宇 on 2018/3/9.
//

#import "SPRProjectsData.h"
#import "SPRProject.h"

@implementation SPRProjectsData

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        // convert
        _currentPage = (int)dict[@"current_page"];
        _total = (int)dict[@"total"];
        _limit = (int)dict[@"limit"];
        NSArray<NSDictionary *> *array = dict[@"projects"];
        _projects = [self projectsWithDictArray:array];
    }
    return self;
}

- (NSMutableArray<SPRProject *> *)projectsWithDictArray:(NSArray<NSDictionary *> *)array {
    NSMutableArray<SPRProject *> *projects = [NSMutableArray array];
    for (NSDictionary *projectDict in array) {
        SPRProject *project = [[SPRProject alloc] initWithDict:projectDict];
        [projects addObject:project];
    }
    return projects;
}

@end
