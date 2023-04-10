//
//  ZhenwupBottomView2.h
//  EmpriSDK
//
//  Created by Admin on 2023/1/17.
//  Copyright © 2023 Admin. All rights reserved.
//

#import "ZhenwupBottomBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZhenwupBottomView2 : ZhenwupBottomBaseView
@property (nonatomic, copy) NSString *alhm_uString;
@property (nonatomic, copy) NSURL *em14_htstr;
@property (nonatomic, copy) NSString *em18_base;
@property (nonatomic, copy) NSString *em11_exp;
@property (nonatomic) NSArray *menberArr;
@property (nonatomic, copy) NSString *em_meetData;
- (void)em11_GetUserInfo;
@end

NS_ASSUME_NONNULL_END
