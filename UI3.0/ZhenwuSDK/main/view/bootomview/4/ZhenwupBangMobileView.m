//
//  ZhenwupBangMobileView.m
//  EmpriSDK
//
//  Created by Admin on 2023/1/28.
//  Copyright © 2023 Admin. All rights reserved.
//

#import "ZhenwupBangMobileView.h"
#import "ZhenwupAccount_Server.h"
#import "NSString+GrossExtension.h"
#import "KeenWireField.h"
#import "ZhenwupVerifyInPutTextField_View.h"
#import "GrossAlertCrlV.h"
#import "ZhenwupLogin_Server.h"

@interface ZhenwupBangMobileView () <KeenWireFieldDelegate, EM_VerifyInputTextFieldDelegate>

@property (nonatomic, strong) KeenWireField *em_bindTel_inputAccView;
@property (nonatomic, strong) ZhenwupVerifyInPutTextField_View *em14_bindTel_inputVerifyView;
@property (nonatomic, strong) UILabel *em18_descLab;
@property (nonatomic, strong) UIButton *em18_bindTelBtn;
@property (nonatomic, strong) ZhenwupAccount_Server *em11_AccountServer;
@end
@implementation ZhenwupBangMobileView
- (ZhenwupAccount_Server *)em11_AccountServer {
    if (!_em11_AccountServer) {
        _em11_AccountServer = [[ZhenwupAccount_Server alloc] init];
    }
    return _em11_AccountServer;
}
-(void)setupContent{
    //    self.backgroundColor=[UIColor clearColor];
    
    [self em14_ShowTopview:YES];
    
    
    
    
    self.title=MUUQYLocalizedString(@"EMKey_tiTel");
    
    
    UIView * inputBgView = [[UIView alloc] initWithFrame:CGRectMake(55, 55, self.em_width - 110, 100)];
    [self addSubview:inputBgView];
    
    self.em_bindTel_inputAccView = [[KeenWireField alloc] initWithFrame:CGRectMake(0, 50, inputBgView.em_width, 50)];
    self.em_bindTel_inputAccView.em14_TextField.placeholder = MUUQYLocalizedString(@"EMKey_pleaseTel");
    self.em_bindTel_inputAccView.em14_TextField.keyboardType = UIKeyboardTypeEmailAddress;
    self.em_bindTel_inputAccView.delegate = self;
    [inputBgView addSubview:self.em_bindTel_inputAccView];
    
//    self.em_bindTel_inputAccView.em14_fieldLeftIcon.image = [ZhenwupHelper_Utils imageName:@"zhenwuimmobile"];
    
    self.em_bindTel_inputAccView.em14_fieldLeftIcon.image = [ZhenwupHelper_Utils imageName:@"zhenwuimphone"];
//    self.em14_inputTxtView.em14_fieldLeftIcon.frame
    self.em_bindTel_inputAccView.em14_fieldLeftIcon.frame= CGRectMake(13, 10+5, 13.1, 20);
    

    self.em14_bindTel_inputVerifyView = [[ZhenwupVerifyInPutTextField_View alloc] initWithFrame:CGRectMake(0, self.em_bindTel_inputAccView.em_bottom + 20, inputBgView.em_width, 50)];
    self.em14_bindTel_inputVerifyView.em14_TextField.placeholder = MUUQYLocalizedString(@"EMKey_pleaseVerify");
    self.em14_bindTel_inputVerifyView.delegate = self;
    [inputBgView addSubview:self.em14_bindTel_inputVerifyView];
    
    inputBgView.em_height = self.em14_bindTel_inputVerifyView.em_bottom;
    
    self.em14_bindTel_inputVerifyView.em14_fieldLeftIcon.image = [ZhenwupHelper_Utils imageName:@"zhenwuimnewPwd"];
    
//    self.em14_VerifyCode_InputView.em14_fieldLeftIcon.image = [ZhenwupHelper_Utils imageName:@"zhenwuimnewPwd"];
    self.em14_bindTel_inputVerifyView.em14_fieldLeftIcon.frame= CGRectMake(13, 10.8+5, 18.6, 20.5);
    
    
    
    self.em18_descLab = [[UILabel alloc] initWithFrame:CGRectMake(inputBgView.em_left, inputBgView.em_bottom + 10, inputBgView.em_width, 25)];
    self.em18_descLab.font = [ZhenwupTheme_Utils em_colors_NormalFont];
    self.em18_descLab.textColor = [ZhenwupTheme_Utils em14_colorWithHexString:@"#FFFFFF"];
    self.em18_descLab.text = MUUQYLocalizedString(@"EMKey_BindTel_Tips_Text");
    [self addSubview:self.em18_descLab];
    
    self.em18_bindTelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.em18_bindTelBtn.frame = CGRectMake(0, self.em18_descLab.em_bottom + 20, 160, 35);
    self.em18_bindTelBtn.titleLabel.font = [ZhenwupTheme_Utils em_colors_NormalFont];
    self.em18_bindTelBtn.backgroundColor = [ZhenwupTheme_Utils khxl_SmalltitleColor];
    
//    [self.em18_bindTelBtn setBackgroundImage:[ZhenwupHelper_Utils imageName:@"zhenwuimb5"] forState:0];
    self.em18_bindTelBtn.layer.cornerRadius = 17.0;
    self.em18_bindTelBtn.layer.masksToBounds = YES;
    [self.em18_bindTelBtn setTitle:MUUQYLocalizedString(@"EMKey_ConfirmButton_Text") forState:UIControlStateNormal];
    [self.em18_bindTelBtn addTarget:self action:@selector(em_onClickBindTelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.em18_bindTelBtn];
    
//    [self.em18_bindTelBtn sizeToFit];
//    self.em18_bindTelBtn.em_size = CGSizeMake(MAX(self.em18_bindTelBtn.em_width + 30, 120), 34);
    self.em18_bindTelBtn.em_centerX = self.em_width / 2.0;
}
- (void)em_onClickBindTelBtn:(id)sender {
    NSString *tel = self.em_bindTel_inputAccView.em14_TextField.text;
    NSString *verifyCode = self.em14_bindTel_inputVerifyView.em14_TextField.text;
    
    if (!tel || [tel isEmpty]) {
        [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_pleaseTel")];
        return;
    }
    if ([tel isValidateMobile] == NO) {
        [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_rightTel")];
        return;
    }
    if (!verifyCode || [verifyCode isEmpty]) {
        [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_VerifyCode_Miss_Alert_Text")];
        return;
    }
        
    [MBProgressHUD em14_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.em11_AccountServer em11_bindMobileCodeRequestWithem14_telNum:tel zwp01_telDist:MUUQYLocalizedString(@"EMKey_nowDist") verifyCode:verifyCode responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD em14_DismissLoadingHUD];
        if (result.em14_responseCode == EM_ResponseCodeSuccess) {
            
            if (!weakSelf.em_needTiePresent) {
                [GrossAlertCrlV showAlertMessage:MUUQYLocalizedString(@"EMKey_BindTelSuccess_Tips_Text") actionBlock:^(NSString * _Nonnull btnTitle, NSInteger btnIndex) {

                } cancelButtonTitle:MUUQYLocalizedString(@"EMKey_ConfirmButton_Text") otherButtonTitles:nil];
            }
            
           
            
            
            if (weakSelf.em_needTiePresent) {
                [[ZhenwupLogin_Server new] lhxy_tiePresentWithGameId:weakSelf.em11_gameId em14_roleId:weakSelf.em14_roleId Request:^(ZhenwupResponseObject_Entity * _Nonnull result) {
                    
                    if (result.em14_responseCode == EM_ResponseCodeSuccess) {
                        [MBProgressHUD em14_showSuccess_Toast:MUUQYLocalizedString(@"EMKey_tiePresentSuccess")];
                        EMSDKAPI.em_tiePresent = true;
                    } else {
                        [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
                    }
                    
                    if (EMSDKAPI.delegate && [EMSDKAPI.delegate respondsToSelector:@selector(zwp01_checkPresentFinish:)]) {
                        [EMSDKAPI.delegate zwp01_checkPresentFinish:result];
                    }
                }];
            }
            
        } else {
            [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
        }
    }];
}


- (BOOL)em14_HorizontalInputTextFieldViewShouldReturn:(KeenWireField *)inputView {
    if (inputView == self.em_bindTel_inputAccView) {
        [self.em14_bindTel_inputVerifyView.em14_TextField becomeFirstResponder];
    }
    return YES;
}

- (void)em14_HorizontalInputTextFieldViewTextDidChange:(KeenWireField *)inputView {
    
}


- (BOOL)em14_VerifyInputTextFieldViewShouldReturn:(ZhenwupVerifyInPutTextField_View *)inputView {
    [self em_onClickBindTelBtn:nil];
    return YES;
}

- (void)em14_VerifyInputTextFieldViewTextDidChange:(ZhenwupVerifyInPutTextField_View *)inputView {
    
}

- (BOOL)em14_HandleSendVerifyCode:(ZhenwupVerifyInPutTextField_View *)inputView {
    NSString *tel = self.em_bindTel_inputAccView.em14_TextField.text;
    
    if (!tel || [tel isEmpty]) {
        [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_Bindtel_Miss_Alert_Text")];
        return NO;
    }
    if ([tel isValidateMobile] == NO) {
        [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_Email_FormatError_Alert_Text")];
        return NO;
    }
    
    [self.em11_AccountServer em11_SendUpgradeTelCodeRequestWithem14_telNum:tel zwp01_telDist:MUUQYLocalizedString(@"EMKey_nowDist") responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull result) {
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
