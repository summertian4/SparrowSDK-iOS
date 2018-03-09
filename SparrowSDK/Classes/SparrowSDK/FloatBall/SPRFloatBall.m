//
//  SPRFloatBall.m
//  AFNetworking
//
//  Created by 周凌宇 on 2018/3/8.
//

#import "SPRFloatBall.h"
#import "SPRProjectListViewController.h"

@interface SPRFloatBall ()

@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, assign) BOOL showedManagerVC;
@end

@implementation SPRFloatBall

- (instancetype)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, 40, 40);
        self.layer.cornerRadius = 20;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 1;
        self.layer.borderColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1].CGColor;
        self.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1];
        self.alpha = 0.2;

        UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleSingleTap:)];
        singleTapGesture.numberOfTapsRequired = 1;
        singleTapGesture.numberOfTouchesRequired  = 1;
        [self addGestureRecognizer:singleTapGesture];
    }
    return self;
}

-(void)handleSingleTap:(UIGestureRecognizer *)sender {
    if (self.showedManagerVC == NO) {
        UIViewController *vc = [[SPRProjectListViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [[UIApplication sharedApplication].keyWindow.rootViewController
         presentViewController:nav
         animated:YES
         completion:nil];
    } else {
#pragma mark - TODO
        [[UIApplication sharedApplication].keyWindow.rootViewController
         dismissViewControllerAnimated:YES
         completion:nil];
    }
    self.showedManagerVC = !self.showedManagerVC;
}

+ (instancetype)sharedInstance {
    static SPRFloatBall *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[SPRFloatBall alloc] init];
    });
    return instance;
}

+ (void)show {
    [[SPRFloatBall sharedInstance] window];
}

+ (void)dismiss {
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];
    CGPoint prePoint = [touch previousLocationInView:self];
    CGFloat offsetX = currentPoint.x - prePoint.x;
    CGFloat offsetY = currentPoint.y - prePoint.y;

    self.transform = CGAffineTransformTranslate(self.transform, offsetX, offsetY);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
}

@end
