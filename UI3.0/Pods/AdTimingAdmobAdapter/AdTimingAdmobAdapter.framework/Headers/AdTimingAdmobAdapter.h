//
//  AdTimingAdmobAdapter.h
//  AdTiming
//
//  Created by ylm on 2019/6/26.
//  Copyright © 2019 AdTiming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdTimingMediationAdapter.h"

NS_ASSUME_NONNULL_BEGIN

static NSString * const AdmobAdapterVersion = @"3.0.1";

@interface AdTimingAdmobAdapter : NSObject<AdTimingMediationAdapter>

+ (NSString*)adapterVerison;
+ (void)initSDKWithConfiguration:(NSDictionary *)configuration completionHandler:(AdTimingMediationAdapterInitCompletionBlock)completionHandler;

@end

NS_ASSUME_NONNULL_END
