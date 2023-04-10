//
//  ZhenwupOneClickLoginV.m
//  GiguoFrameWork
//
//  Created by Admin on 2022/5/25.
//  Copyright © 2022 Admin. All rights reserved.
//

#import "ZhenwupOneClickLoginV.h"
#import "NSString+GrossExtension.h"
#import "ZhenwupAccount_Server.h"
#import "KeenWireField.h"
#import "ZhenwupVerifyInPutTextField_View.h"
#import "GrossAlertCrlV.h"

@interface ZhenwupOneClickLoginV () <KeenWireFieldDelegate,EM_VerifyInputTextFieldDelegate>

@property (nonatomic, strong) UIView *khxl_inputBgView;
@property (nonatomic, strong) KeenWireField *em11_inputAccView;
@property (nonatomic, strong) ZhenwupVerifyInPutTextField_View *em11_inputVerifyView;
@property (nonatomic, strong) UIButton *em11_verifyProtoclBtn;
@property (nonatomic, strong) UIButton *khxl_protocolBtn;
@property (nonatomic, strong) UIButton *em18_regBtn;
@property (nonatomic, strong) UIButton *em14_loginBtn;
@property (nonatomic, strong) ZhenwupAccount_Server *em11_AccountServer;
//@property (nonatomic, strong) ZhenwupAccount_Server *em11_AccountServer;

@end

@implementation ZhenwupOneClickLoginV

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


