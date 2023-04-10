
#import "ZhenwupModifyPwd_View.h"
#import "KeenWireField.h"
#import "NSString+GrossExtension.h"
#import "ZhenwupAccount_Server.h"
#import "GrossAlertCrlV.h"

@interface ZhenwupModifyPwd_View () <KeenWireFieldDelegate>

@property (nonatomic, strong) KeenWireField *em11_Pwd_InputView;
@property (nonatomic, strong) KeenWireField *em11_NewPwd1_InputView;
@property (nonatomic, strong) KeenWireField *em11_NewPwd2_InputView;
@property (nonatomic, strong) UIButton *em14_confirmBtn;
@property (nonatomic, strong) ZhenwupAccount_Server *accountServer;
@end

@implementation ZhenwupModifyPwd_View

- (instancetype)init {
    if (self = [super initWithCurType:@"0"]) {
        [self em14_setupViews];
    }
    return self;
}

- (ZhenwupAccount_Server *)accountServer {
    if (!_accountServer) {
        _accountServer = [[ZhenwupAccount_Server alloc] init];
    }
    return _accountServer;
}

- (void)em14_setupViews {
    self.title = MUUQYLocalizedString(@"EMKey_ModifyPassword_Text");
    
    [self em14_ShowCloseBtn:YES];
    
    UIView * inputBgView = [[UIView alloc] initWithFrame:CGRectMake(40, 55, self.em_width - 80, 180)];
    [self addSubview:inputBgView];
    
    self.em11_Pwd_InputView = [[KeenWireField alloc] initWithFrame:CGRectMake(0, 0, inputBgView.em_width, 40)];
    self.em11_Pwd_InputView.em14_TextField.placeholder = MUUQYLocalizedString(@"EMKey_OldPassword_Placeholder_Text");
    self.em11_Pwd_InputView.em14_TextField.secureTextEntry = YES;
    self.em11_Pwd_InputView.delegate = self;
    [inputBgView addSubview:self.em11_Pwd_InputView];
    
    self.em11_Pwd_InputView.em14_fieldLeftIcon.image = [ZhenwupHelper_Utils imageName:@"zhenwuimoldPwd"];
    
    self.em11_NewPwd1_InputView = [[KeenWireField alloc] initWithFrame:CGRectMake(0, self.em11_Pwd_InputView.em_bottom + 20, inputBgView.em_width, 40)];
    self.em11_NewPwd1_InputView.em14_TextField.placeholder = MUUQYLocalizedString(@"EMKey_NewPassword_Placeholder_Text");
    self.em11_NewPwd1_InputView.em14_TextField.secureTextEntry = YES;
    self.em11_NewPwd1_InputView.delegate = self;
    [inputBgView addSubview:self.em11_NewPwd1_InputView];
    
    self.em11_NewPwd1_InputView.em14_fieldLeftIcon.image = [ZhenwupHelper_Utils imageName:@"zhenwuimnewPwd"];
    
    self.em11_NewPwd2_InputView = [[KeenWireField alloc] initWithFrame:CGRectMake(0, self.em11_NewPwd1_InputView.em_bottom + 20, inputBgView.em_width, 40)];
    self.em11_NewPwd2_InputView.em14_TextField.placeholder = MUUQYLocalizedString(@"EMKey_NewPasswordAgain_Placeholder_Text");
    self.em11_NewPwd2_InputView.em14_TextField.secureTextEntry = YES;
    self.em11_NewPwd2_InputView.delegate = self;
    [inputBgView addSubview:self.em11_NewPwd2_InputView];
    
    self.em11_NewPwd2_InputView.em14_fieldLeftIcon.image = [ZhenwupHelper_Utils imageName:@"zhenwuimnewPwd"];
    
    inputBgView.em_height = self.em11_NewPwd2_InputView.em_bottom;
    
    self.em14_confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.em14_confirmBtn.frame = CGRectMake(0, inputBgView.em_bottom + 20, 120, 44);
    self.em14_confirmBtn.titleLabel.font = [ZhenwupTheme_Utils em_colors_NormalFont];
    self.em14_confirmBtn.backgroundColor = [ZhenwupTheme_Utils em_colors_ButtonColor];
    self.em14_confirmBtn.layer.cornerRadius = 22.0;
    self.em14_confirmBtn.layer.masksToBounds = YES;
    [self.em14_confirmBtn setTitle:MUUQYLocalizedString(@"EMKey_ConfirmButton_Text") forState:UIControlStateNormal];
    [self.em14_confirmBtn addTarget:self action:@selector(em11_HandleClickedModifyPwdBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.em14_confirmBtn];
    
    [self.em14_confirmBtn sizeToFit];
    self.em14_confirmBtn.em_size = CGSizeMake(MAX(self.em14_confirmBtn.em_width + 30, 120), 45);
    self.em14_confirmBtn.em_centerX = self.em_width / 2.0;
    
    self.em_height = self.em14_confirmBtn.em_bottom + 20;
}


- (void)em14_HandleClickedCloseBtn:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(em11_HandleCloseModifyPwdView_Delegate:)]) {
        [_delegate em11_HandleCloseModifyPwdView_Delegate:self];
    }
}


- (void)em11_HandleClickedModifyPwdBtn:(id)sender {
    NSString *pwd = self.em11_Pwd_InputView.em14_TextField.text;
    NSString *newPwd1 = self.em11_NewPwd1_InputView.em14_TextField.text;
    NSString *newPwd2 = self.em11_NewPwd2_InputView.em14_TextField.text;
    
    if (!pwd || [pwd isEmpty] || !newPwd1 || [newPwd1 isEmpty] || !newPwd2 || [newPwd2 isEmpty]) {
        [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_Password_Miss_Alert_Text")];
        return;
    }
    if ([newPwd1 isEqualToString:newPwd2] == NO) {
        [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_Password_2EnterNoMatch_Alert_Text")];
        return;
    }
    if ([newPwd1 isEqualToString:pwd]) {
        [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_Password_NewOldSame_Alert_Text")];
        return;
    }
    if ([newPwd1 validatePassword] == NO) {
        [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_Password_FormatError_Alert_Text")];
        return;
    }
    if (newPwd1.length < 6 || newPwd1.length > 20) {
        [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_Password_LengthError_Alert_Text")];
        return;
    }
    
    [MBProgressHUD em14_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.accountServer em11_ModifyPassword:pwd newPassword:newPwd1 reNewPassword:newPwd2 responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD em14_DismissLoadingHUD];
        if (result.em14_responseCode == EM_ResponseCodeSuccess) {
            [GrossAlertCrlV showAlertTitle:MUUQYLocalizedString(@"EMKey_ModifyPassword_Text") message:MUUQYLocalizedString(@"EMKey_ModifySuccess_Tips_Text") actionBlock:^(NSString * _Nonnull btnTitle, NSInteger btnIndex) {
                
            } cancelButtonTitle:MUUQYLocalizedString(@"EMKey_ConfirmButton_Text") otherButtonTitles:nil];
            [weakSelf em14_HandleClickedBackBtn:sender];
        } else {
            [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
        }
    }];
}


- (BOOL)em14_HorizontalInputTextFieldViewShouldReturn:(KeenWireField *)inputView {
    if (inputView == self.em11_Pwd_InputView) {
        [self.em11_NewPwd1_InputView.em14_TextField becomeFirstResponder];
    }
    else if (inputView == self.em11_NewPwd1_InputView) {
        [self.em11_NewPwd2_InputView.em14_TextField becomeFirstResponder];
    }
    else if (inputView == self.em11_NewPwd2_InputView) {
        
        [self endEditing:YES];
    }
    return YES;
}

@end
