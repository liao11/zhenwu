//
//  ZhenwupChooseLoginView.m
//  GiguoFrameWork
//
//  Created by Admin on 2022/5/25.
//  Copyright © 2022 Admin. All rights reserved.
//

#import "ZhenwupChooseLoginView.h"
#import "ZhenwupLogin_Server.h"
@interface ZhenwupChooseLoginView ()

@property (strong, nonatomic) UIView *em18_viewBg;
@property (strong, nonatomic) UIButton *em11_gstLogBtn;
@property (strong, nonatomic) UIButton *em11_cusRegBtn;
@property (strong, nonatomic) UIButton *em18_fblogBtn;


@property (strong, nonatomic) UIButton *em11_verifyProtoclBtn;

@property (strong, nonatomic) UIButton *khxl_protocolBtn;

@property (strong, nonatomic) ZhenwupLogin_Server *em14_LoginServer;
@property (nonatomic, strong) ZhenwupAccount_Server *em11_AccountServer;
@end

@implementation ZhenwupChooseLoginView

- (instancetype)init {
    self = [super initWithCurType:@"0"];
    if (self) {
        [self em14_setupViews];
    }
    return self;
}

- (ZhenwupAccount_Server *)em11_AccountServer {
    if (!_em11_AccountServer) {
        _em11_AccountServer = [[ZhenwupAccount_Server alloc] init];
    }
    return _em11_AccountServer;
}
- (ZhenwupLogin_Server *)em14_LoginServer {
    if (!_em14_LoginServer) {
        _em14_LoginServer = [[ZhenwupLogin_Server alloc] init];
    }
    return _em14_LoginServer;
}
-(void)setEnter:(NSString *)enter{
    [self em14_dataWithevent:@"OpenLoginInterface" WithRe:@""];
}

