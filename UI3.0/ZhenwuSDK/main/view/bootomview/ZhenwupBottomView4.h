//
//  ZhenwupBottomView4.h
//  EmpriSDK
//
//  Created by Admin on 2023/1/17.
//  Copyright © 2023 Admin. All rights reserved.
//

#import "ZhenwupBottomBaseView.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^ClosedViewCompleted)(void);
@interface ZhenwupBottomView4 : ZhenwupBottomBaseView
@property (copy, nonatomic) ClosedViewCompleted closedViewCompleted;
@end

NS_ASSUME_NONNULL_END