- (void)em14_setupViews {
    self.em14_TitleLab.frame =CGRectMake(0, 40, self.em_width, 36);
    self.title = MUUQYLocalizedString(@"EMKey_SuperLogin");
    
    [self em14_ShowBackBtn:YES];
        
    self.khxl_inputBgView = [self em11_mailReg_inputViewWithFrame:CGRectMake(35, 80, self.em_width - 35 - 35, 120)];
    [self addSubview:self.khxl_inputBgView];
            
    self.em18_regBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.em18_regBtn.frame = CGRectMake(0, self.khxl_inputBgView.em_bottom + 15, self.khxl_inputBgView.em_width, 40);
    self.em18_regBtn.tag = 100;
    self.em18_regBtn.titleLabel.font = [ZhenwupTheme_Utils em_colors_NormalFont];
//    self.em18_regBtn.backgroundColor = [ZhenwupTheme_Utils khxl_SmallGrayColor];
    
    [self.em18_regBtn setBackgroundImage:[ZhenwupHelper_Utils imageName:@"zhenwuimb5"] forState:0];
    
//    [self.em11_gstLogBtn setBackgroundImage:[ZhenwupHelper_Utils imageName:@"zhenwuimb1"] forState:0];
    self.em18_regBtn.layer.cornerRadius = 20.0;
    self.em18_regBtn.layer.masksToBounds = YES;
//    [self.em18_regBtn setTitle:MUUQYLocalizedString(@"EMKey_ConfirmRegister_Text") forState:UIControlStateNormal];
    [self.em18_regBtn setTitle:@"Đăng nhập/Đăng ký email" forState:UIControlStateNormal];
    [self.em18_regBtn addTarget:self action:@selector(onClickRegisterBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.em18_regBtn];
    
    
    
    self.em18_regBtn.em_centerX = self.khxl_inputBgView.em_centerX;
        
    self.em11_verifyProtoclBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.em11_verifyProtoclBtn.frame = CGRectMake(self.khxl_inputBgView.em_left - 11.5, self.em18_regBtn.em_bottom + 15, 35, 35);
    self.em11_verifyProtoclBtn.contentEdgeInsets = UIEdgeInsetsMake(11.5, 11.5, 11.5, 11.5);
    
    [self.em11_verifyProtoclBtn setImage:[ZhenwupHelper_Utils imageName:@"zhenwuimunPick"] forState:UIControlStateNormal];
    [self.em11_verifyProtoclBtn setImage:[ZhenwupHelper_Utils imageName:@"zhenwuimpick"] forState:UIControlStateSelected];
    self.em11_verifyProtoclBtn.selected = true;
    [self.em11_verifyProtoclBtn addTarget:self action:@selector(onClickRegisterCheckProtoclBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.em11_verifyProtoclBtn];
            
    self.khxl_protocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.khxl_protocolBtn.frame = CGRectMake(self.em11_verifyProtoclBtn.em_right+5, self.em11_verifyProtoclBtn.em_top + 5, self.khxl_inputBgView.em_width-self.em11_verifyProtoclBtn.em_width-5, 25);
    self.khxl_protocolBtn.titleLabel.font = [ZhenwupTheme_Utils em_colors_SmallFont];
    self.khxl_protocolBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.khxl_protocolBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -11.5, 0, 0);
    [self.khxl_protocolBtn setTitle:MUUQYLocalizedString(@"EMKey_RegisterProtocol_Text") forState:UIControlStateNormal];
    [self.khxl_protocolBtn setTitleColor:[ZhenwupTheme_Utils em_colors_GrayColor] forState:UIControlStateNormal];
    [self.khxl_protocolBtn addTarget:self action:@selector(onClickRegisterProtoclBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.khxl_protocolBtn];
    
    self.em14_loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.em14_loginBtn.frame = CGRectMake(0, self.khxl_protocolBtn.em_bottom + 10, 150, 40);
    self.em14_loginBtn.titleLabel.font = [ZhenwupTheme_Utils em_colors_LargeFont];
    self.em14_loginBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.em14_loginBtn setTitle:MUUQYLocalizedString(@"EMKey_EmailFastLogin") forState:UIControlStateNormal];
    [self.em14_loginBtn setTitleColor:[ZhenwupTheme_Utils khxl_SmallGrayColor] forState:UIControlStateNormal];
    [self.em14_loginBtn addTarget:self action:@selector(em14_HandleClickedToLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.em14_loginBtn];
    self.em14_loginBtn.em_centerX = self.khxl_inputBgView.em_centerX;
    
    UIView *em11_lineV = [[UIView alloc] initWithFrame:CGRectMake(0, self.em14_loginBtn.em_bottom, 120, 0.55)];
    em11_lineV.backgroundColor = [ZhenwupTheme_Utils khxl_SmallGrayColor];
    [self addSubview:em11_lineV];
    em11_lineV.em_centerX = self.khxl_inputBgView.em_centerX;
    
    [self em14_u_UpdateButtonStates];
}

- (UIView *)em11_mailReg_inputViewWithFrame:(CGRect)frame {
    
    UIView *khxl_inputBgView = [[UIView alloc] initWithFrame:frame];
    
    self.em11_inputAccView = [[KeenWireField alloc] initWithFrame:CGRectMake(0, 25, khxl_inputBgView.em_width, 40)];
//    self.em11_inputAccView.em14_TextField.placeholder = MUUQYLocalizedString(@"EMKey_Email_Placeholder_Text");
    
    self.em11_inputAccView.em14_TextField.placeholder = MUUQYLocalizedString(@"EMKey_Email_Placeholder_Text");
    self.em11_inputAccView.em14_TextField.keyboardType = UIKeyboardTypeEmailAddress;
    self.em11_inputAccView.delegate = self;
    [khxl_inputBgView addSubview:self.em11_inputAccView];
    
    self.em11_inputAccView.em14_fieldLeftIcon.image = [ZhenwupHelper_Utils imageName:@"zhenwuimblueMail"];
    
    
    self.em11_inputAccView.em14_fieldLeftIcon.frame= CGRectMake(13, 11.8, 22.3, 16.3);
    
//    self.em11_inputVerifyView = [[ZhenwupVerifyInPutTextField_View alloc] initWithFrame:CGRectMake(0, self.em11_inputAccView.em_bottom + 10, khxl_inputBgView.em_width, 40)];
//    self.em11_inputVerifyView.em14_TextField.placeholder = MUUQYLocalizedString(@"EMKey_VerifyCode_Placeholder_Text");
//    self.em11_inputVerifyView.em14_TextField.keyboardType = UIKeyboardTypeNumberPad;
//    self.em11_inputVerifyView.delegate = self;
//    [khxl_inputBgView addSubview:self.em11_inputVerifyView];
//
//    self.em11_inputVerifyView.em14_fieldLeftIcon.image = [ZhenwupHelper_Utils imageName:@"zhenwuimnewPwd"];
    
    khxl_inputBgView.em_height = self.em11_inputAccView.em_bottom;
        
    return khxl_inputBgView;
}


- (void)em14_u_UpdateButtonStates {
    UIButton *em14_regBtn = [self viewWithTag:100];
    if (self.em11_inputAccView.em14_TextField.text.length > 0 && self.em11_verifyProtoclBtn.selected) {
        em14_regBtn.enabled = YES;
        
       [ em14_regBtn setBackgroundImage: [ZhenwupHelper_Utils imageName:@"zhenwuimb5"] forState:0];
//        em14_regBtn.backgroundColor = [ZhenwupTheme_Utils em_colors_ButtonColor];
    } else {
        [ em14_regBtn setBackgroundImage: [ZhenwupHelper_Utils imageName:@"zhenwuimb5"] forState:0];
        em14_regBtn.enabled = NO;
//        em14_regBtn.backgroundColor = [ZhenwupTheme_Utils em_colors_DisableColor];
    }
}


- (void)em14_HandleClickedBackBtn:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(em11_HandlePopToLastV:)]) {
        [_delegate em11_HandlePopToLastV:self];
    }
}


- (void)onClickRegisterCheckProtoclBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self em14_u_UpdateButtonStates];
}

- (void)onClickRegisterProtoclBtn:(id)sender {
    self.em11_verifyProtoclBtn.selected = YES;
    [self em14_u_UpdateButtonStates];
    
    [EMSDKGlobalInfo em14_PresendWithUrlString:EMSDKGlobalInfo.reg_agree];
}

- (void)em14_HandleClickedToLogin:(id)sender{
    if (_delegate && [_delegate respondsToSelector:@selector(em18_PresentFromOneClickToLogin:)]) {
        [_delegate em18_PresentFromOneClickToLogin:self];
    }
}

