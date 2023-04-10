//
//  ZhenwupOutConfirmV.m
//  GiguoFrameWork
//
//  Created by Admin on 2021/10/8.
//  Copyright © 2021 Admin. All rights reserved.
//

#import "ZhenwupOutConfirmV.h"
#import "ZhenwupSDKMainView_Controller.h"
@interface ZhenwupOutConfirmV ()

@property (nonatomic, strong) UIView *em18_bgV;


@end

@implementation ZhenwupOutConfirmV

- (instancetype)init {
    if (self = [super initWithCurType:@"2"]) {
        [self em14_setupViews];
    }
    return self;
}

- (void)em14_setupViews {
    
    [self em14_ShowCloseBtn:false];
    
    [self setTitle:MUUQYLocalizedString(@"EMKey_quietNotice")];
    
    [self addSubview:self.em18_bgV];
    

    UIButton *em14_cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    em14_cancelBtn.frame = CGRectMake(30, 15, self.em18_bgV.em_width/2 - 45, 45);
    em14_cancelBtn.backgroundColor = UIColor.whiteColor;
    em14_cancelBtn.layer.cornerRadius = 22.5f;
    em14_cancelBtn.layer.borderColor = [ZhenwupTheme_Utils em_colors_LightGrayColor].CGColor;
    em14_cancelBtn.layer.borderWidth = 0.5;
    em14_cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [em14_cancelBtn setTitle:MUUQYLocalizedString(@"EMKey_nowCancel") forState:UIControlStateNormal];
    [em14_cancelBtn setTitleColor:[ZhenwupTheme_Utils em_colors_LightGrayColor] forState:UIControlStateNormal];
    [em14_cancelBtn addTarget:self action:@selector(em18_cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [self.em18_bgV addSubview:em14_cancelBtn];
    
    UIButton *em11_outBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    em11_outBtn.frame = CGRectMake(self.em18_bgV.em_width/2 + 30, 15, self.em18_bgV.em_width/2 - 45, 45);
    em11_outBtn.backgroundColor = [ZhenwupTheme_Utils khxl_SmalltitleColor];
    em11_outBtn.layer.cornerRadius = 22.5f;
    em11_outBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [em11_outBtn setTitle:MUUQYLocalizedString(@"EMKey_nowQuiet") forState:UIControlStateNormal];
    [em11_outBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [em11_outBtn addTarget:self action:@selector(em_outClick) forControlEvents:UIControlEventTouchUpInside];
    [self.em18_bgV addSubview:em11_outBtn];
}

- (void)em18_cancelClick{
    if (self.delegate && [self.delegate respondsToSelector:@selector(em11_handleCloseOutConfirmV:)]) {
        [self.delegate em11_handleCloseOutConfirmV:self];
    }
}

- (void)em_outClick{
    if (self.delegate && [self.delegate respondsToSelector:@selector(em11_handleCloseOutConfirmV:)]) {
        [self.delegate em11_handleCloseOutConfirmV:self];
    }
    [ZhenwupSDKMainView_Controller em11_logoutAction];
    
    
}


- (UIView *)em18_bgV{
    if (!_em18_bgV) {
        _em18_bgV = [[UIView alloc] initWithFrame:CGRectMake(0, 55, self.em_width, self.em_height - 55 - 25)];
        
    }
    return _em18_bgV;
}

@end
