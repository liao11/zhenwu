//
//  ZhenwupOneClickLoginV2.m
//  EmpriSDK
//
//  Created by Admin on 2023/1/12.
//  Copyright © 2023 Admin. All rights reserved.
//

#import "ZhenwupOneClickLoginV2.h"

#import "NSString+GrossExtension.h"
#import "ZhenwupAccount_Server.h"
#import "KeenWireField.h"
#import "ZhenwupVerifyInPutTextField_View.h"
#import "GrossAlertCrlV.h"
#import "ZhenwupVerifyCodeView.h"
#import "ZhenwupTimerButton_View.h"

#import "ZhenwupWeakProxy_Utils.h"

#define WEAKSELF typeof(self) __weak weakSelf = self;
@interface ZhenwupOneClickLoginV2 () <KeenWireFieldDelegate,EM_VerifyInputTextFieldDelegate>
@property (nonatomic, strong) ZhenwupTimerButton_View *em14_TimerButton;
@property (nonatomic, strong) UIView *khxl_inputBgView;
@property (nonatomic, strong) KeenWireField *em11_inputAccView;
@property (nonatomic, strong) ZhenwupVerifyInPutTextField_View *em11_inputVerifyView;
@property (nonatomic, strong) UIButton *em11_verifyProtoclBtn;
@property (nonatomic, strong) UIButton *khxl_protocolBtn;
@property (nonatomic, strong) UIButton *em18_regBtn;
@property (nonatomic, strong) UIButton *em14_loginBtn;
@property (nonatomic, strong) UILabel  *delab;
@property (nonatomic, strong) ZhenwupAccount_Server *em11_AccountServer;

@property (nonatomic, assign) NSTimeInterval em14_TimeInterval;
@property (nonatomic, strong) NSTimer *em14_Timer;
@property (nonatomic, assign) NSInteger em14_TimeNumber;




@end

@implementation ZhenwupOneClickLoginV2

- (instancetype)init {
    self = [super initWithCurType:@"5"];
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
    self.em14_TimeInterval = 30.0f;
    self.em14_TitleLab.frame =CGRectMake(0, 40, self.em_width, 36);
    self.title = @"Hãy nhập mã xác nhận";
    
    [self em14_ShowBackBtn:YES];
        
    self.khxl_inputBgView = [self em11_mailReg_inputViewWithFrame:CGRectMake(35, 80, self.em_width - 35 - 35, 120)];
    [self addSubview:self.khxl_inputBgView];
    
    self.em18_regBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.em18_regBtn.frame = CGRectMake(100, self.khxl_inputBgView.em_bottom + 15, self.em_width-200, 35);
    self.em18_regBtn.tag = 100;
    self.em18_regBtn.titleLabel.font = [ZhenwupTheme_Utils em_colors_NormalFont];

    self.em18_regBtn.backgroundColor=[UIColor colorWithRed:17/255.0 green:27/255.0 blue:34/255.0 alpha:1];
    self.em18_regBtn.layer.borderColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.6].CGColor;

    self.em18_regBtn.layer.borderWidth = 1;

    self.em18_regBtn.layer.cornerRadius = 17.7;
    self.em18_regBtn.layer.masksToBounds = YES;
    [self.em18_regBtn setTitleColor:[ZhenwupTheme_Utils khxl_SmalltitleColor] forState:UIControlStateNormal];
    [self.em18_regBtn setTitle:@"Gửi mã KH" forState:UIControlStateNormal];
    [self.em18_regBtn addTarget:self action:@selector(em14_HandleClickedSendBtn) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.em18_regBtn];
    
    self.em18_regBtn.em_centerX = self.khxl_inputBgView.em_centerX;
    
    
    ZhenwupVerifyCodeView *codeView  = [[ZhenwupVerifyCodeView alloc] initWithFrame:CGRectMake(35, self.em18_regBtn.em_bottom + 15, self.em_width-70, 50)];
       [self addSubview:self.inputView];
//    codeView.frame =CGRectMake(35, self.em18_regBtn.em_bottom + 150, self.em_width-70, 50);;
    
//    ZhenwupVerifyCodeView *codeView = [[ZhenwupVerifyCodeView alloc] initWithCodeBits:6];
    [self addSubview:codeView];
    
    
    WEAKSELF
    codeView.codeResignCompleted = ^(NSString * _Nonnull content) {
        
            
            //对应位数输入完成时 允许提交按钮有效 允许提交
            NSLog(@"完成%@", content);
        
        [self em_emailTypeRegisterWithUsername:self.email verifyCode:content];
        
//        em_emailTypeRegisterWithUsername
//            weakSelf.submitBtn.enabled = YES;
//            weakSelf.submitBtn.alpha = 1.0f;
        };
        codeView.codeResignUnCompleted = ^(NSString * _Nonnull content) {
            //对应位数未输入完成时 提交按钮失效 不允许提交
//            weakSelf.submitBtn.enabled = NO;
//            weakSelf.submitBtn.alpha = 0.5f;
        };
    
   
    
   
    
    
    
    
    
    
    
    
   
}


- (NSTimer *)em14_Timer {
    if (!_em14_Timer) {
        _em14_Timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:[ZhenwupWeakProxy_Utils proxyWithTarget:self] selector:@selector(em14_RefreshTimer:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_em14_Timer forMode:NSRunLoopCommonModes];
    }
    return _em14_Timer;
}