- (void)onClickRegisterBtn:(id)sender {
    
    
    
    [self em14_HandleSendVerifyCode];
    
    
    
    
//    NSString *userName = self.em11_inputAccView.em14_TextField.text;
//    NSString *verifyCode = self.em11_inputVerifyView.em14_TextField.text;
//    [self em_emailTypeRegisterWithUsername:userName verifyCode:verifyCode];
}


- (BOOL)em14_HandleSendVerifyCode {
    NSString *userName = self.em11_inputAccView.em14_TextField.text;
    
    if (!userName || [userName isEmpty]) {
        [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_AccountNum_Miss_Alert_Text")];
        return NO;
    }
    
    
    if ([userName validateEmail] == NO) {
        [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_Email_FormatError_Alert_Text")];
        return NO;
    }
    
    
    [self em14_dataWithevent:@"clickEmailFast" WithRe:@""];
    
    [self em11_sendEmailCodeWithUserName:userName ];
    
    return YES;
}

- (void)em11_sendEmailCodeWithUserName:(NSString *)userName
{
    
//    NSString *userName = self.em11_inputAccView.em14_TextField.text;
    if (_delegate && [_delegate respondsToSelector:@selector(em11_HandEmailwithEmial:withView:)]) {
        [_delegate em11_HandEmailwithEmial:userName withView:self];
    }
    
    
//    [self.em11_AccountServer em11_SendRegisterVerify2Email:userName responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull result) {
//        if (result.em14_responseCode == EM_ResponseCodeNetworkError) {
//            [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
//
//
//        }
//        if (result.em14_responseCode != EM_ResponseCodeSuccess) {
//            [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
//
//        }
//
//        if (result.em14_responseCode == EM_ResponseCodeSuccess) {
//            NSString *userName = self.em11_inputAccView.em14_TextField.text;
//            if (_delegate && [_delegate respondsToSelector:@selector(em11_HandEmailwithEmial:withView:)]) {
//                [_delegate em11_HandEmailwithEmial:userName withView:self];
//            }
//        }
//    }];
}

- (void)em_emailTypeRegisterWithUsername:(NSString *)userName verifyCode:(NSString *)verifyCode
{
    if (!userName || [userName isEmpty]) {
        [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_Email_Miss_Alert_Text")];
        return;
    }
    if ([userName validateEmail] == NO) {
        [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_Email_FormatError_Alert_Text")];
        return;
    }
    if (!verifyCode || [verifyCode isEmpty]) {
        [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_VerifyCode_Miss_Alert_Text")];
        return;
    }
    [MBProgressHUD em14_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.em11_AccountServer em11_RegisterAccountWithUserName:userName password:@"" verifyCode:verifyCode regType:@"2" responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD em14_DismissLoadingHUD];
        if (result.em14_responseCode == EM_ResponseCodeSuccess) {

            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(em11_HandleDidOneClickEmailSuccess:)]) {
                [weakSelf.delegate em11_HandleDidOneClickEmailSuccess:weakSelf];
            }
        } else {
            [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
        }
    }];
}

- (BOOL)em14_InputTextFieldViewShouldReturn:(KeenWireField *)inputView {
    if (inputView == self.em11_inputAccView) {
        [self.em11_inputVerifyView.em14_TextField becomeFirstResponder];
    }
    return YES;
}

- (void)em14_InputTextFieldViewTextDidChange:(KeenWireField *)inputView {
    [self em14_u_UpdateButtonStates];
}

- (BOOL)em14_VerifyInputTextFieldViewShouldReturn:(ZhenwupVerifyInPutTextField_View *)inputView {
    [self onClickRegisterBtn:nil];
    return YES;
}

- (void)em14_VerifyInputTextFieldViewTextDidChange:(ZhenwupVerifyInPutTextField_View *)inputView {
    [self em14_u_UpdateButtonStates];
}

- (BOOL)em14_HandleSendVerifyCode:(ZhenwupVerifyInPutTextField_View *)inputView {
    NSString *userName = self.em11_inputAccView.em14_TextField.text;
    
    if (!userName || [userName isEmpty]) {
        [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_AccountNum_Miss_Alert_Text")];
        return NO;
    }
    
    [self em11_sendEmailCodeWithUserName:userName andInputView:inputView];
    
    return YES;
}

- (void)em11_sendEmailCodeWithUserName:(NSString *)userName andInputView:(ZhenwupVerifyInPutTextField_View *)inputView
{
    [self.em11_AccountServer em11_SendRegisterVerify2Email:userName responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        if (result.em14_responseCode == EM_ResponseCodeNetworkError) {
            [inputView em14_ResetNormalSendStates];
        }
        if (result.em14_responseCode != EM_ResponseCodeSuccess) {
            [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
        }
    }];
}
- (void)em14_dataWithevent:(NSString *)event  WithRe:(NSString *)re{
    [self.em11_AccountServer em14_dataWithevent:event WithRe:re withResponseBlock:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        if (result.em14_responseCode == EM_ResponseCodeSuccess) {
            
        } else {
            
        }
    }];
}

@end
