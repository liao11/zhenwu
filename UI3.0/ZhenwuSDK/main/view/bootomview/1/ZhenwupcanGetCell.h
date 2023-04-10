//
//  ZhenwupcanGetCell.h
//  GiguoFrameWork
//
//  Created by Admin on 2021/9/29.
//  Copyright © 2021 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZhenwupcanGetCell : UITableViewCell

@property (nonatomic, strong)  UIImageView*em_bgV;
@property (nonatomic, strong) UILabel *em11_name;
@property (nonatomic, strong) UILabel *em18_info;
@property (nonatomic, strong) UILabel *limitTime;
@property (nonatomic, strong) UILabel *em18_info1;
@property (nonatomic, strong) UILabel *em18_info2;

@property (nonatomic, copy, nullable) void(^em11_getBtnBlock)(void);

@end

NS_ASSUME_NONNULL_END
