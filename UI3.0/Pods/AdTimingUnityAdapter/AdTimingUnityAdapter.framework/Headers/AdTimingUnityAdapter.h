//
//  AdTimingUnityAdapter.h
//  AdTiming
//
//  Created by ylm on 2019/6/26.
//  Copyright © 2019 AdTiming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdTimingMediationAdapter.h"

static NSString * const UnityAdapterVersion = @"3.0.1";

@interface AdTimingUnityAdapter : NSObject<AdTimingMediationAdapter>

+ (NSString*)adapterVerison;
+ (void)initSDKWithConfiguration:(NSDictionary *)configuration completionHandler:(AdTimingMediationAdapterInitCompletionBlock)completionHandler;
@end
