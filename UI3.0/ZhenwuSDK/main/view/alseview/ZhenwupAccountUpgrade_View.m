
#import "ZhenwupAccountUpgrade_View.h"
#import "ZhenwupAccount_Server.h"
#import "NSString+GrossExtension.h"
#import "KeenWireField.h"
#import "ZhenwupVerifyInPutTextField_View.h"
#import "GrossAlertCrlV.h"
#import "ZhenwupSegView.h"
@interface ZhenwupAccountUpgrade_View () <KeenWireFieldDelegate, EM_VerifyInputTextFieldDelegate,EmpriSegViewDelegate>

//@property (nonatomic, strong) UISegmentedControl *em14_segment;
@property (nonatomic, strong) ZhenwupSegView *em14_segment;
@property (nonatomic, assign) NSInteger zwp01_type;
@property (nonatomic, strong) KeenWireField *em11_AccountUpgrade_inputAccView;
@property (nonatomic, strong) KeenWireField *em11_AccountUpgrade_inputPwdView;
@property (nonatomic, strong) ZhenwupVerifyInPutTextField_View *em11_AccountUpgrade_inputVerifyView;
@property (nonatomic, strong) UIButton *em11_CheckProtoclBtn;
@property (nonatomic, strong) UIButton *em18_protocolBtn;
@property (nonatomic, strong) UIButton *em14_confirmBtn;
@property (nonatomic, strong) ZhenwupAccount_Server *em11_AccountServer;
@end

@implementation ZhenwupAccountUpgrade_View

