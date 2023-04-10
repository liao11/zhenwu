//
//  ZhenwupAccountEditView.m
//  EmpriSDK
//
//  Created by Admin on 2023/1/28.
//  Copyright © 2023 Admin. All rights reserved.
//

#import "ZhenwupAccountEditView.h"
#import "ZhenwupAccount_Server.h"
#import "NSString+GrossExtension.h"
#import "KeenWireField.h"
#import "ZhenwupVerifyInPutTextField_View.h"
#import "GrossAlertCrlV.h"
#import "ZhenwupSegView.h"
#import "ZhenwupLocalData_Server.h"
@interface ZhenwupAccountEditView () <KeenWireFieldDelegate, EM_VerifyInputTextFieldDelegate,EmpriSegViewDelegate>


@property (nonatomic, assign) NSInteger zwp01_type;
@property (nonatomic, strong) KeenWireField *em14_Mail_InputView;
@property (nonatomic, strong) ZhenwupVerifyInPutTextField_View *em14_VerifyCode_InputView;
@property (nonatomic, strong) KeenWireField *em14_Pwd_InputView;
@property (nonatomic, strong) KeenWireField *em14_Pwd2_InputView;
@property (nonatomic, strong) UIButton *em11_resetBtn;

@property (nonatomic, strong) ZhenwupAccount_Server *em11_AccountServer;
@property (nonatomic, strong) ZhenwupAccount_Server *em14_AccountServer;

@end
@implementation ZhenwupAccountEditView

- (ZhenwupAccount_Server *)em11_AccountServer {
    if (!_em11_AccountServer) {
        _em11_AccountServer = [[ZhenwupAccount_Server alloc] init];
    }
    return _em11_AccountServer;
}

