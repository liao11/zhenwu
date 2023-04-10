//
//  ZhenwupIntergralShopCell.m
//  GiguoFrameWork
//
//  Created by Admin on 2022/4/20.
//  Copyright © 2022 Admin. All rights reserved.
//

#import "ZhenwupIntergralShopCell.h"
#import "ZhenwupTheme_Utils.h"
#import "UIView+GrossExtension.h"

@implementation ZhenwupIntergralShopCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 8;
        self.layer.borderColor = [ZhenwupTheme_Utils khxl_SmalltitleColor].CGColor;
        self.layer.borderWidth = 1;
        [self.contentView addSubview:self.em_icon];
        [self.contentView addSubview:self.em11_name];
        [self.contentView addSubview:self.em18_accInter];
        [self.contentView addSubview:self.em14_lastNum];
    }
    return self;
}

- (UIImageView *)em_icon{
    if (!_em_icon) {
        _em_icon = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, self.em_width - 30, self.em_width - 30)];
        _em_icon.layer.cornerRadius = 4;
        _em_icon.layer.masksToBounds=YES;
    }
    return _em_icon;
}

- (UILabel *)em11_name{
    if (!_em11_name) {
        _em11_name = [[UILabel alloc] initWithFrame:CGRectMake(15, self.em_icon.em_bottom + 6, self.em_width - 30, 15)];
        _em11_name.textAlignment = NSTextAlignmentLeft;
        _em11_name.textColor = [ZhenwupTheme_Utils khxl_SmalltitleColor];
        _em11_name.font = [ZhenwupTheme_Utils em_colors_SmallFont];
    }
    return _em11_name;
}

- (UILabel *)em18_accInter{
    if (!_em18_accInter) {
        _em18_accInter = [[UILabel alloc] initWithFrame:CGRectMake(15, self.em11_name.em_bottom + 6, self.em_width - 30, 13)];
        _em18_accInter.textAlignment = NSTextAlignmentLeft;
        _em18_accInter.textColor = [ZhenwupTheme_Utils em_colors_DarkGrayColor];
        _em18_accInter.font = [ZhenwupTheme_Utils em_colors_LeastFont];
    }
    return _em18_accInter;
}


- (UILabel *)em14_lastNum{
    if (!_em14_lastNum) {
        _em14_lastNum = [[UILabel alloc] initWithFrame:CGRectMake(15, self.em18_accInter.em_bottom + 5, self.em_width - 30, 13)];
        _em14_lastNum.textAlignment = NSTextAlignmentLeft;
        _em14_lastNum.textColor = [ZhenwupTheme_Utils em_colors_DarkGrayColor];
        _em14_lastNum.font = [ZhenwupTheme_Utils em_colors_LeastFont];
    }
    return _em14_lastNum;
}



@end