- (instancetype)init {
    self = [super initWithCurType:@"0"];
    if (self) {
        [self em14_setupViews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_em11_HandleBeforeClosedView) {
        [self em14_ShowCloseBtn:YES];
        [self em14_ShowBackBtn:NO];
    } else {
        [self em14_ShowCloseBtn:NO];
        [self em14_ShowBackBtn:YES];
    }
}

- (ZhenwupAccount_Server *)em11_AccountServer {
    if (!_em11_AccountServer) {
        _em11_AccountServer = [[ZhenwupAccount_Server alloc] init];
    }
    return _em11_AccountServer;
}


- (void)em14_setupViews {
    self.title = MUUQYLocalizedString(@"EMKey_AccountUpgrade_Text");
    
    UIView * inputBgView = [[UIView alloc] initWithFrame:CGRectMake(35, 55, self.em_width - 70, 180)];
    [self addSubview:inputBgView];
    
    self.em14_segment = [[ZhenwupSegView alloc] initWithTitleArr:@[MUUQYLocalizedString(@"EMKey_Email_Text"), MUUQYLocalizedString(@"EMKey_WordTel")] WithFrame:CGRectMake(20, 0, inputBgView.em_width-40, 30)];
    self.em14_segment.delegate=self;
    [inputBgView addSubview:self.em14_segment];
    
    
    
    
    
    
    self.em11_AccountUpgrade_inputAccView = [[KeenWireField alloc] initWithFrame:CGRectMake(0, self.em14_segment.em_bottom + 10, inputBgView.em_width, 40)];
    self.em11_AccountUpgrade_inputAccView.em14_TextField.secureTextEntry = false;
    self.em11_AccountUpgrade_inputAccView.em14_TextField.placeholder = MUUQYLocalizedString(@"EMKey_BindEmail_Placeholder_Text");
    self.em11_AccountUpgrade_inputAccView.em14_TextField.keyboardType = UIKeyboardTypeEmailAddress;
    self.em11_AccountUpgrade_inputAccView.delegate = self;
    [inputBgView addSubview:self.em11_AccountUpgrade_inputAccView];
    
    self.em11_AccountUpgrade_inputAccView.em14_fieldLeftIcon.image = [ZhenwupHelper_Utils imageName:@"zhenwuimacc"];
    self.em11_AccountUpgrade_inputAccView.em14_fieldLeftIcon.frame= CGRectMake(13, 11.8, 22.3, 16.3);
    
    
    
    
    
    
    
    
    self.em11_AccountUpgrade_inputPwdView = [[KeenWireField alloc] initWithFrame:CGRectMake(0, self.em11_AccountUpgrade_inputAccView.em_bottom + 20, inputBgView.em_width, 40)];
    self.em11_AccountUpgrade_inputPwdView.em14_TextField.placeholder = MUUQYLocalizedString(@"EMKey_NewPassword_Placeholder_Text");
    self.em11_AccountUpgrade_inputPwdView.em14_TextField.secureTextEntry = YES;
    self.em11_AccountUpgrade_inputPwdView.delegate = self;
    [inputBgView addSubview:self.em11_AccountUpgrade_inputPwdView];
    
    
    
    
    
    
    self.em11_AccountUpgrade_inputPwdView.em14_fieldLeftIcon.image = [ZhenwupHelper_Utils imageName:@"zhenwuimresetPwd"];
    
//    self.em14_VerifyCode_InputView.em14_fieldLeftIcon.image = [ZhenwupHelper_Utils imageName:@"zhenwuimnewPwd"];
    self.em11_AccountUpgrade_inputPwdView.em14_fieldLeftIcon.frame= CGRectMake(13, 10.8, 18.6, 20.5);
    
    
    
    UIButton *eyeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    eyeBtn.frame = CGRectMake(0, 0, 32, 32);
    eyeBtn.contentEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    eyeBtn.selected = YES;
    self.em11_AccountUpgrade_inputPwdView.delegate = self;
    [eyeBtn setImage:[ZhenwupHelper_Utils imageName:@"zhenwuimclear"] forState:UIControlStateNormal];
    [eyeBtn setImage:[ZhenwupHelper_Utils imageName:@"zhenwuimmiss"] forState:UIControlStateSelected];
    [eyeBtn addTarget:self action:@selector(em11_HandleClickedEyeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.em11_AccountUpgrade_inputPwdView em14_setRightView:eyeBtn];
    
    
    
    
    self.em11_AccountUpgrade_inputVerifyView = [[ZhenwupVerifyInPutTextField_View alloc] initWithFrame:CGRectMake(0, self.em11_AccountUpgrade_inputPwdView.em_bottom + 20, inputBgView.em_width, 40)];
    self.em11_AccountUpgrade_inputVerifyView.em14_TextField.placeholder = MUUQYLocalizedString(@"EMKey_VerifyCode_Placeholder_Text");
    self.em11_AccountUpgrade_inputVerifyView.delegate = self;
    [inputBgView addSubview:self.em11_AccountUpgrade_inputVerifyView];
    
    inputBgView.em_height = self.em11_AccountUpgrade_inputVerifyView.em_bottom;
    
    self.em11_AccountUpgrade_inputVerifyView.em14_fieldLeftIcon.image = [ZhenwupHelper_Utils imageName:@"zhenwuimnewPwd"];
    
    
    //    self.em14_VerifyCode_InputView.em14_fieldLeftIcon.image = [ZhenwupHelper_Utils imageName:@"zhenwuimnewPwd"];
        self.em11_AccountUpgrade_inputVerifyView.em14_fieldLeftIcon.frame= CGRectMake(13, 10.8, 18.6, 20.5);
    
    
    
    self.em11_CheckProtoclBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.em11_CheckProtoclBtn.frame = CGRectMake(inputBgView.em_left - 11.5, inputBgView.em_bottom, 35, 35);
    self.em11_CheckProtoclBtn.contentEdgeInsets = UIEdgeInsetsMake(11.5, 11.5, 11.5, 11.5);
    [self.em11_CheckProtoclBtn setImage:[ZhenwupHelper_Utils imageName:@"zhenwuimunPick"] forState:UIControlStateNormal];
    [self.em11_CheckProtoclBtn setImage:[ZhenwupHelper_Utils imageName:@"zhenwuimpick"] forState:UIControlStateSelected];
    self.em11_CheckProtoclBtn.selected=YES;
    [self.em11_CheckProtoclBtn addTarget:self action:@selector(em11_HandleCheckProtoclBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.em11_CheckProtoclBtn];
    
    self.em18_protocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.em18_protocolBtn.frame = CGRectMake(self.em11_CheckProtoclBtn.em_right+5, self.em11_CheckProtoclBtn.em_top + 5, inputBgView.em_width-self.em11_CheckProtoclBtn.em_width-5, 25);
    self.em18_protocolBtn.titleLabel.font = [ZhenwupTheme_Utils em_colors_SmallFont];
    self.em18_protocolBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.em18_protocolBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -11.5, 0, 0);
    [self.em18_protocolBtn setTitle:MUUQYLocalizedString(@"EMKey_RegisterProtocol_Text") forState:UIControlStateNormal];
    [self.em18_protocolBtn setTitleColor:[ZhenwupTheme_Utils em_colors_GrayColor] forState:UIControlStateNormal];
    [self.em18_protocolBtn addTarget:self action:@selector(em11_HandleClickProtoclBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.em18_protocolBtn];
    
    self.em14_confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.em14_confirmBtn.tag = 100;
    self.em14_confirmBtn.frame = CGRectMake(0, self.em18_protocolBtn.em_bottom + 5, 120, 34);
    self.em14_confirmBtn.titleLabel.font = [ZhenwupTheme_Utils em_colors_NormalFont];
//    self.em14_confirmBtn.backgroundColor = [ZhenwupTheme_Utils em_colors_ButtonColor];
    [self.em14_confirmBtn setBackgroundImage:[ZhenwupHelper_Utils imageName:@"zhenwuimb4"] forState:0];
    self.em14_confirmBtn.layer.cornerRadius = 17;
    self.em14_confirmBtn.layer.masksToBounds = YES;
    [self.em14_confirmBtn setTitle:MUUQYLocalizedString(@"EMKey_ConfirmButton_Text") forState:UIControlStateNormal];
    [self.em14_confirmBtn addTarget:self action:@selector(em11_HandleConfirmUpgradeAccount:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.em14_confirmBtn];
    
//    [self.em14_confirmBtn sizeToFit];
//    self.em14_confirmBtn.em_size = CGSizeMake(MAX(self.em14_confirmBtn.em_width + 30, 120), 34);
    self.em14_confirmBtn.em_centerX = inputBgView.em_centerX;
    
    UILabel *descLab = [[UILabel alloc] initWithFrame:CGRectMake(20, self.em14_confirmBtn.em_bottom + 10, self.em_width - 40, 10)];
    descLab.font = [UIFont systemFontOfSize:7];
    descLab.textAlignment = NSTextAlignmentRight;
    descLab.textColor = [ZhenwupTheme_Utils em14_colorWithHexString:@"#FFFFFF"];
    descLab.text = MUUQYLocalizedString(@"EMKey_AccountUpgrade_Tips_Text");
    [self addSubview:descLab];
    
    self.em_height = descLab.em_bottom + 20;
    [self em14_u_UpdateButtonStates];
}

-(void)em14_segValeDidChange:(NSInteger)index {
    
    [self.em11_AccountUpgrade_inputVerifyView  em14_ResetNormalSendStates];
    switch (index) {
            //对应placeholder要更改
            
        case 0:
        {
            
            
            self.zwp01_type = 0;
            self.em11_AccountUpgrade_inputAccView.zwp01_tel = false;
            
            self.em11_AccountUpgrade_inputAccView.em14_fieldLeftIcon.image = [ZhenwupHelper_Utils imageName:@"zhenwuimacc"];
            self.em11_AccountUpgrade_inputAccView.em14_fieldLeftIcon.frame= CGRectMake(13, 11.8, 22.3, 16.3);
            
            
        
            self.em11_AccountUpgrade_inputAccView.em14_TextField.text=@"";
            self.em11_AccountUpgrade_inputVerifyView.em14_TextField.text=@"";
            self.em11_AccountUpgrade_inputPwdView.em14_TextField.text=@"";
            
            self.em11_AccountUpgrade_inputAccView.em14_TextField.placeholder = MUUQYLocalizedString(@"EMKey_BindEmail_Placeholder_Text");
            self.em11_AccountUpgrade_inputVerifyView.em14_TextField.placeholder = MUUQYLocalizedString(@"EMKey_VerifyCode_Placeholder_Text");
            self.em11_AccountUpgrade_inputPwdView.em14_TextField.placeholder = MUUQYLocalizedString(@"EMKey_NewPassword_Placeholder_Text");
        }
            break;
        default:
        {
            
            self.zwp01_type = 1;
//            self.em11_AccountUpgrade_inputAccView.zwp01_tel = true;
            
            self.em11_AccountUpgrade_inputAccView.zwp01_tel = false;
            
            self.em11_AccountUpgrade_inputAccView.em14_fieldLeftIcon.image = [ZhenwupHelper_Utils imageName:@"zhenwuimphone"];
            self.em11_AccountUpgrade_inputAccView.em14_fieldLeftIcon.frame= CGRectMake(13, 10, 13.1, 20);
            
            self.em11_AccountUpgrade_inputAccView.em14_TextField.text=@"";
            self.em11_AccountUpgrade_inputVerifyView.em14_TextField.text=@"";
            self.em11_AccountUpgrade_inputPwdView.em14_TextField.text=@"";
            
            self.em11_AccountUpgrade_inputAccView.em14_TextField.placeholder = MUUQYLocalizedString(@"EMKey_pleaseTel");
            self.em11_AccountUpgrade_inputVerifyView.em14_TextField.placeholder = MUUQYLocalizedString(@"EMKey_VerifyCode_Placeholder_Text");
            self.em11_AccountUpgrade_inputPwdView.em14_TextField.placeholder = MUUQYLocalizedString(@"EMKey_NewPassword_Placeholder_Text");
        }
            break;
    }
}

- (void)em14_u_UpdateButtonStates {
    UIButton *em14_confirmBtn = [self viewWithTag:100];
    if (self.em11_AccountUpgrade_inputAccView.em14_TextField.text.length > 0 && self.em11_AccountUpgrade_inputPwdView.em14_TextField.text.length > 0 && self.em11_AccountUpgrade_inputVerifyView.em14_TextField.text.length > 0 && self.em11_CheckProtoclBtn.selected) {
        em14_confirmBtn.enabled = YES;
//        em14_confirmBtn.backgroundColor = [ZhenwupTheme_Utils em_colors_ButtonColor];
        
        [em14_confirmBtn setBackgroundImage:[ZhenwupHelper_Utils imageName:@"zhenwuimb5"] forState:0];
        
        
    } else {
        em14_confirmBtn.enabled = NO;
//        em14_confirmBtn.backgroundColor = [ZhenwupTheme_Utils em_colors_DisableColor];
        
        [em14_confirmBtn setBackgroundImage:[ZhenwupHelper_Utils imageName:@"zhenwuimb4"] forState:0];
    }
}


- (void)em14_HandleClickedCloseBtn:(id)sender {
    if (_em11_HandleBeforeClosedView) {
        _em11_HandleBeforeClosedView();
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(em11_HandlePopAccountUpgradeView_Delegate:)]) {
        [_delegate em11_HandlePopAccountUpgradeView_Delegate:self];
    }
}

- (void)em14_HandleClickedBackBtn:(id)sender {
    if (_em11_HandleBeforeClosedView) {
        _em11_HandleBeforeClosedView();
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(em11_HandlePopAccountUpgradeView_Delegate:)]) {
        [_delegate em11_HandlePopAccountUpgradeView_Delegate:self];
    }
}


- (void)em11_HandleClickedEyeBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    self.em11_AccountUpgrade_inputPwdView.em14_TextField.secureTextEntry = sender.selected;
}

- (void)em11_HandleCheckProtoclBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self em14_u_UpdateButtonStates];
}