- (void)em14_setupViews {
    
    self.em14_TitleLab.frame =CGRectMake(0, 12, self.em_width, 36);
    self.bgview.image = [ZhenwupHelper_Utils imageName:@"zhenwuimbg3"];
//    self.title = MUUQYLocalizedString(@"EMKey_Login_Text");
    
    self.title = @"Login";
        
    self.em18_viewBg = [[UIView alloc] initWithFrame:CGRectMake(35, 60, self.em_width-70, 200)];
    [self addSubview:self.em18_viewBg];
    
    self.em11_gstLogBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.em11_gstLogBtn.frame = CGRectMake(0, 30, self.em18_viewBg.em_width, 49);
    self.em11_gstLogBtn.titleLabel.font = [ZhenwupTheme_Utils em_colors_LargeFont];
    self.em11_gstLogBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;

    [self.em11_gstLogBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
//    self.em11_gstLogBtn.backgroundColor = [ZhenwupTheme_Utils em_colors_yellowColor];
    
    [self.em11_gstLogBtn setBackgroundImage:[ZhenwupHelper_Utils imageName:@"zhenwuimb1"] forState:0];
    
    

    self.em11_gstLogBtn.layer.cornerRadius = 6;
    self.em11_gstLogBtn.clipsToBounds = true;
    [self.em11_gstLogBtn addTarget:self action:@selector(em14_HandleCilckedQuicklogBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.em18_viewBg addSubview:self.em11_gstLogBtn];
    
    self.em11_cusRegBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.em11_cusRegBtn.frame = CGRectMake(0, self.em11_gstLogBtn.em_bottom + 25, self.em18_viewBg.em_width, 49);
    self.em11_cusRegBtn.titleLabel.font = [ZhenwupTheme_Utils em_colors_LargeFont];
    self.em11_cusRegBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//    [self.em11_cusRegBtn setTitle:MUUQYLocalizedString(@"EMKey_EmailFastLogin") forState:UIControlStateNormal];
//    [self.em11_cusRegBtn setImage:[ZhenwupHelper_Utils imageName:@"zhenwuimlogin_3"] forState:UIControlStateNormal];
    [self.em11_cusRegBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
//    self.em11_cusRegBtn.backgroundColor = [ZhenwupTheme_Utils em_colors_ButtonColor];
    [self.em11_cusRegBtn setBackgroundImage:[ZhenwupHelper_Utils imageName:@"zhenwuimb2"] forState:0];
    self.em11_cusRegBtn.layer.cornerRadius = 6;
    self.em11_cusRegBtn.clipsToBounds = true;
    [self.em11_cusRegBtn addTarget:self action:@selector(em14_HandleClickedRegisterBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.em18_viewBg addSubview:self.em11_cusRegBtn];
    
    
    self.em18_fblogBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.em18_fblogBtn.frame = CGRectMake(0, self.em11_cusRegBtn.em_bottom + 25, self.em18_viewBg.em_width, 49);
    self.em18_fblogBtn.titleLabel.font = [ZhenwupTheme_Utils em_colors_LargeFont];
    self.em18_fblogBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//    [self.em18_fblogBtn setTitle:MUUQYLocalizedString(@"EMKey_Facebook_Text") forState:UIControlStateNormal];
//    [self.em18_fblogBtn setImage:[ZhenwupHelper_Utils imageName:@"zhenwuimlogin_2"] forState:UIControlStateNormal];
    [self.em18_fblogBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
//    self.em18_fblogBtn.backgroundColor = [ZhenwupTheme_Utils em_colors_faceColor];
    [self.em18_fblogBtn setBackgroundImage:[ZhenwupHelper_Utils imageName:@"zhenwuimb3"] forState:0];
    self.em18_fblogBtn.layer.cornerRadius = 6;
    self.em18_fblogBtn.clipsToBounds = true;
    [self.em18_fblogBtn addTarget:self action:@selector(em14_HandleClickedFaceBooklogBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.em18_viewBg addSubview:self.em18_fblogBtn];
    
    
    
    
    self.em11_verifyProtoclBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.em11_verifyProtoclBtn.frame = CGRectMake(28, CGRectGetMaxY( self.em18_fblogBtn.frame)+15+45, 35, 35);
    self.em11_verifyProtoclBtn.contentEdgeInsets = UIEdgeInsetsMake(11.5, 11.5, 11.5, 11.5);
    
    [self.em11_verifyProtoclBtn setImage:[ZhenwupHelper_Utils imageName:@"zhenwuimunPick"] forState:UIControlStateNormal];
    [self.em11_verifyProtoclBtn setImage:[ZhenwupHelper_Utils imageName:@"zhenwuimpick"] forState:UIControlStateSelected];
    self.em11_verifyProtoclBtn.selected = true;
    [self.em11_verifyProtoclBtn addTarget:self action:@selector(onClickRegisterCheckProtoclBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.em11_verifyProtoclBtn];
    
    
    
    
    
    self.khxl_protocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.khxl_protocolBtn.frame = CGRectMake(self.em11_verifyProtoclBtn.em_right+5,self.em11_verifyProtoclBtn.em_top + 5,  self.em18_viewBg.em_width, 25);
    self.khxl_protocolBtn.titleLabel.font = [ZhenwupTheme_Utils em_colors_SmallFont];
    self.khxl_protocolBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.khxl_protocolBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -11.5, 0, 0);
    [self.khxl_protocolBtn setTitle:MUUQYLocalizedString(@"EMKey_RegisterProtocol_Text") forState:UIControlStateNormal];
    [self.khxl_protocolBtn setTitleColor:[ZhenwupTheme_Utils em_colors_GrayColor] forState:UIControlStateNormal];
    [self.khxl_protocolBtn addTarget:self action:@selector(onClickRegisterProtoclBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.khxl_protocolBtn];
    
    
    
    
    if (@available(iOS 13.0, *)) {
        if (EMSDKGlobalInfo.em14_sdkFlag & EM_SDKFlagApple) {
            if (EMSDKGlobalInfo.em14_sdkFlag & EM_SDKFlagFB) {
                
            } else {
                self.em18_fblogBtn.hidden = YES;
                self.em11_verifyProtoclBtn.frame = CGRectMake(28, CGRectGetMaxY( self.em11_cusRegBtn.frame)+15+45, 35, 35);
                self.khxl_protocolBtn.frame = CGRectMake(self.em11_verifyProtoclBtn.em_right+5,self.em11_verifyProtoclBtn.em_top + 5,  self.em18_viewBg.em_width, 25);
            }
        } else {
            if (EMSDKGlobalInfo.em14_sdkFlag & EM_SDKFlagFB) {
            } else {
                self.em18_fblogBtn.hidden = YES;
                self.em11_verifyProtoclBtn.frame = CGRectMake(28, CGRectGetMaxY( self.em11_cusRegBtn.frame)+15+45, 35, 35);
                self.khxl_protocolBtn.frame = CGRectMake(self.em11_verifyProtoclBtn.em_right+5,self.em11_verifyProtoclBtn.em_top + 5,  self.em18_viewBg.em_width, 25);
            }
        }
    } else {
        if (EMSDKGlobalInfo.em14_sdkFlag & EM_SDKFlagFB) {
        } else {
            self.em18_fblogBtn.hidden = YES;
            self.em11_verifyProtoclBtn.frame = CGRectMake(28, CGRectGetMaxY( self.em11_cusRegBtn.frame)+15+45, 35, 35);
            self.khxl_protocolBtn.frame = CGRectMake(self.em11_verifyProtoclBtn.em_right+5,self.em11_verifyProtoclBtn.em_top + 5,  self.em18_viewBg.em_width, 25);
        }
    }
    
   
}
- (void)onClickRegisterCheckProtoclBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
//    [self em14_u_UpdateButtonStates];
}

- (void)onClickRegisterProtoclBtn:(id)sender {
//    self.em11_verifyProtoclBtn.selected = YES;
//    [self em14_u_UpdateButtonStates];
    
    [EMSDKGlobalInfo em14_PresendWithUrlString:EMSDKGlobalInfo.reg_agree];
}

- (void)em14_HandleClickedBackBtn:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(em18_CloseChooseLoginView:loginSucess:)]) {
        [self.delegate em18_CloseChooseLoginView:self loginSucess:NO];
    }
}

- (void)em14_HandleCilckedQuicklogBtn:(id)sender {
    [MBProgressHUD em14_ShowLoadingHUD];
    
    [self em14_dataWithevent:@"clickGuest" WithRe:@""];
    __weak typeof(self) weakSelf = self;
    [self.em14_LoginServer lhxy_QuickLogin:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD em14_DismissLoadingHUD];
        if (result.em14_responseCode == EM_ResponseCodeSuccess) {
 
            [self em14_dataWithevent:@"clickGuestSuccess" WithRe: [result description2]];
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(em18_CloseChooseLoginView:loginSucess:)]) {
                [weakSelf.delegate em18_CloseChooseLoginView:weakSelf loginSucess:YES];
            } else {
                [weakSelf removeFromSuperview];
            }
        } else {
            [self em14_dataWithevent:@"clickGuestFail" WithRe: [result description2]];
            [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
        }
    }];
}

