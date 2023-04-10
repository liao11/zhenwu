//
//  ZhenwupInfoView.m
//  EmpriSDK
//
//  Created by Admin on 2023/1/28.
//  Copyright © 2023 Admin. All rights reserved.
//

#import "ZhenwupInfoView.h"
#import "NSString+GrossExtension.h"
#import "ZhenwupAccount_Server.h"
#import "NSString+GrossExtension.h"
#import "ZhenwupTheme_Utils.h"
#define EM_RGBA(r,g,b,a)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]


#define LinebgColor  EM_RGBA(27, 28, 38, 1)

@interface ZhenwupInfoView ()
@property (nonatomic, strong) UIView *em18_bgV;
@property (nonatomic, strong) ZhenwupAccount_Server *em11_AccountServer;
@property (nonatomic, strong) UILabel *em11_AccountLab;
@property (nonatomic, strong) UILabel *em11_EmailLab;
@property (nonatomic, strong) UILabel *em14_telNumLab;
@property (nonatomic, strong) UILabel *em_accCountLab;
@property (nonatomic, strong) UILabel *em11_LevelLab;
@property (nonatomic, strong) UILabel *em11_IntegralLab;

@end
@implementation ZhenwupInfoView

- (ZhenwupAccount_Server *)em11_AccountServer {
    if (!_em11_AccountServer) {
        _em11_AccountServer = [[ZhenwupAccount_Server alloc] init];
    }
    return _em11_AccountServer;
}
-(void)setupContent{
    //    self.backgroundColor=[UIColor clearColor];
    
    [self em14_ShowTopview:YES];
    
    self.title=MUUQYLocalizedString(@"EMKey_PersonCenter_Text");
    
    [self addSubview:self.em18_bgV];
    
    
    UIImageView * inputBgView = [[UIImageView alloc] initWithFrame:CGRectMake(35, 55, self.em18_bgV.em_width - 70, 110)];
    
    inputBgView.image=[ZhenwupHelper_Utils imageName:@"zhenwuimbg6"];
    
    [self.em18_bgV addSubview:inputBgView];
    
    CGFloat titleWidth = 100;
    
    UILabel *accLab = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, titleWidth, 25)];
    accLab.font = [ZhenwupTheme_Utils em_colors_NormalFont];
    accLab.textColor = [ZhenwupTheme_Utils em_colors_GrayColor];
//    accLab.textAlignment = NSTextAlignmentRight;
    accLab.text = [NSString stringWithFormat:@"%@：",MUUQYLocalizedString(@"EMKey_AccountNumber_Text")];
    [inputBgView addSubview:accLab];
    
    self.em11_AccountLab = [[UILabel alloc] initWithFrame:CGRectMake(titleWidth + 35, accLab.em_top, inputBgView.em_width - titleWidth - 5, 25)];
    self.em11_AccountLab.font = [ZhenwupTheme_Utils em_colors_NormalFont];
    self.em11_AccountLab.textColor = [ZhenwupTheme_Utils em_colors_GrayColor];
    [inputBgView addSubview:self.em11_AccountLab];
    
    UILabel *bindEmailLab = [[UILabel alloc] initWithFrame:CGRectMake(30, accLab.em_bottom + 10, titleWidth, 25)];
    bindEmailLab.font = [ZhenwupTheme_Utils em_colors_NormalFont];
    bindEmailLab.textColor = [ZhenwupTheme_Utils em_colors_GrayColor];
//    bindEmailLab.textAlignment = NSTextAlignmentRight;
    bindEmailLab.text = [NSString stringWithFormat:@"%@：",MUUQYLocalizedString(@"EMKey_BindEmail_Text")];
    [inputBgView addSubview:bindEmailLab];

    self.em11_EmailLab = [[UILabel alloc] initWithFrame:CGRectMake(titleWidth + 35, bindEmailLab.em_top, inputBgView.em_width - titleWidth - 5, 25)];
    self.em11_EmailLab.font = [ZhenwupTheme_Utils em_colors_NormalFont];
    self.em11_EmailLab.textColor = [ZhenwupTheme_Utils em_colors_GrayColor];
    [inputBgView addSubview:self.em11_EmailLab];
    
    UILabel *em18_tel = [[UILabel alloc] initWithFrame:CGRectMake(30, bindEmailLab.em_bottom + 10, titleWidth, 25)];
    em18_tel.font = [ZhenwupTheme_Utils em_colors_NormalFont];
    em18_tel.textColor = [ZhenwupTheme_Utils em_colors_GrayColor];
//    em18_tel.textAlignment = NSTextAlignmentRight;
    em18_tel.text = [NSString stringWithFormat:@"%@：",MUUQYLocalizedString(@"EMKey_WordTel")];
    [inputBgView addSubview:em18_tel];

    self.em14_telNumLab = [[UILabel alloc] initWithFrame:CGRectMake(titleWidth + 35, em18_tel.em_top, inputBgView.em_width - titleWidth - 5, 25)];
    self.em14_telNumLab.font = [ZhenwupTheme_Utils em_colors_NormalFont];
    self.em14_telNumLab.textColor = [ZhenwupTheme_Utils em_colors_GrayColor];
    [inputBgView addSubview:self.em14_telNumLab];
    
    
    
    UIImageView * inputBgView2 = [[UIImageView alloc] initWithFrame:CGRectMake(35,inputBgView.em_bottom+30 , self.em18_bgV.em_width - 70, 110)];
    
    inputBgView2.image=[ZhenwupHelper_Utils imageName:@"zhenwuimbg6"];
    
    [self.em18_bgV addSubview:inputBgView2];
    
    
    
    UILabel *integralLab = [[UILabel alloc] initWithFrame:CGRectMake(30, 5, titleWidth, 25)];
    integralLab.font = [ZhenwupTheme_Utils em_colors_NormalFont];
    integralLab.textColor = [ZhenwupTheme_Utils em_colors_GrayColor];
