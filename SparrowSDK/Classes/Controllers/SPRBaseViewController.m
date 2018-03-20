//
//  SPRBaseViewController.m
//  AFNetworking
//
//  Created by 周凌宇 on 2018/3/16.
//

#import "SPRBaseViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface SPRBaseViewController ()

@end

@implementation SPRBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
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

- (void)showHUD {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)hideHUD {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

@end
