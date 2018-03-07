//
//  SPRFloatBall.m
//  AFNetworking
//
//  Created by 周凌宇 on 2018/3/8.
//

#import "SPRFloatBall.h"

@interface SPRFloatBall ()

@property (nonatomic, strong) UIWindow *window;
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
    }
    return self;
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
