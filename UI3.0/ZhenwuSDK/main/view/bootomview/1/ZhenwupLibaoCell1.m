//
//  ZhenwupLibaoCell1.m
//  EmpriSDK
//
//  Created by Admin on 2023/1/17.
//  Copyright © 2023 Admin. All rights reserved.
//

#import "ZhenwupLibaoCell1.h"
#import "ZhenwupTheme_Utils.h"
#import "UIView+GrossExtension.h"
#import "ZhenwupHelper_Utils.h"

@implementation ZhenwupLibaoCell1
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
       
        
        
        
        [self.contentView addSubview:self.em_bgV];
        
        
        
        [self.em_bgV addSubview:self.em14_TitleLab];
        [self.em_bgV addSubview:self.em11_ExpirationDateLab];
        [self.em_bgV addSubview:self.em11_present_nameLab];
        [self.em_bgV addSubview:self.em11_present_progressView];
        [self.em_bgV addSubview:self.em11_present_surplusLab];
        
        [self.em_bgV addSubview:self.em_iconV];
     
     
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
        _em14_TitleLab = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, _em_bgV.em_width - 100, 20)];
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

- (UIImageView *)em_iconV{
    if (!_em_iconV) {
        _em_iconV = [[UIImageView alloc]initWithFrame:CGRectMake(_em_bgV.em_width-40, 0, 40, 40)];
        _em_iconV.image=[ZhenwupHelper_Utils imageName:@"zhenwuimlibaoa"];
    }
    return _em_iconV;
}

- (ZhenwupProgress_View *)em11_present_progressView{
    if (!_em11_present_progressView) {
        _em11_present_progressView = [[ZhenwupProgress_View alloc] initWithFrame:CGRectMake(30, self.em11_present_nameLab.em_bottom + 15, _em_bgV.em_width-60, 10)];
       
    }
    return _em11_present_progressView;
}
- (UILabel *)em11_present_surplusLab{
    if (!_em11_present_surplusLab) {
        _em11_present_surplusLab = [[UILabel alloc] initWithFrame:CGRectMake(10, _em11_present_progressView.em_bottom+2, _em_bgV.em_width - 20, 15)];
        _em11_present_surplusLab.textAlignment = NSTextAlignmentCenter;
        _em11_present_surplusLab.textColor = [ZhenwupTheme_Utils em_colors_DarkGrayColor];
        _em11_present_surplusLab.font = [ZhenwupTheme_Utils em_colors_LeastFont];
    }
    return _em11_present_surplusLab;
}


-(void)setVdic:(NSDictionary *)vdic{
    NSDictionary *khxl_presentDict = vdic;
    NSInteger surplus = [khxl_presentDict[[NSString stringWithFormat:@"%@",@"surplus_quantity"]] integerValue];
    
    BOOL hasGet = [khxl_presentDict[[NSString stringWithFormat:@"%@",@"status"]] boolValue];
    
    
    self.em14_TitleLab.text = khxl_presentDict[[NSString stringWithFormat:@"%@%@%@",@"g",@"ift_n",@"ame"]];
    
    self.em11_ExpirationDateLab.text = [NSString stringWithFormat:@"%@: %@",MUUQYLocalizedString(@"EMKey_Deadline_Text"),khxl_presentDict[@"end_time"]];
    
    
    
    
    self.em11_present_surplusLab.text = [NSString stringWithFormat:@"%@:%ld%%",MUUQYLocalizedString(@"EMKey_Surplus_Text"), (long)surplus];
    
    NSString *contentText = [NSString stringWithFormat:@"%@", khxl_presentDict[[NSString stringWithFormat:@"%@%@%@%@",@"gi",@"ft_",@"desc",@"ription"]]?:@""];
    
    self.em11_present_nameLab.text=contentText;
    
    self.em11_present_progressView.progress = surplus/100.0;
    
    
    if (hasGet || surplus <= 0) {
        self.contentView.alpha = 0.3;
        self.userInteractionEnabled = NO;
        self.em_iconV.hidden=NO;
        
       
    } else {
        self.em_iconV.hidden=YES;
        self.contentView.alpha = 1.0;
        self.userInteractionEnabled = YES;
    }
}
@end
