
#import "ZhenwupRegister_View.h"
#import "NSString+GrossExtension.h"
#import "ZhenwupAccount_Server.h"
#import "KeenWireField.h"
#import "ZhenwupVerifyInPutTextField_View.h"
#import "GrossAlertCrlV.h"
#import "ZhenwupSegView.h"
@interface ZhenwupRegister_View () <KeenWireFieldDelegate, EM_VerifyInputTextFieldDelegate,EmpriSegViewDelegate>

@property (nonatomic, strong) UIView *khxl_inputBgView;
@property (nonatomic, assign) NSInteger zwp01_type;
@property (nonatomic, strong) ZhenwupSegView *em14_segment;
@property (nonatomic, strong) KeenWireField *em11_inputAccView;
@property (nonatomic, strong) KeenWireField *em11_inputPwdView;
@property (nonatomic, strong) ZhenwupVerifyInPutTextField_View *em11_inputVerifyView;
@property (nonatomic, strong) UIButton *em11_verifyProtoclBtn;
@property (nonatomic, strong) UIButton *khxl_protocolBtn;
@property (nonatomic, strong) UIButton *em18_regBtn;
@property (nonatomic, strong) ZhenwupAccount_Server *em11_AccountServer;

@end

@implementation ZhenwupRegister_View

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
    [self em14_ShowBackBtn:YES];
    
    self.zwp01_type = 0;
    
    self.khxl_inputBgView = [self em11_mailReg_inputViewWithFrame:CGRectMake(35, 60, self.em_width - 35 - 35, 189)];
    [self addSubview:self.khxl_inputBgView];
    
            
    self.em11_verifyProtoclBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.em11_verifyProtoclBtn.frame = CGRectMake(self.khxl_inputBgView.em_left - 11.5, self.khxl_inputBgView.em_bottom - 5, 35, 35);
    self.em11_verifyProtoclBtn.contentEdgeInsets = UIEdgeInsetsMake(11.5, 11.5, 11.5, 11.5);
    
    [self.em11_verifyProtoclBtn setImage:[ZhenwupHelper_Utils imageName:@"zhenwuimunPick"] forState:UIControlStateNormal];
    [self.em11_verifyProtoclBtn setImage:[ZhenwupHelper_Utils imageName:@"zhenwuimpick"] forState:UIControlStateSelected];
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
            
    self.em18_regBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.em18_regBtn.frame = CGRectMake(0, self.khxl_protocolBtn.em_bottom + 5, 127, 34);
    self.em18_regBtn.tag = 100;
    self.em18_regBtn.titleLabel.font = [ZhenwupTheme_Utils em_colors_NormalFont];
    self.em18_regBtn.backgroundColor = [ZhenwupTheme_Utils em_colors_ButtonColor];
    self.em18_regBtn.layer.cornerRadius = 17.0;
    self.em18_regBtn.layer.masksToBounds = YES;
    [self.em18_regBtn setTitle:MUUQYLocalizedString(@"EMKey_ConfirmRegister_Text") forState:UIControlStateNormal];
    [self.em18_regBtn addTarget:self action:@selector(onClickRegisterBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.em18_regBtn];
    
    [self.em18_regBtn sizeToFit];
    self.em18_regBtn.em_size = CGSizeMake(MAX(self.em18_regBtn.em_width + 30, 127), 35);
    self.em18_regBtn.em_centerX = self.khxl_inputBgView.em_centerX;
    
    [self em14_u_UpdateButtonStates];
}

