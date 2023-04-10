//
//  AdTimingInterstitial.h
//  AdTiming
//
//  Created by M on 2019/6/14.
//  Copyright © 2019 AdTiming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AdTimingAdSingletonInterface.h"
#import "AdTimingInterstitialDelegate.h"


NS_ASSUME_NONNULL_BEGIN

@interface AdTimingInterstitial : AdTimingAdSingletonInterface

/// Returns the singleton instance.
+ (instancetype)sharedInstance;

/// Add delegate
- (void)addDelegate:(id<AdTimingInterstitialDelegate>)delegate;

/// Remove delegate
- (void)removeDelegate:(id<AdTimingInterstitialDelegate>)delegate;

/// Indicates whether the interstitial video is ready to show ad.
- (BOOL)isReady;

/// Indicates whether the scene has reached the display frequency.
- (BOOL)isCappedForScene:(NSString *)sceneName;

/// Presents the interstitial video ad modally from the specified view controller.
/// Parameter viewController: The view controller that will be used to present the video ad.
/// Parameter sceneName: The name of th ad scene. Default scene if null.
- (void)showWithViewController:(UIViewController *)viewController scene:(NSString *)sceneName;

@end

NS_ASSUME_NONNULL_END
