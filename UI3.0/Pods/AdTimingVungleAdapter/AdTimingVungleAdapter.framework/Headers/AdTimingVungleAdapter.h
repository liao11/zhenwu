//
//  AdTimingVungleAdapter.h
//  AdTimingVungleAdapter
//
//  Created by ylm on 2019/7/5.
//  Copyright © 2019 AdTiming. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AdTimingMediationAdapter.h"

static NSString * const VungleAdapterVersion = @"3.0.1";

@interface AdTimingVungleAdapter : NSObject<AdTimingMediationAdapter>

+ (NSString*)adapterVerison;

+ (void)initSDKWithConfiguration:(NSDictionary *)configuration completionHandler:(AdTimingMediationAdapterInitCompletionBlock)completionHandler;

@end
