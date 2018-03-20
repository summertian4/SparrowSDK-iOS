//
//  SPRBaseViewController.h
//  AFNetworking
//
//  Created by 周凌宇 on 2018/3/16.
//

#import <UIKit/UIKit.h>

@interface SPRBaseViewController : UIViewController

- (void)showHUD;
- (void)hideHUD;

- (void)setRightBarWithTitle:(NSString *)title action:(SEL)action;
- (void)setRightBarWithImage:(UIImage *)image action:(SEL)action;

@end
