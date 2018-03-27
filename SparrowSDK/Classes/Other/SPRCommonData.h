//
//  SPRCommonData.h
//  AFNetworking
//
//  Created by 周凌宇 on 2018/3/12.
//

#import <Foundation/Foundation.h>
#import "UIColor+SPRAddtion.h"

#define SPRThemeColor ([UIColor colorWithHexString:@"04D1B2"])

@interface SPRCommonData : NSObject

+ (NSBundle *)bundle;
+ (NSString *)sparrowHost;
+ (void)setSparrowHost:(NSString *)hostStr;

@end
