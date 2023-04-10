//
//  AdTimingMintegralAdapter.h
//  AdTiming
//
//  Created by M on 2019/11/12.
//  Copyright © 2019 AdTiming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdTimingMediationAdapter.h"

NS_ASSUME_NONNULL_BEGIN

static NSString * const MintegralAdapterVersion = @"3.0.5";

@interface AdTimingMintegralAdapter : NSObject<AdTimingMediationAdapter>

+ (NSString*)adapterVerison;
+ (void)initSDKWithConfiguration:(NSDictionary *)configuration completionHandler:(AdTimingMediationAdapterInitCompletionBlock)completionHandler;

@end

NS_ASSUME_NONNULL_END
