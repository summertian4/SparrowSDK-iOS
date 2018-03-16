//
//  SPRManagerViewController.h
//  AFNetworking
//
//  Created by 周凌宇 on 2018/3/8.
//

#import <UIKit/UIKit.h>

typedef void (^DidFetchedDataCallBack)(void);
@interface SPRProjectListViewController : UIViewController

@property (nonatomic, copy, nullable) DidFetchedDataCallBack didFetchedDataCallBack;

@end