- (void)em14_HandleClickedFaceBooklogBtn:(id)sender {
    
    [self em14_dataWithevent:@"clickFB" WithRe:@""];
    __weak typeof(self) weakSelf = self;
    if (@available(iOS 13.0, *)) {
        [MBProgressHUD em14_ShowLoadingHUD];
    }
    [self.em14_LoginServer lhxy_FacebookLogin:^{
        if (@available(iOS 13.0, *)) {
        } else {
            [MBProgressHUD em14_ShowLoadingHUD];
        }
    } responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD em14_DismissLoadingHUD];
        if (result.em14_responseCode == EM_ResponseCodeSuccess) {
            
            [self em14_dataWithevent:@"clickFBSuccess" WithRe: [result description2]];
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(em18_CloseChooseLoginView:loginSucess:)]) {
                [weakSelf.delegate em18_CloseChooseLoginView:weakSelf loginSucess:YES];
            } else {
                [weakSelf removeFromSuperview];
            }
        } else {
            [self em14_dataWithevent:@"clickFBFail" WithRe: [result description2]];
             [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
        }
    }];
}

- (void)em14_HandleClickedRegisterBtn:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(em18_PresentAccountLoginAndRegisterView:)]) {
        
        
        [self em14_dataWithevent:@"clickEmailOrMobile" WithRe:@""];
        [self.delegate em18_PresentAccountLoginAndRegisterView:self];
    }
}
- (void)em14_dataWithevent:(NSString *)event  WithRe:(NSString *)re{
    [self.em11_AccountServer em14_dataWithevent:event WithRe:re withResponseBlock:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        if (result.em14_responseCode == EM_ResponseCodeSuccess) {
            NSLog(@"%@ ==== 成功",event);
        } else {
            NSLog(@"%@ ==== 失败",event);
        }
    }];
}

@end
