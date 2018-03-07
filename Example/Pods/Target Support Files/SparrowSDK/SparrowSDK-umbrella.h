#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "SPRFloatBall.h"
#import "SPRFloatBallWindow.h"
#import "SPRFloatBallWindowManager.h"
#import "SPRLoginViewController.h"
#import "SPRManagerViewController.h"
#import "SPRURLProtocol.h"
#import "SPRURLSessionConfiguration.h"

FOUNDATION_EXPORT double SparrowSDKVersionNumber;
FOUNDATION_EXPORT const unsigned char SparrowSDKVersionString[];