- (void)em14_RefreshTimer:(NSTimer *)timer {
    if (_em14_TimeNumber <= 0) {
        [self em14_u_StopTimer];
    } else {
        [self.em18_regBtn setTitle:[NSString stringWithFormat:@"%ziS", self.em14_TimeNumber] forState:UIControlStateNormal];
    }
    self.em14_TimeNumber--;
}

- (void)em14_ResetNormalSendStates {
    [self em14_u_StopTimer];
}

- (void)em14_u_StarTimer {
    self.em14_TimeNumber = self.em14_TimeInterval;
    [self.em14_Timer fire];
    self.em18_regBtn.frame = CGRectMake(125, self.khxl_inputBgView.em_bottom + 15, self.em_width-250, 35);
    self.em18_regBtn.enabled = NO;
//    self.em14_Button.backgroundColor = [ZhenwupTheme_Utils em_colors_DisableColor];
    
//    self.em18_regBtn.backgroundColor = [UIColor clearColor];
}

- (void)em14_u_StopTimer {
    if (_em14_Timer != nil) {
        if (_em14_Timer.isValid) {
            [_em14_Timer invalidate];
        }
        _em14_Timer = nil;
    }
    
    self.em18_regBtn.enabled = YES;
    self.em18_regBtn.frame = CGRectMake(100, self.khxl_inputBgView.em_bottom + 15, self.em_width-200, 35);
    [self.em18_regBtn setTitle:@"Gửi mã KH" forState:(UIControlStateNormal)];
//    self.em14_Button.backgroundColor = [ZhenwupTheme_Utils em_colors_ButtonColor];
    
//    self.em14_Button.backgroundColor = [UIColor clearColor];
//    [self.em14_Button setTitleColor:[ZhenwupTheme_Utils khxl_SmalltitleColor] forState:(UIControlStateNormal)];
}

- (void)em14_HandleClickedSendBtn {
    if ([self em14_HandleSendVerifyCode]) {
        [self em14_u_StarTimer];
    } else {
        [self em14_u_StarTimer];
    }
}
- (BOOL)em14_HandleSendVerifyCode {
    NSString *userName = self.email;
    
    if (!userName || [userName isEmpty]) {
        [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_AccountNum_Miss_Alert_Text")];
        return NO;
    }
    
    
    if ([userName validateEmail] == NO) {
        [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_Email_FormatError_Alert_Text")];
        return NO;
    }
    
    [self em11_sendEmailCodeWithUserName:userName ];
    
    return YES;
}



- (BOOL)em14_ClickedTimerButtonView:(ZhenwupTimerButton_View *)view{
    return YES;
}

-(void)setEmailwith:(NSString *)email{
    _delab.text=[NSString stringWithFormat:@"Gửi đến  %@",email];
    self.email=email;
    [self em14_HandleClickedSendBtn];
}

- (UIView *)em11_mailReg_inputViewWithFrame:(CGRect)frame {
    
    UIView *khxl_inputBgView = [[UIView alloc] initWithFrame:frame];
    
    _delab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, khxl_inputBgView.em_width, 30)];
 
    _delab.font = [ZhenwupTheme_Utils em_colors_NormalFont];
//    self.em14_TitleLab.textColor = [ZhenwupTheme_Utils em_colors_LightColor];
    _delab.textColor =  [UIColor colorWithRed:(255)/255.0f green:(255)/255.0f blue:(255)/255.0f alpha:0.5];
    _delab.textAlignment = NSTextAlignmentCenter;
    [khxl_inputBgView addSubview:_delab];


    khxl_inputBgView.em_height = self.delab.em_bottom;
        
    return khxl_inputBgView;
}


- (void)em14_u_UpdateButtonStates {
    UIButton *em14_regBtn = [self viewWithTag:100];
    if (self.em11_inputAccView.em14_TextField.text.length > 0 && self.em11_inputVerifyView.em14_TextField.text.length > 0 && self.em11_verifyProtoclBtn.selected) {
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
    
    
    
    
    if (_delegate && [_delegate respondsToSelector:@selector(em11_2HandlePopToLastV:)]) {
        [_delegate em11_2HandlePopToLastV:self];
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
    if (_delegate && [_delegate respondsToSelector:@selector(em18_2PresentFromOneClickToLogin:)]) {
        [_delegate em18_2PresentFromOneClickToLogin:self];
    }
}


- (void)em11_sendEmailCodeWithUserName:(NSString *)userName
{
    [self.em11_AccountServer em11_SendRegisterVerify2Email:userName responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        if (result.em14_responseCode == EM_ResponseCodeNetworkError) {
            [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
            
            
        }
        if (result.em14_responseCode != EM_ResponseCodeSuccess) {
            [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
        }
        if (result.em14_responseCode == EM_ResponseCodeSuccess) {
            [MBProgressHUD em14_showSuccess_Toast:result.em14_responeMsg];
        }

    }];
}



- (void)onClickRegisterBtn:(id)sender {
    
    [self em14_HandleSendVerifyCode];
    
    
//    NSString *userName = self.em11_inputAccView.em14_TextField.text;
//    NSString *verifyCode = self.em11_inputVerifyView.em14_TextField.text;
//    [self em_emailTypeRegisterWithUsername:userName verifyCode:verifyCode];
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
            [self em14_dataWithevent:@"clickEmailFastSuccess" WithRe: [result description2]];

            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(em11_2HandleDidOneClickEmailSuccess:)]) {
                [weakSelf.delegate em11_2HandleDidOneClickEmailSuccess:weakSelf];
            }
        } else {
            
            [self em14_dataWithevent:@"clickEmailFastFail" WithRe: [result description2]];
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
