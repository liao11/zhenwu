//
//  AdTimingBannerDelegate.h
//  AdTiming SDK
//
//  Copyright 2017 AdTiming Inc. All rights reserved.
//
#import <Foundation/Foundation.h>

@class AdTimingBanner;

NS_ASSUME_NONNULL_BEGIN

/// The methods declared by the AdTimingBannerDelegate protocol allow the adopting delegate to respond to messages from the AdTimingBanner class and thus respond to operations such as whether the ad has been loaded, the person has clicked the ad.
@protocol AdTimingBannerDelegate<NSObject>

@optional

/// Sent when an ad has been successfully loaded.
- (void)adtimingBannerDidLoad:(AdTimingBanner *)banner;

/// Sent after an AdTimingBanner fails to load the ad.
- (void)adtimingBannerDidFailToLoad:(AdTimingBanner *)banner withError:(NSError *)error;

/// Sent immediately before the impression of an AdTimingBanner object will be logged.
- (void)adtimingBannerWillExposure:(AdTimingBanner *)banner;

/// Sent after an ad has been clicked by the person.
- (void)adtimingBannerDidClick:(AdTimingBanner *)banner;

/// Sent when a banner is about to present a full screen content
- (void)adtimingBannerWillPresentScreen:(AdTimingBanner *)banner;

/// Sent after a full screen content has been dismissed.
- (void)adtimingBannerDidDismissScreen:(AdTimingBanner *)banner;

 /// Sent when a user would be taken out of the application context.
- (void)adtimingBannerWillLeaveApplication:(AdTimingBanner *)banner;

@end

NS_ASSUME_NONNULL_END
