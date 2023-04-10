
#import "ZhenwupAccountLogin_View.h"
#import "ZhenwupLogin_Server.h"
#import "ZhenwupLocalData_Server.h"
#import "KeenWireField.h"
#import "NSString+GrossExtension.h"

@interface ZhenwupAccountLogin_View () <UITableViewDelegate, UITableViewDataSource, KeenWireFieldDelegate>

@property (strong, nonatomic) UIView * em11_inputBgView;
@property (strong, nonatomic) KeenWireField *em14_inputAccView;
@property (strong, nonatomic) UIButton *em11_moreBtn;
@property (strong, nonatomic) KeenWireField *em14_inputPwdView;
@property (strong, nonatomic) UIButton *em11_forgetPwdBtn;
@property (strong, nonatomic) UIButton *em14_loginBtn;
@property (strong, nonatomic) UITableView *em14_HistoryTableView;
@property (strong, nonatomic) NSMutableArray *em14_HistoryAccounts;
@property (strong, nonatomic) ZhenwupLogin_Server *em14_LoginServer;
@property (strong, nonatomic) ZhenwupUserInfo_Entity *em14_SelectUser;

@end

@implementation ZhenwupAccountLogin_View

- (instancetype)init {
    self = [super initWithCurType:@"0"];
    if (self) {
        [self em14_setupViews];
    }
    return self;
}


- (ZhenwupLogin_Server *)em14_LoginServer {
    if (!_em14_LoginServer) {
        _em14_LoginServer = [[ZhenwupLogin_Server alloc] init];
    }
    return _em14_LoginServer;
}


- (void)em14_setupViews {
    [self em14_ShowBackBtn:YES];
    
    self.em11_inputBgView = [[UIView alloc] initWithFrame:CGRectMake(35, 70, self.em_width-70, 100)];
    [self addSubview:self.em11_inputBgView];
    
    self.em14_inputAccView = [[KeenWireField alloc] initWithFrame:CGRectMake(0, 0, self.em11_inputBgView.em_width, 64.0f)];
    self.em14_inputAccView.em14_TextField.placeholder = MUUQYLocalizedString(@"EMKey_AccountNum_Placeholder_Text");
    self.em14_inputAccView.delegate = self;
    self.em14_inputAccView.em14_TextField.keyboardType = UIKeyboardTypeEmailAddress;
    [self.em11_inputBgView addSubview:self.em14_inputAccView];
    
    self.em14_inputAccView.em14_fieldLeftIcon.image = [ZhenwupHelper_Utils imageName:@"zhenwuimacc"];
    
    self.em11_moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.em11_moreBtn.frame = CGRectMake(0, 0, 32, 32);
    self.em11_moreBtn.contentEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    [self.em11_moreBtn setImage:[ZhenwupHelper_Utils imageName:@"zhenwuimpush"] forState:UIControlStateNormal];
    [self.em11_moreBtn addTarget:self action:@selector(em14_HandleClickedHistoryBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.em14_inputAccView em14_setRightView:self.em11_moreBtn];
    
    self.em14_inputPwdView = [[KeenWireField alloc] initWithFrame:CGRectMake(0, self.em14_inputAccView.em_bottom + 5, self.em11_inputBgView.em_width, 64.0f)];
    self.em14_inputPwdView.em14_TextField.placeholder = MUUQYLocalizedString(@"EMKey_Password_Placeholder_Text");
    self.em14_inputPwdView.em14_TextField.secureTextEntry = YES;
    self.em14_inputPwdView.delegate = self;
    [self.em11_inputBgView addSubview:self.em14_inputPwdView];
    self.em11_inputBgView.em_height = self.em14_inputPwdView.em_bottom;
    
    self.em14_inputPwdView.em14_fieldLeftIcon.image = [ZhenwupHelper_Utils imageName:@"zhenwuimpwd"];
    
    self.em11_forgetPwdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.em11_forgetPwdBtn.frame = CGRectMake(0, self.em11_inputBgView.em_bottom + 5, 120, 25);
    self.em11_forgetPwdBtn.em_right = self.em11_inputBgView.em_right;
    self.em11_forgetPwdBtn.titleLabel.font = [ZhenwupTheme_Utils em_colors_NormalFont];
    self.em11_forgetPwdBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self.em11_forgetPwdBtn setTitle:MUUQYLocalizedString(@"EMKey_ForgetPassword_Text") forState:UIControlStateNormal];
    [self.em11_forgetPwdBtn setTitleColor:[ZhenwupTheme_Utils em_colors_GrayColor] forState:UIControlStateNormal];
    [self.em11_forgetPwdBtn addTarget:self action:@selector(em14_HandleClickedForgetPwdBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.em11_forgetPwdBtn];
    
    self.em14_loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.em14_loginBtn.tag = 100;
    self.em14_loginBtn.frame = CGRectMake(0, self.em11_forgetPwdBtn.em_bottom + 10, 127, 35);
    self.em14_loginBtn.titleLabel.font = [ZhenwupTheme_Utils em_colors_NormalFont];
    self.em14_loginBtn.backgroundColor = [ZhenwupTheme_Utils em_colors_ButtonColor];
    self.em14_loginBtn.layer.cornerRadius = 5.0;
    self.em14_loginBtn.layer.masksToBounds = YES;
    [self.em14_loginBtn setTitle:MUUQYLocalizedString(@"EMKey_Login_Text") forState:UIControlStateNormal];
    [self.em14_loginBtn addTarget:self action:@selector(em14_HandleClickedLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.em14_loginBtn];
    
    [self.em14_loginBtn sizeToFit];
    self.em14_loginBtn.em_size = CGSizeMake(MAX(self.em14_loginBtn.em_width + 30, 127), 35);
    self.em14_loginBtn.em_centerX = self.em11_inputBgView.em_centerX;
    
    self.em14_HistoryTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.em11_inputBgView.em_left, self.em11_inputBgView.em_top + self.em14_inputAccView.em_height-3, self.em14_inputAccView.em_width, 92) style:UITableViewStylePlain];
    self.em14_HistoryTableView.hidden = YES;
    self.em14_HistoryTableView.delegate = self;
    self.em14_HistoryTableView.dataSource = self;
    self.em14_HistoryTableView.tableFooterView = [UIView new];
    self.em14_HistoryTableView.layer.borderWidth = EM_1_PIXEL_SIZE;
    self.em14_HistoryTableView.layer.borderColor = [ZhenwupTheme_Utils em_colors_LineColor].CGColor;
    [self.em14_HistoryTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:[NSString stringWithFormat:@"%@",@"HistoryAccountCell"]];
    [self addSubview:self.em14_HistoryTableView];
    
    [self em14_SetupDatas];
}

