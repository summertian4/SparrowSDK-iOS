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
    if ((self.userInteractionEnabled = NO) || (self.hidden == YES)) {
        return nil;
    }
    if (![self pointInside:point withEvent:event]) {
        return nil;
    }
    for (UIView *subView in self.subviews) {
        CGPoint subViewPoint = [self convertPoint:point toView:subView];
        UIView *view = [subView hitTest:subViewPoint withEvent:event];
        if (view == self.rootViewController.view) {
            return nil;
        }
        if (view) {
            return view;
        }
    }

    return self;
}

@end
