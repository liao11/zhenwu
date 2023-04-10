//
//  AdTimingAdColonyAdapter.h
//  AdTiming
//
//  Created by ylm on 2019/6/27.
//  Copyright © 2019 AdTiming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdTimingMediationAdapter.h"
#import "AdTimingAdColonyClass.h"

NS_ASSUME_NONNULL_BEGIN

static NSString * const AdColonyAdapterVersion = @"3.0.2";

@interface AdTimingAdColonyAdapter : NSObject<AdTimingMediationAdapter>

+ (NSString*)adapterVerison;
+ (void)initSDKWithConfiguration:(NSDictionary *)configuration completionHandler:(AdTimingMediationAdapterInitCompletionBlock)completionHandler;

@end

NS_ASSUME_NONNULL_END