- (void)em14_SetupDatas {
    NSArray *historyAccounts = [ZhenwupLocalData_Server em14_loadAllSavedLoginedUser];
    self.em14_HistoryAccounts = [[NSMutableArray alloc] initWithCapacity:historyAccounts.count];
    for (ZhenwupUserInfo_Entity *user in [historyAccounts reverseObjectEnumerator]) {
        if (user.accountType == EM_AccountTypeMuu) {
            [self.em14_HistoryAccounts addObject:user];
        }
    }
    ZhenwupUserInfo_Entity *lastLoginUser = self.em14_HistoryAccounts.firstObject;
    self.em14_SelectUser = lastLoginUser;
    self.em14_inputAccView.em14_TextField.text = lastLoginUser.userName;
    self.em14_inputPwdView.em14_TextField.text = lastLoginUser?[NSString stringWithFormat:@"%@",@"********"]:@"";
}

- (void)em11_HiddenHistoryTable {
    if (self.em14_HistoryTableView.hidden != YES) {
        [UIView animateWithDuration:0.25 animations:^{
            self.em14_HistoryTableView.em_height = 0;
        } completion:^(BOOL finished) {
            self.em14_HistoryTableView.hidden = YES;
        }];
    }
}

- (void)em14_u_ShowHistoryTable {
    if (self.em14_HistoryTableView.hidden == YES) {
        self.em14_HistoryTableView.hidden = NO;
        self.em14_HistoryTableView.em_height = 0;
        [UIView animateWithDuration:0.25 animations:^{
            self.em14_HistoryTableView.em_height = 90;
        }];
    }
}


- (void)em14_HandleClickedBackBtn:(id)sender {
    [self em11_HiddenHistoryTable];
    if (self.delegate && [self.delegate respondsToSelector:@selector(em18_CloseAccountLoginView:loginSucess:)]) {
        [self.delegate em18_CloseAccountLoginView:self loginSucess:NO];
    }
}


