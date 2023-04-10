//
//  ZhenwupCouponV2.h
//  EmpriSDK
//
//  Created by Admin on 2023/1/11.
//  Copyright © 2023 Admin. All rights reserved.
//

#import "ZhenwupBaseWindow_View.h"

NS_ASSUME_NONNULL_BEGIN

@class ZhenwupCouponV2;
@protocol EM_CouponV2Delegate <NSObject>

- (void)em11_handleCloseChongCouponV:(ZhenwupCouponV2 *)em18_couponV;

@end

@interface ZhenwupCouponV2 : ZhenwupBaseWindow_View
+ (void)em14_ShowShort;
@property (nonatomic, weak) id<EM_CouponV2Delegate> delegate;

@end

NS_ASSUME_NONNULL_END
