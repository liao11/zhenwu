//
//  AdTimingAppLovinAdapter.h
//  AdTiming
//
//  Created by ylm on 2019/6/27.
//  Copyright © 2019 AdTiming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdTimingMediationAdapter.h"
#import "AdTimingAppLovinClass.h"

NS_ASSUME_NONNULL_BEGIN

static NSString * const AppLovinAdapterVersion = @"3.0.2";

@interface AdTimingAppLovinAdapter : NSObject<AdTimingMediationAdapter>
+ (NSString*)adapterVerison;
+ (void)initSDKWithConfiguration:(NSDictionary *)configuration completionHandler:(AdTimingMediationAdapterInitCompletionBlock)completionHandler;
+ (ALSdk*)alShareSdk;
+ (UIWindow *)currentWindow;
@end

NS_ASSUME_NONNULL_END
