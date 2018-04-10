//
//  SPRFloatBallViewController.m
//  AFNetworking
//
//  Created by 周凌宇 on 2018/3/8.
//

#import "SPRFloatBallWindow.h"

@interface SPRFloatBallWindow ()

@end

@implementation SPRFloatBallWindow

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView * view = [super hitTest:point withEvent:event];
    if (view == self.rootViewController.view) {
        return nil;
    }
    return view;
}

@end
