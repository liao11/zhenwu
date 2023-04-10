//
//  ZhenwupLibaoCell2.m
//  EmpriSDK
//
//  Created by Admin on 2023/1/17.
//  Copyright © 2023 Admin. All rights reserved.
//

#import "ZhenwupLibaoCell2.h"
#import "ZhenwupTheme_Utils.h"
#import "UIView+GrossExtension.h"
#import "ZhenwupHelper_Utils.h"
@implementation ZhenwupLibaoCell2
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
       
        
        [self.contentView addSubview:self.em_bgV];
        
        
        
        [self.em_bgV addSubview:self.em14_TitleLab];
        [self.em_bgV addSubview:self.em11_ExpirationDateLab];
        [self.em_bgV addSubview:self.em11_present_nameLab];
       
        [self.em_bgV addSubview:self.em11_present_surplusLab];
        
      
     
     
    }
    return self;
}
- (UIImageView *)em_bgV{
    if (!_em_bgV) {
        _em_bgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.em_width, self.em_height)];
        _em_bgV.image= [ZhenwupHelper_Utils imageName:@"zhenwuimlibaob1"];
    }
    return _em_bgV;
}

- (UILabel *)em14_TitleLab{
    if (!_em14_TitleLab) {
        _em14_TitleLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, _em_bgV.em_width - 40, 20)];
        _em14_TitleLab.textAlignment = NSTextAlignmentCenter;
        _em14_TitleLab.textColor = [ZhenwupTheme_Utils em_colors_DarkGrayColor];
        _em14_TitleLab.font = [ZhenwupTheme_Utils em_colors_LargeFont];
    }
    return _em14_TitleLab;
}

- (UILabel *)em11_ExpirationDateLab{
    if (!_em11_ExpirationDateLab) {
        _em11_ExpirationDateLab = [[UILabel alloc] initWithFrame:CGRectMake(10, _em14_TitleLab.em_bottom+10, _em_bgV.em_width - 20, 15)];
        _em11_ExpirationDateLab.textAlignment = NSTextAlignmentCenter;
        _em11_ExpirationDateLab.textColor = [ZhenwupTheme_Utils em_colors_DarkGrayColor];
        _em11_ExpirationDateLab.font = [ZhenwupTheme_Utils em_colors_LeastFont];
    }
    return _em11_ExpirationDateLab;
}

- (UILabel *)em11_present_nameLab{
    if (!_em11_present_nameLab) {
        _em11_present_nameLab = [[UILabel alloc] initWithFrame:CGRectMake(10, _em11_ExpirationDateLab.em_bottom+10, _em_bgV.em_width - 20, 20)];
        _em11_present_nameLab.textAlignment = NSTextAlignmentCenter;
        _em11_present_nameLab.textColor = [ZhenwupTheme_Utils em_colors_DarkGrayColor];
        _em11_present_nameLab.font = [ZhenwupTheme_Utils em_colors_LargeFont];
    }
    return _em11_present_nameLab;
}


- (UILabel *)em11_present_surplusLab{
    if (!_em11_present_surplusLab) {
        _em11_present_surplusLab = [[UILabel alloc] initWithFrame:CGRectMake(10, _em11_present_nameLab.em_bottom+20, _em_bgV.em_width - 20, 15)];
        _em11_present_surplusLab.textAlignment = NSTextAlignmentCenter;
        _em11_present_surplusLab.textColor = [ZhenwupTheme_Utils khxl_SmalltitleColor];
        _em11_present_surplusLab.font = [ZhenwupTheme_Utils em_colors_LargeFont];
    }
    return _em11_present_surplusLab;
}


-(void)setVdic:(NSDictionary *)vdic{
    NSDictionary *khxl_presentDict = vdic;
    self.em14_TitleLab.text = khxl_presentDict[[NSString stringWithFormat:@"%@%@%@",@"g",@"ift_n",@"ame"]];
    
    self.em11_ExpirationDateLab.text = [NSString stringWithFormat:@"%@: %@",MUUQYLocalizedString(@"EMKey_Deadline_Text"),khxl_presentDict[@"end_time"]];
    
    
    
    
  
    
    NSString *contentText = [NSString stringWithFormat:@"%@", khxl_presentDict[[NSString stringWithFormat:@"%@%@%@%@",@"gi",@"ft_",@"desc",@"ription"]]?:@""];
    
    self.em11_present_nameLab.text=contentText;
    
    self.em11_present_surplusLab.text = [NSString stringWithFormat:@"%@", vdic[@"lbm"]?:@""];
   
    
   
}
@end