//    integralLab.textAlignment = NSTextAlignmentRight;
    integralLab.text = [NSString stringWithFormat:@"%@：",MUUQYLocalizedString(@"EMKey_AccountIntegral_Text")];
    [inputBgView2 addSubview:integralLab];
    
    self.em11_IntegralLab = [[UILabel alloc] initWithFrame:CGRectMake(titleWidth + 35, integralLab.em_top, inputBgView.em_width - titleWidth - 5, 25)];
    self.em11_IntegralLab.font = [ZhenwupTheme_Utils em_colors_NormalFont];
    self.em11_IntegralLab.textColor = [ZhenwupTheme_Utils em_colors_GrayColor];
    [inputBgView2 addSubview:self.em11_IntegralLab];
    
   
    
    UILabel *levelLab = [[UILabel alloc] initWithFrame:CGRectMake(30, integralLab.em_bottom + 10, titleWidth, 25)];
    levelLab.font = [ZhenwupTheme_Utils em_colors_NormalFont];
    levelLab.textColor = [ZhenwupTheme_Utils em_colors_GrayColor];
//    levelLab.textAlignment = NSTextAlignmentRight;
    levelLab.text = [NSString stringWithFormat:@"%@：",MUUQYLocalizedString(@"EMKey_AccountLevel_Text")];
    [inputBgView2 addSubview:levelLab];
    
    self.em11_LevelLab = [[UILabel alloc] initWithFrame:CGRectMake(titleWidth + 35, levelLab.em_top, inputBgView.em_width - titleWidth - 5, 25)];
    self.em11_LevelLab.font = [ZhenwupTheme_Utils em_colors_NormalFont];
    self.em11_LevelLab.textColor = [ZhenwupTheme_Utils em_colors_GrayColor];
    [inputBgView2 addSubview:self.em11_LevelLab];
    
    UILabel *zwp01_acc = [[UILabel alloc] initWithFrame:CGRectMake(30,levelLab.em_bottom + 10, titleWidth, 25)];
    zwp01_acc.font = [ZhenwupTheme_Utils em_colors_NormalFont];
    zwp01_acc.textColor = [ZhenwupTheme_Utils em_colors_GrayColor];
//    zwp01_acc.textAlignment = NSTextAlignmentRight;
    zwp01_acc.text = [NSString stringWithFormat:@"%@：",MUUQYLocalizedString(@"EMKey_expWord")];
    [inputBgView2 addSubview:zwp01_acc];

    self.em_accCountLab = [[UILabel alloc] initWithFrame:CGRectMake(titleWidth + 35, zwp01_acc.em_top, inputBgView.em_width - titleWidth - 5, 25)];
    self.em_accCountLab.font = [ZhenwupTheme_Utils em_colors_NormalFont];
    self.em_accCountLab.textColor = [ZhenwupTheme_Utils em_colors_GrayColor];
    [inputBgView2 addSubview:self.em_accCountLab];
    
//    inputBgView2.em_height = zwp01_acc.em_bottom+5;
    
    
    [self em14_u_UpdateInterfaceWithData:nil];
    [self em11_GetUserInfo];
    
    
 
}
- (void)em14_u_UpdateInterfaceWithData:(NSDictionary *)data {
    NSString *_account = EMSDKGlobalInfo.userInfo.userName;
    NSString *_bindEmail = @"";
    NSString *_level = @"0";
    NSString *_integral = @"0";
    NSString *_tel = @"";
    NSString *_exp = @"0";
    
    if (data && data.count > 0) {
        _account = [data objectForKey:[NSString stringWithFormat:@"%@",@"username"]];
        _bindEmail = [data objectForKey:[NSString stringWithFormat:@"%@",@"bind_email"]];
        _level = [data objectForKey:[NSString stringWithFormat:@"%@",@"user_level"]];
        _integral = [data objectForKey:[NSString stringWithFormat:@"%@",@"user_points"]];
        _tel = [data objectForKey:[NSString stringWithFormat:@"%@",@"mobile"]];
        _exp = [data objectForKey:[NSString stringWithFormat:@"%@",@"user_exp"]];
        if (!_bindEmail || [_bindEmail isEmpty]) {
            _bindEmail = MUUQYLocalizedString(@"EMKey_AccountNoBind_Text");
        }
    }
    
    if (EMSDKGlobalInfo.userInfo.accountType != EM_AccountTypeMuu) {
        _account = EMSDKGlobalInfo.userInfo.userID;
    }
    

    
    
    self.em11_AccountLab.text = _account;
    self.em11_EmailLab.text = _bindEmail;
    self.em11_LevelLab.text = _level;
    self.em14_telNumLab.text = _tel;
    self.em11_IntegralLab.text = _integral;
    self.em_accCountLab.text = _exp;
}

- (void)em11_GetUserInfo {
    [MBProgressHUD em14_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.em11_AccountServer em11_GetUserInfo:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD em14_DismissLoadingHUD];
        [weakSelf em14_u_UpdateInterfaceWithData:result.em14_responeResult];
        
        if (result.em14_responseCode != EM_ResponseCodeSuccess) {
            [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
        }
    }];
}
- (UIView *)em18_bgV{
    if (!_em18_bgV) {
        _em18_bgV = [[UIView alloc] initWithFrame:CGRectMake(0, 55, self.em_width, self.em_height - 55 - 25)];
    }
    return _em18_bgV;
}

@end
