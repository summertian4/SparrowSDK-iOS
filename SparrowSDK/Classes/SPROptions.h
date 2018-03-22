//
//  SPROptions.h
//  AFNetworking
//
//  Created by 周凌宇 on 2018/3/22.
//

#import <Foundation/Foundation.h>

typedef void (^BallClickedCallback)(void);
@interface SPROptions : NSObject

@property (nonatomic, copy) NSString *hostURL;
@property (nonatomic, copy) BallClickedCallback ballClickedCallback;

@end
