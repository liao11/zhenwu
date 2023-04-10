# Chartboost for iOS

*Version 8.1.0*

The Chartboost iOS SDK is the cornerstone of the Chartboost network. It
provides the functionality for showing interstitials, More-Apps pages, and
tracking in-app purchase revenue.


### Usage
1. Before you begin:
 - [Have you signed up for a Chartboost account?](https://www.chartboost.com/signup/)
 - [Did you add an app to your dashboard?](https://answers.chartboost.com/hc/en-us/articles/200797729)
 - [Did you download the latest SDK?](https://answers.chartboost.com/hc/en-us/articles/201220095#top)
 - [Do you have an active publishing campaign?](https://answers.chartboost.com/hc/en-us/sections/201082359)
 - As of June 1, 2016, Apple requires that all submitted apps support IPv6.
 - The Chartboost SDK runs only on devices with iOS version 9.0 or higher.
 - `startWithAppId:appSignature:completion:` must always be called during hard and soft bootups, no matter what other actions your app is taking.

2. Drop Chartboost.framework and CHAMoatMobileAppKit.framework into your Xcode project. 

PRO TIP: Checkmark the Copy items if needed option. This creates a local copy of the framework for your project, which keeps your project organized.

3. Add value "-ObjC" in "Other Linker Flags" for both Debug and Release.

4. Link the `StoreKit`, `Foundation`,`AVFoundation`, `CoreGraphics`, `WebKit` and `UIKit` frameworks.

5. Add the import header `#import <Chartboost/Chartboost.h>` to your AppDelegate.m file.

6. Initialize Chartboost in your `didFinishLaunchingWithOptions` method.
```
(BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Initialize the Chartboost library
    [Chartboost startWithAppId:@"YOUR_CHARTBOOST_APP_ID"
                  appSignature:@"YOUR_CHARTBOOST_APP_SIGNATURE"
                    completion:^(BOOL initialized) {
                        NSLog(@"Chartboost SDK initialization finished with success %i", initialized);
                    }];
    return YES;
}
```
    **Please note:**

    - `startWithAppId:appSignature:completion:` must always be called during hard and soft bootups, no matter what other actions your app is taking.

7. Add your app ID and app signature.
    - Replace `YOUR_CHARTBOOST_APP_ID` and `YOUR_CHARTBOOST_APP_SIGNATURE` with your app ID and app signature.
    - [Where can I find my app ID and app signature?](https://answers.chartboost.com/hc/en-us/articles/201465075)

8. To show a static or video interstitial ad:
    - Cache the interstitial at some point before the moment it is intended to be shown. See ChartboostDelegate.h for available location options.
```
    self.interstitial = [[CHBInterstitial alloc] initWithLocation:CBLocationHomeScreen delegate:self];
    [self.interstitial cache];
```
   - Show the interstitial. Check the `isCached` property to make sure an ad is ready to be shown.  Showing a non-cached ad will fail and the delegate method `didShowAd:error:` will be called with a noCachedAd error.
```
    [self.interstitial showFromViewController:self];
```
   - For customized control over how ads behave in your game, the Chartboost SDK also offers more features such as delegate methods, and named locations.
   - [Learn more about Chartboost video ads.] (https://answers.chartboost.com/hc/en-us/articles/201220275)
   - **Important:** Chartboost calls should always be made from a main – not background – thread, or these calls may time out!

9.  To show a rewarded video ad:
    - Cache the rewarded ad at some point before the moment it is intended to be shown. See ChartboostDelegate.h for available location options.
```
    self.rewarded = [[CHBRewarded alloc] initWithLocation:CBLocationHomeScreen delegate:self];
    [self.rewarded cache];
```
   - Show the rewarded ad. Check the `isCached` property to make sure an ad is ready to be shown.  Showing a non-cached ad will fail and the delegate method `didShowAd:error:` will be called with a noCachedAd error.
```
    [self.rewarded showFromViewController:self];
```
   - For customized control over how ads behave in your game, the Chartboost SDK also offers more features such as caching, delegate methods, and named locations.
   - [Learn more about Chartboost video ads.](https://answers.chartboost.com/hc/en-us/articles/201220275)
   - **Important:** Chartboost calls should always be made from a main – not background – thread, or these calls may time out!

10. Test your integration.
    - Build and run your project from Xcode on a device or Simulator.
    - [If you have an active publishing campaign and have integrated "show interstitial" or "show rewarded video" calls, you should see live ads.] (https://answers.chartboost.com/hc/en-us/articles/204930539)
    - [If you don't have any publishing campaigns and you've still integrated these calls, you can use Test Mode to see if test ads show up.](https://answers.chartboost.com/hc/en-us/articles/200780549)
    - [Why can't I see ads in my game?](https://answers.chartboost.com/hc/en-us/articles/201121969)

11. Check the SDK icon in the Chartboost dashboard.
    - Go to your app's App Settings > Basic Settings in your [dashboard](https://dashboard.chartboost.com/).
    - When our servers successfully receive a bootup call from our SDK using your app ID, the SDK icon underneath your app’s icon will turn from gray to green.


### Dive deeper

For more common use cases, visit our [online documentation](https://help.chartboost.com/documentation/ios).

Check out our header files `Chartboost.h`, `CHBInterstitial.h`, `CHBRewarded.h` and `CHBBanner.h` for the full API specification.

