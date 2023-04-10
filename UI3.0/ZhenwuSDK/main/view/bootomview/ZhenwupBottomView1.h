//
//  ZhenwupBottomView1.h
//  EmpriSDK
//
//  Created by Admin on 2023/1/17.
//  Copyright © 2023 Admin. All rights reserved.
//

#import "ZhenwupBottomBaseView.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^ClosedViewCompleted)(void);
@interface ZhenwupBottomView1 : ZhenwupBottomBaseView

@property (copy, nonatomic) ClosedViewCompleted closedViewCompleted;
-(void)entterYouhuiView;
//@property (nonatomic, copy, nullable) void(^em11_HandleClosedView)(void) em_close;
@end

NS_ASSUME_NONNULL_END
