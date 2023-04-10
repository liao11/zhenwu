//
//  ZhenwupBangEmailView.m
//  EmpriSDK
//
//  Created by Admin on 2023/1/28.
//  Copyright © 2023 Admin. All rights reserved.
//

#import "ZhenwupBangEmailView.h"
#import "ZhenwupAccount_Server.h"
#import "NSString+GrossExtension.h"
#import "KeenWireField.h"
#import "ZhenwupVerifyInPutTextField_View.h"
#import "GrossAlertCrlV.h"

@interface ZhenwupBangEmailView () <KeenWireFieldDelegate, EM_VerifyInputTextFieldDelegate>

@property (nonatomic, strong) KeenWireField *em11_bindMail_inputAccView;
@property (nonatomic, strong) ZhenwupVerifyInPutTextField_View *em11_bindMail_inputVerifyView;
@property (nonatomic, strong) UILabel *em18_descLab;
@property (nonatomic, strong) UIButton *em14_bindEmailBtn;
@property (nonatomic, strong) ZhenwupAccount_Server *em11_AccountServer;
@end


@implementation ZhenwupBangEmailView
- (ZhenwupAccount_Server *)em11_AccountServer {
    if (!_em11_AccountServer) {
        _em11_AccountServer = [[ZhenwupAccount_Server alloc] init];
    }
    return _em11_AccountServer;
}
-(void)setupContent{
    //    self.backgroundColor=[UIColor clearColor];
    
    [self em14_ShowTopview:YES];
    
    
    
    
    self.title=MUUQYLocalizedString(@"EMKey_BindEmail_Text");
    
    
    UIView * inputBgView = [[UIView alloc] initWithFrame:CGRectMake(55, 55, self.em_width - 110, 200)];
    [self addSubview:inputBgView];
    
    self.em11_bindMail_inputAccView = [[KeenWireField alloc] initWithFrame:CGRectMake(0, 50, inputBgView.em_width, 50)];
    self.em11_bindMail_inputAccView.em14_TextField.placeholder = MUUQYLocalizedString(@"EMKey_BindEmail_Placeholder_Text");
    self.em11_bindMail_inputAccView.em14_TextField.keyboardType = UIKeyboardTypeEmailAddress;
    self.em11_bindMail_inputAccView.delegate = self;
    [inputBgView addSubview:self.em11_bindMail_inputAccView];
    
//    self.em11_bindMail_inputAccView.em14_fieldLeftIcon.image = [ZhenwupHelper_Utils imageName:@"zhenwuimblueMail"];
    
    self.em11_bindMail_inputAccView.em14_fieldLeftIcon.image = [ZhenwupHelper_Utils imageName:@"zhenwuimacc"];
    self.em11_bindMail_inputAccView.em14_fieldLeftIcon.frame= CGRectMake(13, 11.8+5, 22.3, 16.3);
    
//    self.em14_inputTxtView.em14_fieldLeftIcon.frame= CGRectMake(13, 11.8, 22.3, 16.3);

    self.em11_bindMail_inputVerifyView = [[ZhenwupVerifyInPutTextField_View alloc] initWithFrame:CGRectMake(0, self.em11_bindMail_inputAccView.em_bottom + 20, inputBgView.em_width, 50)];
    self.em11_bindMail_inputVerifyView.em14_TextField.placeholder = MUUQYLocalizedString(@"EMKey_VerifyCode_Placeholder_Text");
    self.em11_bindMail_inputVerifyView.delegate = self;
    [inputBgView addSubview:self.em11_bindMail_inputVerifyView];
    
    inputBgView.em_height = self.em11_bindMail_inputVerifyView.em_bottom;
    
//    self.em11_bindMail_inputVerifyView.em14_fieldLeftIcon.image = [ZhenwupHelper_Utils imageName:@"zhenwuimnewPwd"];
    
    self.em11_bindMail_inputVerifyView.em14_fieldLeftIcon.image = [ZhenwupHelper_Utils imageName:@"zhenwuimnewPwd"];
    self.em11_bindMail_inputVerifyView.em14_fieldLeftIcon.frame= CGRectMake(13, 10.8+5, 18.6, 20.5);
    
    self.em18_descLab = [[UILabel alloc] initWithFrame:CGRectMake(inputBgView.em_left, inputBgView.em_bottom + 10, inputBgView.em_width, 25)];
    self.em18_descLab.font = [ZhenwupTheme_Utils em_colors_NormalFont];
    self.em18_descLab.textColor = [ZhenwupTheme_Utils em14_colorWithHexString:@"#FFFFFF"];
    self.em18_descLab.text = MUUQYLocalizedString(@"EMKey_BindEmail_Tips_Text");
    [self addSubview:self.em18_descLab];
    
    self.em14_bindEmailBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.em14_bindEmailBtn.frame = CGRectMake(0, self.em18_descLab.em_bottom + 20, 160, 35);
    self.em14_bindEmailBtn.titleLabel.font = [ZhenwupTheme_Utils em_colors_NormalFont];
    self.em14_bindEmailBtn.backgroundColor = [ZhenwupTheme_Utils khxl_SmalltitleColor];
    self.em14_bindEmailBtn.layer.cornerRadius = 17.0;
    self.em14_bindEmailBtn.layer.masksToBounds = YES;
    [self.em14_bindEmailBtn setTitle:MUUQYLocalizedString(@"EMKey_ConfirmButton_Text") forState:UIControlStateNormal];
    [self.em14_bindEmailBtn addTarget:self action:@selector(onClickBindEmailBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.em14_bindEmailBtn];
    
//    [self.em14_bindEmailBtn sizeToFit];
//    self.em14_bindEmailBtn.em_size = CGSizeMake(MAX(self.em14_bindEmailBtn.em_width + 30, 120), 34);
    self.em14_bindEmailBtn.em_centerX = self.em_width / 2.0;
}



- (void)onClickBindEmailBtn:(id)sender {
    NSString *email = self.em11_bindMail_inputAccView.em14_TextField.text;
    NSString *verifyCode = self.em11_bindMail_inputVerifyView.em14_TextField.text;
    
    if (!email || [email isEmpty]) {
        [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_BindEmail_Miss_Alert_Text")];
        return;
    }
    if ([email validateEmail] == NO) {
        [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_Email_FormatError_Alert_Text")];
        return;
    }
    if (!verifyCode || [verifyCode isEmpty]) {
        [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_VerifyCode_Miss_Alert_Text")];
        return;
    }
        
    [MBProgressHUD em14_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.em11_AccountServer em11_BindEmail:email withVerifyCode:verifyCode responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD em14_DismissLoadingHUD];
        if (result.em14_responseCode == EM_ResponseCodeSuccess) {
            
            [GrossAlertCrlV showAlertMessage:MUUQYLocalizedString(@"EMKey_BindSuccess_Tips_Text") actionBlock:^(NSString * _Nonnull btnTitle, NSInteger btnIndex) {
                
            } cancelButtonTitle:MUUQYLocalizedString(@"EMKey_ConfirmButton_Text") otherButtonTitles:nil];
            
          
            
           
        } else {
            [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
        }
    }];
}


- (BOOL)em14_HorizontalInputTextFieldViewShouldReturn:(KeenWireField *)inputView {
    if (inputView == self.em11_bindMail_inputAccView) {
        [self.em11_bindMail_inputVerifyView.em14_TextField becomeFirstResponder];
    }
    return YES;
}

- (void)em14_HorizontalInputTextFieldViewTextDidChange:(KeenWireField *)inputView {
    
}


- (BOOL)em14_VerifyInputTextFieldViewShouldReturn:(ZhenwupVerifyInPutTextField_View *)inputView {
    [self onClickBindEmailBtn:nil];
    return YES;
}

- (void)em14_VerifyInputTextFieldViewTextDidChange:(ZhenwupVerifyInPutTextField_View *)inputView {
    
}

- (BOOL)em14_HandleSendVerifyCode:(ZhenwupVerifyInPutTextField_View *)inputView {
    NSString *email = self.em11_bindMail_inputAccView.em14_TextField.text;
    
    if (!email || [email isEmpty]) {
        [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_BindEmail_Miss_Alert_Text")];
        return NO;
    }
    if ([email validateEmail] == NO) {
        [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_Email_FormatError_Alert_Text")];
        return NO;
    }
    
    [self.em11_AccountServer em11_SendBindEmailVerifyCode2Email:email responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        if (result.em14_responseCode == EM_ResponseCodeNetworkError) {
            [inputView em14_ResetNormalSendStates];
        }
        if (result.em14_responseCode != EM_ResponseCodeSuccess) {
            [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
        }
    }];
    return YES;
}
@end
