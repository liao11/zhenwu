//
//  AdTimingTapjoyAdapter.h
//  AdTiming
//
//  Created by ylm on 2019/6/27.
//  Copyright © 2019 AdTiming. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AdTimingMediationAdapter.h"
#import "AdTimingTapjoyClass.h"

NS_ASSUME_NONNULL_BEGIN

static NSString * const TapjoyAdapterVersion = @"3.0.2";

@interface AdTimingTapjoyAdapter : NSObject<AdTimingMediationAdapter>
@property (nonatomic, copy, nullable) AdTimingMediationAdapterInitCompletionBlock initBlock;

+ (NSString*)adapterVerison;
+ (void)initSDKWithConfiguration:(NSDictionary *)configuration completionHandler:(AdTimingMediationAdapterInitCompletionBlock)completionHandler;
+ (instancetype)sharedInstance;
@end

NS_ASSUME_NONNULL_END
