//
//  SPRBaseViewController.m
//  AFNetworking
//
//  Created by 周凌宇 on 2018/3/16.
//

#import "SPRBaseViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>

@interface SPRBaseViewController ()

@end

@implementation SPRBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = SPRThemeColor;
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
}

- (void)setRightBarWithTitle:(NSString *)title action:(nullable SEL)action {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:title
                                                                              style:UIBarButtonItemStyleDone target:self
                                                                             action:action];
}

- (void)setRightBarWithImage:(UIImage *)image action:(nullable SEL)action {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self action:action];
}

@end
