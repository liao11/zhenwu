//
//  ZhenwupBottomBaseView.h
//  EmpriSDK
//
//  Created by Admin on 2023/1/17.
//  Copyright © 2023 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+GrossExtension.h"
#import "MBProgressHUD+GrossExtension.h"
#import "ZhenwupAccount_Server.h"
#import "UIView+GrossExtension.h"
#import "NSString+GrossExtension.h"
#import "ZhenwupTheme_Utils.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZhenwupBottomBaseView : UIView
@property (nonatomic, strong) UIView *topBgview;
@property (nonatomic, strong) UILabel *em14_TitleLab;
@property (nonatomic, strong) UIButton *em14_BackBtn;
@property (nonatomic, copy) NSString *title;
- (void)em14_ShowTopview:(BOOL)show;

- (id)initWithFrame:(CGRect)frame ;
-(void)setupContent;
@end

NS_ASSUME_NONNULL_END