- (void)em14_HandleClickedForgetPwdBtn:(id)sender {
    [self em11_HiddenHistoryTable];
    if (self.delegate && [self.delegate respondsToSelector:@selector(em18_ForgetPwdAtLoginView:)]) {
        [self.delegate em18_ForgetPwdAtLoginView:self];
    }
}

- (void)em14_HandleClickedLoginBtn:(id)sender {
    [self em11_HiddenHistoryTable];
    NSString *account = _em14_inputAccView.em14_TextField.text;
    NSString *password = _em14_inputPwdView.em14_TextField.text;
    
    if (!account || [account isEmpty]) {
        [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_AccountNum_Miss_Alert_Text")];
        return;
    }
    if (!password || [password isEmpty]) {
        [MBProgressHUD em14_showError_Toast:MUUQYLocalizedString(@"EMKey_Password_Miss_Alert_Text")];
        return;
    }
    
    if (self.em14_SelectUser) {
        password = self.em14_SelectUser.password;
    } else {
        password = [[password hash_md5] uppercaseString];
    }
    
    [MBProgressHUD em14_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.em14_LoginServer lhxy_DeviceActivate:account md5Password:password responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD em14_DismissLoadingHUD];
        
        if (result.em14_responseCode == EM_ResponseCodeSuccess) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(em18_CloseAccountLoginView:loginSucess:)]) {
                [weakSelf.delegate em18_CloseAccountLoginView:weakSelf loginSucess:YES];
            } else {
                [weakSelf removeFromSuperview];
            }
        } else {
            weakSelf.em14_inputPwdView.em14_TextField.text = @"";
            [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
        }
    }];
}

- (void)em14_HandleClickedHistoryBtn:(id)sender {
    if (self.em14_HistoryTableView.hidden) {
        [self em14_u_ShowHistoryTable];
        [self.em14_HistoryTableView reloadData];
    } else {
        [self em11_HiddenHistoryTable];
    }
}

- (void)em14_HandleClickedDelHistoryAccountBtn:(UIButton *)sender {
    if (sender.tag - 1 < self.em14_HistoryAccounts.count) {
        ZhenwupUserInfo_Entity *user = self.em14_HistoryAccounts[sender.tag - 1];
        [self.em14_HistoryAccounts removeObject:user];
        
        [ZhenwupLocalData_Server em14_removeLoginedUserInfoFormHistory:user];
    }
    
    [self.em14_HistoryTableView reloadData];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self em11_HiddenHistoryTable];
    
    self.em14_SelectUser = self.em14_HistoryAccounts[indexPath.row];
    
    self.em14_inputAccView.em14_TextField.text = self.em14_SelectUser.userName;
    self.em14_inputPwdView.em14_TextField.text = (self.em14_HistoryAccounts.count>0)?[NSString stringWithFormat:@"%@",@"********"]:@"";
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.em14_HistoryAccounts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%@",@"HistoryAccountCell"] forIndexPath:indexPath];
    [cell.contentView em_removeAllSubviews];
    
    ZhenwupUserInfo_Entity *user = self.em14_HistoryAccounts[indexPath.row];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, cell.em_width - cell.em_height - 15, cell.em_height)];
    if (user.accountType == EM_AccountTypeMuu) {
        lab.text = user.userName;
    } else {
        lab.text = user.userID;
    }
    lab.font = [ZhenwupTheme_Utils em_colors_NormalFont];
    [cell.contentView addSubview:lab];
    
    UIButton *delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    delBtn.tag = indexPath.row + 1;
    delBtn.frame = CGRectMake(cell.em_width - cell.em_height/2, cell.em_height/4, cell.em_height/2, cell.em_height/2);
    [delBtn setImage:[ZhenwupHelper_Utils imageName:@"zhenwuimshan"] forState:UIControlStateNormal];
    [delBtn addTarget:self action:@selector(em14_HandleClickedDelHistoryAccountBtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:delBtn];
    
    return cell;
}


- (BOOL)em14_InputTextFieldViewShouldReturn:(KeenWireField *)inputView {
    self.em14_SelectUser = nil;
    if (inputView == self.em14_inputAccView) {
        [self.em14_inputPwdView.em14_TextField becomeFirstResponder];
    } else if (inputView == self.em14_inputPwdView) {
        
    }
    return YES;
}

- (void)em14_InputTextFieldViewTextDidChange:(KeenWireField *)inputView {
    self.em14_SelectUser = nil;
    if (inputView == self.em14_inputAccView) {
        self.em14_inputPwdView.em14_TextField.text = @"";
    }
}
@end