- (void)em11_HandleClickProtoclBtn:(UIButton *)sender {
    self.em11_CheckProtoclBtn.selected = YES;
    [self em14_u_UpdateButtonStates];
    
    [EMSDKGlobalInfo em14_PresendWithUrlString:EMSDKGlobalInfo.reg_agree];
}

- (void)em11_HandleConfirmUpgradeAccount:(id)sender {
    NSString *userName = self.em11_AccountUpgrade_inputAccView.em14_TextField.text;
    NSString *password = self.em11_AccountUpgrade_inputPwdView.em14_TextField.text;
    NSString *verifyCode = self.em11_AccountUpgrade_inputVerifyView.em14_TextField.text;
    
    if (self.zwp01_type == 0) {
        if (!userName || [userName isEmpty]) {
            [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_BindEmail_Miss_Alert_Text")];
            return;
        }
        if (!password || [password isEmpty]) {
            [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_Password_Miss_Alert_Text")];
            return;
        }
        if (!verifyCode || [verifyCode isEmpty]) {
            [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_VerifyCode_Miss_Alert_Text")];
            return;
        }
        
        [MBProgressHUD em14_ShowLoadingHUD];
        __weak typeof(self) weakSelf = self;
        [self.em11_AccountServer em11_UpgradeAccount:userName withPassword:password andVerifyCode:verifyCode responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull result) {
            [MBProgressHUD em14_DismissLoadingHUD];
            if (result.em14_responseCode == EM_ResponseCodeSuccess) {
                
                NSAttributedString *_title = [[NSAttributedString alloc] initWithString:MUUQYLocalizedString(@"EMKey_AccountUpgrade_Text")];
                NSAttributedString *_msg = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@： %@",MUUQYLocalizedString(@"EMKey_UpgradeSuccess_Tips_Text"), MUUQYLocalizedString(@"EMKey_YourMuuAccountNum_Text"),userName?:EMSDKGlobalInfo.userInfo.userID]];
                
                [GrossAlertCrlV showAttTitle:_title attMessage:_msg preferredStyle:UIAlertControllerStyleAlert actionBlock:^(NSInteger btnIndex) {
                    
                } cancelButtonTitle:MUUQYLocalizedString(@"EMKey_ConfirmButton_Text") otherButtonTitles:nil buttonColor:nil];
                
                if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(em11_HandleDismissAccountUpgradeView_Delegate:)]) {
                    [weakSelf.delegate em11_HandleDismissAccountUpgradeView_Delegate:weakSelf];
                }
            } else {
                [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
            }
        }];
    }else{
        if (!userName || [userName isEmpty]) {
            [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_pleaseTel")];
            return;
        }
        if (!password || [password isEmpty]) {
            [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_Password_Miss_Alert_Text")];
            return;
        }
        if (!verifyCode || [verifyCode isEmpty]) {
            [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_VerifyCode_Miss_Alert_Text")];
            return;
        }
        
        [MBProgressHUD em14_ShowLoadingHUD];
        __weak typeof(self) weakSelf = self;
        [self.em11_AccountServer em11_UpgradeAccountWithTel:userName withPassword:password andVerifyCode:verifyCode zwp01_telDist:@"84" responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull result) {
            [MBProgressHUD em14_DismissLoadingHUD];
            if (result.em14_responseCode == EM_ResponseCodeSuccess) {
                
                NSAttributedString *_title = [[NSAttributedString alloc] initWithString:MUUQYLocalizedString(@"EMKey_AccountUpgrade_Text")];
                NSAttributedString *_msg = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@： %@",MUUQYLocalizedString(@"EMKey_UpgradeSuccess_Tips_Text"), MUUQYLocalizedString(@"EMKey_YourMuuAccountNum_Text"),userName?:EMSDKGlobalInfo.userInfo.userID]];
                
                [GrossAlertCrlV showAttTitle:_title attMessage:_msg preferredStyle:UIAlertControllerStyleAlert actionBlock:^(NSInteger btnIndex) {
                    
                } cancelButtonTitle:MUUQYLocalizedString(@"EMKey_ConfirmButton_Text") otherButtonTitles:nil buttonColor:nil];
                
                if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(em11_HandleDismissAccountUpgradeView_Delegate:)]) {
                    [weakSelf.delegate em11_HandleDismissAccountUpgradeView_Delegate:weakSelf];
                }
            } else {
                [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
            }
        }];
    }
}


- (BOOL)em14_HorizontalInputTextFieldViewShouldReturn:(KeenWireField *)inputView {
    if (inputView == self.em11_AccountUpgrade_inputAccView) {
        [self.em11_AccountUpgrade_inputPwdView.em14_TextField becomeFirstResponder];
    } else if (inputView == self.em11_AccountUpgrade_inputPwdView) {
        [self.em11_AccountUpgrade_inputVerifyView.em14_TextField becomeFirstResponder];
    }
    return YES;
}

- (void)em14_HorizontalInputTextFieldViewTextDidChange:(KeenWireField *)inputView {
    [self em14_u_UpdateButtonStates];
}


- (BOOL)em14_VerifyInputTextFieldViewShouldReturn:(ZhenwupVerifyInPutTextField_View *)inputView {
    
    return YES;
}

- (void)em14_VerifyInputTextFieldViewTextDidChange:(ZhenwupVerifyInPutTextField_View *)inputView {
    [self em14_u_UpdateButtonStates];
}

- (BOOL)em14_InputTextFieldViewShouldReturn:(KeenWireField *)inputView{
    return YES;
}
- (void)em14_InputTextFieldViewTextDidChange:(KeenWireField *)inputView{
    [self em14_u_UpdateButtonStates];
}

- (BOOL)em14_HandleSendVerifyCode:(ZhenwupVerifyInPutTextField_View *)inputView {
    NSString *userName = self.em11_AccountUpgrade_inputAccView.em14_TextField.text;
    
    if (self.zwp01_type == 0) {
        if (!userName || [userName isEmpty]) {
            [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_BindEmail_Miss_Alert_Text")];
            return NO;
        }
        
        [self em_getEmailVerifyCodeWithEmail:userName em14_inputView:inputView];
        
        return YES;
    }else{
        if (!userName || [userName isEmpty]) {
            [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_pleaseTel")];
            return NO;
        }
        
        [self zwp01_getTelVerifyCodeWithTel:userName em_inputView:inputView];
        
        return YES;
    }
    
    
    
}

- (void)em_getEmailVerifyCodeWithEmail:(NSString *)em11_email em14_inputView:(ZhenwupVerifyInPutTextField_View *)em14_inputView{
    [self.em11_AccountServer em11_SendUpgradeVerifyCode2Email:em11_email responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        if (result.em14_responseCode == EM_ResponseCodeNetworkError) {
            [em14_inputView em14_ResetNormalSendStates];
        }
        
        if (result.em14_responseCode != EM_ResponseCodeSuccess) {
            
            [self.em11_AccountUpgrade_inputVerifyView  em14_ResetNormalSendStates];
            [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
        }
    }];
}

- (void)zwp01_getTelVerifyCodeWithTel:(NSString *)em14_tel em_inputView:(ZhenwupVerifyInPutTextField_View *)em_inputView{
    [self.em11_AccountServer em11_SendUpgradeTelCodeRequestWithem14_telNum:em14_tel zwp01_telDist:@"84" responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        if (result.em14_responseCode == EM_ResponseCodeNetworkError) {
            [em_inputView em14_ResetNormalSendStates];
        }
        
        if (result.em14_responseCode != EM_ResponseCodeSuccess) {
            [self.em11_AccountUpgrade_inputVerifyView  em14_ResetNormalSendStates];
            [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
        }
    }];
}

@end
