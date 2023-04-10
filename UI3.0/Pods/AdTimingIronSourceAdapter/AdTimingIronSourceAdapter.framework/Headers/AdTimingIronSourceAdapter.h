//
//  AdTimingIronSourceAdapter.h
//  AdTimingIronSourceAdapter
//
//  Created by M on 2020/3/9.
//  Copyright © 2020 AdTiming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdTimingMediationAdapter.h"

NS_ASSUME_NONNULL_BEGIN

static NSString * const IronSourceAdapterVersion = @"3.0.2";

@interface AdTimingIronSourceAdapter : NSObject<AdTimingMediationAdapter>
+ (NSString*)adapterVerison;
+ (void)initSDKWithConfiguration:(NSDictionary *)configuration completionHandler:(AdTimingMediationAdapterInitCompletionBlock)completionHandler;

@end

NS_ASSUME_NONNULL_END
