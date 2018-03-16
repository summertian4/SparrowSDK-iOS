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
    // Do any additional setup after loading the view.
}

- (void)showHUD {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)hideHUD {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

@end