- (UIView *)em11_mailReg_inputViewWithFrame:(CGRect)frame {
    
    UIView *khxl_inputBgView = [[UIView alloc] initWithFrame:frame];
    
    
    self.em14_segment = [[ZhenwupSegView alloc] initWithTitleArr:@[MUUQYLocalizedString(@"EMKey_Email_Text"), MUUQYLocalizedString(@"EMKey_WordTel")] WithFrame: CGRectMake(30, 0, khxl_inputBgView.em_width-60, 30)];
    self.em14_segment.delegate=self;
    [khxl_inputBgView addSubview:self.em14_segment];
    
    
   
    
    self.em11_inputAccView = [[KeenWireField alloc] initWithFrame:CGRectMake(0, 45, khxl_inputBgView.em_width, 40)];
    self.em11_inputAccView.em14_TextField.placeholder = MUUQYLocalizedString(@"EMKey_Email_Placeholder_Text");
    self.em11_inputAccView.em14_TextField.keyboardType = UIKeyboardTypeEmailAddress;
    self.em11_inputAccView.delegate = self;
    [khxl_inputBgView addSubview:self.em11_inputAccView];
    
    self.em11_inputAccView.em14_fieldLeftIcon.image = [ZhenwupHelper_Utils imageName:@"zhenwuimacc"];
    
    self.em11_inputPwdView = [[KeenWireField alloc] initWithFrame:CGRectMake(0, self.em11_inputAccView.em_bottom + 10, khxl_inputBgView.em_width, 40)];
    self.em11_inputPwdView.em14_TextField.placeholder = MUUQYLocalizedString(@"EMKey_Password_Placeholder_Text");
    self.em11_inputPwdView.em14_TextField.secureTextEntry = YES;
    self.em11_inputPwdView.delegate = self;
    [khxl_inputBgView addSubview:self.em11_inputPwdView];
    
    self.em11_inputPwdView.em14_fieldLeftIcon.image = [ZhenwupHelper_Utils imageName:@"zhenwuimpwd"];
    
    self.em11_inputVerifyView = [[ZhenwupVerifyInPutTextField_View alloc] initWithFrame:CGRectMake(0, self.em11_inputPwdView.em_bottom + 10, khxl_inputBgView.em_width, 40)];
    self.em11_inputVerifyView.em14_TextField.placeholder = MUUQYLocalizedString(@"EMKey_VerifyCode_Placeholder_Text");
    self.em11_inputVerifyView.delegate = self;
    [khxl_inputBgView addSubview:self.em11_inputVerifyView];
    
    self.em11_inputVerifyView.em14_fieldLeftIcon.image = [ZhenwupHelper_Utils imageName:@"zhenwuimnewPwd"];
    
    khxl_inputBgView.em_height = self.em11_inputVerifyView.em_bottom;
        
    return khxl_inputBgView;
}

-(void)em14_segValeDidChange:(NSInteger)index{
    switch (index) {
            //对应placeholder要更改
            
            
        case 0:
        {
//            [self.em14_segment setBackgroundImage:[ZhenwupHelper_Utils imageName:@"zhenwuimseg1"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
            self.em11_inputAccView.em14_TextField.text = @"";
            self.zwp01_type = 0;
            self.em11_inputAccView.zwp01_tel = false;
            self.em11_inputAccView.em14_TextField.placeholder = MUUQYLocalizedString(@"EMKey_Email_Placeholder_Text");
            self.em11_inputPwdView.em14_TextField.placeholder = MUUQYLocalizedString(@"EMKey_Password_Placeholder_Text");
            self.em11_inputVerifyView.em14_TextField.placeholder = MUUQYLocalizedString(@"EMKey_VerifyCode_Placeholder_Text");
        }
            break;
        default:
        {

            self.em11_inputAccView.em14_TextField.text = @"";
            self.zwp01_type = 1;
            self.em11_inputAccView.zwp01_tel = true;
            self.em11_inputAccView.em14_TextField.placeholder = MUUQYLocalizedString(@"EMKey_pleaseTel");
            self.em11_inputPwdView.em14_TextField.placeholder = MUUQYLocalizedString(@"EMKey_Password_Placeholder_Text");
            self.em11_inputVerifyView.em14_TextField.placeholder = MUUQYLocalizedString(@"EMKey_pleaseVerify");
        }
            break;
    }
}


- (void)em14_u_UpdateButtonStates {
    UIButton *em14_regBtn = [self viewWithTag:100];
    if (self.em11_inputAccView.em14_TextField.text.length > 0 && self.em11_inputPwdView.em14_TextField.text.length > 0 && self.em11_inputVerifyView.em14_TextField.text.length > 0 && self.em11_verifyProtoclBtn.selected) {
        em14_regBtn.enabled = YES;
        em14_regBtn.backgroundColor = [ZhenwupTheme_Utils em_colors_ButtonColor];
    } else {
        em14_regBtn.enabled = NO;
        em14_regBtn.backgroundColor = [ZhenwupTheme_Utils em_colors_DisableColor];
    }
}