- (ZhenwupAccount_Server *)em14_AccountServer {
    if (!_em14_AccountServer) {
        _em14_AccountServer = [[ZhenwupAccount_Server alloc] init];
    }
    return _em14_AccountServer;
}
-(void)setupContent{
    //    self.backgroundColor=[UIColor clearColor];
    
    [self em14_ShowTopview:YES];
    
    
    
    
    self.title=MUUQYLocalizedString(@"EMKey_PersonCenter_Text");
    
    
    
    UIView * inputBgView = [[UIView alloc] initWithFrame:CGRectMake(50, 55, self.em_width - 100, self.em_height-100)];
    [self addSubview:inputBgView];
    
    
    
    self.em14_Mail_InputView = [[KeenWireField alloc] initWithFrame:CGRectMake(0, 20, inputBgView.em_width, 50)];
    self.em14_Mail_InputView.em14_TextField.placeholder = MUUQYLocalizedString(@"EMKey_Email_Placeholder_Text1");
    self.em14_Mail_InputView.em14_TextField.keyboardType = UIKeyboardTypeEmailAddress;
    self.em14_Mail_InputView.delegate = self;
    [inputBgView addSubview:self.em14_Mail_InputView];
//    self.em14_Mail_InputView.em14_fieldLeftIcon.image = [ZhenwupHelper_Utils imageName:@"zhenwuimacc"];
    
    self.em14_Mail_InputView.em14_fieldLeftIcon.image = [ZhenwupHelper_Utils imageName:@"zhenwuimacc"];
    self.em14_Mail_InputView.em14_fieldLeftIcon.frame= CGRectMake(13, 11.8+5, 22.3, 16.3);

    self.zwp01_type = 0;
 
     self.em14_Mail_InputView.em14_TextField.text = EMSDKGlobalInfo.userInfo.userName;

  
    
   
    
    self.em14_VerifyCode_InputView = [[ZhenwupVerifyInPutTextField_View alloc] initWithFrame:CGRectMake(0, self.em14_Mail_InputView.em_bottom + 20, inputBgView.em_width, 50)];
    self.em14_VerifyCode_InputView.em14_TextField.placeholder = MUUQYLocalizedString(@"EMKey_VerifyCode_Placeholder_Text");
    self.em14_VerifyCode_InputView.delegate = self;
    [inputBgView addSubview:self.em14_VerifyCode_InputView];
    self.em14_VerifyCode_InputView.em14_fieldLeftIcon.image = [ZhenwupHelper_Utils imageName:@"zhenwuimnewPwd"];
    self.em14_VerifyCode_InputView.em14_fieldLeftIcon.frame= CGRectMake(13, 10.8+5, 18.6, 20.5);
    
    
    self.em14_Pwd_InputView = [[KeenWireField alloc] initWithFrame:CGRectMake(0, self.em14_VerifyCode_InputView.em_bottom + 20, inputBgView.em_width, 50)];
    self.em14_Pwd_InputView.em14_TextField.placeholder = MUUQYLocalizedString(@"EMKey_NewPassword_Placeholder_Text");
    self.em14_Pwd_InputView.em14_TextField.secureTextEntry = YES;
    self.em14_Pwd_InputView.delegate = self;
    [inputBgView addSubview:self.em14_Pwd_InputView];
    self.em14_Pwd_InputView.em14_fieldLeftIcon.image = [ZhenwupHelper_Utils imageName:@"zhenwuimresetPwd"];
    
//    self.em14_inputPsdView.em14_fieldLeftIcon.image = [ZhenwupHelper_Utils imageName:@"zhenwuimresetPwd"];
    self.em14_Pwd_InputView.em14_fieldLeftIcon.frame= CGRectMake(13, 10.8+5, 18.5, 20.7);
    
    self.em14_Pwd2_InputView = [[KeenWireField alloc] initWithFrame:CGRectMake(0, self.em14_Pwd_InputView.em_bottom + 20, inputBgView.em_width, 50)];
    self.em14_Pwd2_InputView.em14_TextField.placeholder = MUUQYLocalizedString(@"EMKey_NewPasswordAgain_Placeholder_Text");
    self.em14_Pwd2_InputView.em14_TextField.secureTextEntry = YES;
    self.em14_Pwd2_InputView.delegate = self;
    [inputBgView addSubview:self.em14_Pwd2_InputView];
    self.em14_Pwd2_InputView.em14_fieldLeftIcon.image = [ZhenwupHelper_Utils imageName:@"zhenwuimresetPwd"];
    self.em14_Pwd2_InputView.em14_fieldLeftIcon.frame= CGRectMake(13, 10.8+5, 18.5, 20.7);
    inputBgView.em_height = self.em14_Pwd2_InputView.em_bottom;
    
    self.em11_resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.em11_resetBtn.frame = CGRectMake(0, inputBgView.em_bottom + 20, 127, 34);
    self.em11_resetBtn.titleLabel.font = [ZhenwupTheme_Utils em_colors_NormalFont];

    [self.em11_resetBtn setBackgroundImage:[ZhenwupHelper_Utils imageName:@"zhenwuimb5"] forState:0];
    self.em11_resetBtn.layer.masksToBounds = YES;
    self.em11_resetBtn.tag = 100;
    [self.em11_resetBtn setTitle:MUUQYLocalizedString(@"EMKey_ConfirmButton_Text") forState:UIControlStateNormal];
    [self.em11_resetBtn addTarget:self action:@selector(em14_HandleResetPwdBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.em11_resetBtn];
    
//    [self.em11_resetBtn sizeToFit];
    self.em11_resetBtn.em_size = CGSizeMake(MAX(self.em11_resetBtn.em_width + 30, 127), 34);
    self.em11_resetBtn.em_centerX = self.em_centerX;
    
  
    

    [self em14_u_UpdateButtonStates];
   
}

- (void)em14_u_UpdateButtonStates {
    UIButton *confirmBtn = [self viewWithTag:100];
    if (self.em14_Mail_InputView.em14_TextField.text.length > 0 && self.em14_VerifyCode_InputView.em14_TextField.text.length > 0 && self.em14_Pwd_InputView.em14_TextField.text.length > 0 && self.em14_Pwd2_InputView.em14_TextField.text.length > 0) {
        confirmBtn.enabled = YES;
//        confirmBtn.backgroundColor = [ZhenwupTheme_Utils em_colors_ButtonColor];
        [self.em11_resetBtn setBackgroundImage:[ZhenwupHelper_Utils imageName:@"zhenwuimb5"] forState:0];
    } else {
        [self.em11_resetBtn setBackgroundImage:[ZhenwupHelper_Utils imageName:@"zhenwuimb4"] forState:0];
        confirmBtn.enabled = NO;
//        confirmBtn.backgroundColor = [ZhenwupTheme_Utils em_colors_DisableColor];
    }
}

- (void)em14_HandleResetPwdBtn:(id)sender {
    NSString *email = self.em14_Mail_InputView.em14_TextField.text;
    NSString *password = self.em14_Pwd_InputView.em14_TextField.text;
    NSString *password2 = self.em14_Pwd2_InputView.em14_TextField.text;
    NSString *verifyCode = self.em14_VerifyCode_InputView.em14_TextField.text;

    if (self.zwp01_type == 0)
    {
        if (!email || [email isEmpty]) {
            [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_Email_Miss_Alert_Text")];
            return;
        }
        if ([email validateEmail] == NO) {
            [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_Email_FormatError_Alert_Text")];
            return;
        }
    }else{
        if (!email || [email isEmpty]) {
            [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_pleaseTel")];
            return;
        }
        if ([email isValidateMobile] == NO) {
            [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_rightTel")];
            return;
        }
    }
    
    if (!verifyCode || [verifyCode isEmpty]) {
        [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_VerifyCode_Miss_Alert_Text")];
        return;
    }
    if (!password || [password isEmpty] || !password2 || [password2 isEmpty]) {
        [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_Password_Miss_Alert_Text")];
        return;
    }
    if ([password2 isEqualToString:password] == NO) {
        [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_Password_2EnterNoMatch_Alert_Text")];
        return;
    }
    if ([password validatePassword] == NO) {
        [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_Password_FormatError_Alert_Text")];
        return;
    }
    if (password.length < 6 || password.length > 20) {
        [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_Password_LengthError_Alert_Text")];
        return;
    }
    
    
    if (self.zwp01_type == 0)
    {
        [self em_ResetEmailWithEmail:email password:password verifyCode:verifyCode sender:sender];
    }else{
        [self em_ResetTelWithTel:email password:password verifyCode:verifyCode sender:sender];
    }
    
}
- (void)em_ResetEmailWithEmail:(NSString *)email password:(NSString *)password verifyCode:(NSString *)verifyCode sender:(id)sender{
    [MBProgressHUD em14_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    
   
    
    [self.em14_AccountServer em11_ResetPwdWithBindEmail:email verifyCode:verifyCode newPassword:password responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD em14_DismissLoadingHUD];
        if (result.em14_responseCode == EM_ResponseCodeSuccess) {
            [ZhenwupLocalData_Server  em14_UpdataUserWithusername:email andpsw:[[password hash_md5] uppercaseString]];
            
           
            
            [GrossAlertCrlV showAlertTitle:MUUQYLocalizedString(@"EMKey_ResetPassword_Text") message:MUUQYLocalizedString(@"EMKey_ResetSuccess_Tips_Text") actionBlock:^(NSString * _Nonnull btnTitle, NSInteger btnIndex) {
                
            } cancelButtonTitle:MUUQYLocalizedString(@"EMKey_ConfirmButton_Text") otherButtonTitles:nil];
            
//            [weakSelf em14_HandleClickedBackBtn:sender];
        } else {
          
            [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
        }
    }];
}

- (void)em_ResetTelWithTel:(NSString *)tel password:(NSString *)password verifyCode:(NSString *)verifyCode sender:(id)sender{
    [MBProgressHUD em14_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
  
    [self.em14_AccountServer em11_ResetPwdWithBindTel:tel verifyCode:verifyCode newPassword:password em11_ut:@"2" zwp01_telDist:@"84" responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD em14_DismissLoadingHUD];
        if (result.em14_responseCode == EM_ResponseCodeSuccess) {
            
            [ZhenwupLocalData_Server  em14_UpdataUserWithusername:tel andpsw:[[password hash_md5] uppercaseString]];
       
          
            [GrossAlertCrlV showAlertTitle:MUUQYLocalizedString(@"EMKey_ResetPassword_Text") message:MUUQYLocalizedString(@"EMKey_ResetSuccess_Tips_Text") actionBlock:^(NSString * _Nonnull btnTitle, NSInteger btnIndex) {
                
            } cancelButtonTitle:MUUQYLocalizedString(@"EMKey_ConfirmButton_Text") otherButtonTitles:nil];
            
//            [weakSelf em14_HandleClickedBackBtn:sender];
        } else {
          
            [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
        }
    }];
}

@end
