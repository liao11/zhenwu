//
//  ZhenwupLibaoCell1.h
//  EmpriSDK
//
//  Created by Admin on 2023/1/17.
//  Copyright © 2023 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZhenwupProgress_View.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZhenwupLibaoCell1 : UICollectionViewCell
@property (nonatomic, strong) UIImageView*em_bgV;
@property (nonatomic, strong) UIImageView*em_iconV;
@property (nonatomic, strong) UILabel *em14_TitleLab;
@property (nonatomic, strong) UILabel *em11_ExpirationDateLab;
@property (nonatomic, strong) UILabel *em11_present_nameLab;
@property (nonatomic, strong) UILabel *em11_present_surplusLab;
@property (nonatomic, strong) ZhenwupProgress_View *em11_present_progressView;

@property(nonatomic)NSDictionary *vdic;
@end

NS_ASSUME_NONNULL_END