- (void)em14_HandleClickedBackBtn:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(em11_HandlePopRegisterView:)]) {
        [_delegate em11_HandlePopRegisterView:self];
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

- (void)onClickRegisterBtn:(id)sender {
    NSString *userName = self.em11_inputAccView.em14_TextField.text;
    NSString *password = self.em11_inputPwdView.em14_TextField.text;
    NSString *verifyCode = self.em11_inputVerifyView.em14_TextField.text;
    
    if (self.zwp01_type == 0) {
        [self em_emailTypeRegisterWithUsername:userName password:password verifyCode:verifyCode];
    }else{
        [self em_telTypeRegisterWithUsername:userName password:password verifyCode:verifyCode];
    }
}

- (void)em_emailTypeRegisterWithUsername:(NSString *)userName password:(NSString *)password verifyCode:(NSString *)verifyCode{
    
    if (!userName || [userName isEmpty]) {
        [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_Email_Miss_Alert_Text")];
        return;
    }
    if ([userName validateEmail] == NO) {
        [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_Email_FormatError_Alert_Text")];
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
    if ([password validatePassword] == NO) {
        [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_Password_FormatError_Alert_Text")];
        return;
    }
    if (password.length < 6 || password.length > 20) {
        [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_Password_LengthError_Alert_Text")];
        return;
    }
    [MBProgressHUD em14_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.em11_AccountServer em11_RegisterAccountWithUserName:userName password:password verifyCode:verifyCode regType:@"1" responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD em14_DismissLoadingHUD];
        if (result.em14_responseCode == EM_ResponseCodeSuccess) {
            NSString *_msg = [NSString stringWithFormat:@"%@%@ %@！",MUUQYLocalizedString(@"EMKey_RegisterSuccess_Pre_Tips_Text"),EMSDKGlobalInfo.userInfo.userName, MUUQYLocalizedString(@"EMKey_RegisterSuccess_Suf_Tips_Text")];
            [GrossAlertCrlV showAlertTitle:MUUQYLocalizedString(@"EMKey_RegisterSuccess_Text") message:_msg actionBlock:^(NSString * _Nonnull btnTitle, NSInteger btnIndex) {
            } cancelButtonTitle:MUUQYLocalizedString(@"EMKey_ConfirmButton_Text") otherButtonTitles:nil];
            
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(em11_HandleDidRegistSuccess:)]) {
                [weakSelf.delegate em11_HandleDidRegistSuccess:weakSelf];
            }
        } else {
            [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
        }
    }];
}

- (void)em_telTypeRegisterWithUsername:(NSString *)userName password:(NSString *)password verifyCode:(NSString *)verifyCode{
    
    if (!userName || [userName isEmpty]) {
        [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_pleaseTel")];
        return;
    }
    if ([userName isValidateMobile] == NO) {
        [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_rightTel")];
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
    if ([password validatePassword] == NO) {
        [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_Password_FormatError_Alert_Text")];
        return;
    }
    if (password.length < 6 || password.length > 20) {
        [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_Password_LengthError_Alert_Text")];
        return;
    }
    [MBProgressHUD em14_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.em11_AccountServer em11_RegisterAccountWithTel:userName password:password verifyCode:verifyCode zwp01_telDist:MUUQYLocalizedString(@"EMKey_nowDist") responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD em14_DismissLoadingHUD];
        if (result.em14_responseCode == EM_ResponseCodeSuccess) {
            NSString *_msg = [NSString stringWithFormat:@"%@%@ %@！",MUUQYLocalizedString(@"EMKey_RegisterSuccess_Pre_Tips_Text"),EMSDKGlobalInfo.userInfo.userName, MUUQYLocalizedString(@"EMKey_RegisterSuccess_Suf_Tips_Text")];
            [GrossAlertCrlV showAlertTitle:MUUQYLocalizedString(@"EMKey_RegisterSuccess_Text") message:_msg actionBlock:^(NSString * _Nonnull btnTitle, NSInteger btnIndex) {
            } cancelButtonTitle:MUUQYLocalizedString(@"EMKey_ConfirmButton_Text") otherButtonTitles:nil];
            
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(em11_HandleDidRegistSuccess:)]) {
                [weakSelf.delegate em11_HandleDidRegistSuccess:weakSelf];
            }
        } else {
            [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
        }
    }];
}


- (BOOL)em14_InputTextFieldViewShouldReturn:(KeenWireField *)inputView {
    if (inputView == self.em11_inputAccView) {
        [self.em11_inputPwdView.em14_TextField becomeFirstResponder];
    } else if (inputView == self.em11_inputPwdView) {
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
    
    if (self.zwp01_type == 0) {
        [self em11_sendEmailCodeWithUserName:userName andInputView:inputView];
    }else{
        [self em11_sendTelCodeWithUserName:userName zwp01_telDist:MUUQYLocalizedString(@"EMKey_nowDist") andInputView:inputView];
    }
    
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

- (void)em11_sendTelCodeWithUserName:(NSString *)userName zwp01_telDist:(NSString *)zwp01_telDist andInputView:(ZhenwupVerifyInPutTextField_View *)inputView
{
    [self.em11_AccountServer em11_SendBindTelCodeRequestWithem14_telNum:userName zwp01_telDist:zwp01_telDist?:@"" em11_ut:@"1" responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        if (result.em14_responseCode == EM_ResponseCodeNetworkError) {
            [inputView em14_ResetNormalSendStates];
        }
        if (result.em14_responseCode != EM_ResponseCodeSuccess) {
            [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
        }
    }];
}



@end
