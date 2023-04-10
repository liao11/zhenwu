
#import "ZhenwupLogin_View.h"
#import "KeenWireField.h"
#import "ZhenwupLogin_Server.h"
#import "ZhenwupLocalData_Server.h"
#import "NSString+GrossExtension.h"
#import "ZhenwupTelDataServer.h"
#import "ZhenwupSegView.h"
#define EM_RGBA(r,g,b,a)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
#define EM_RGB(r,g,b)          EM_RGBA(r,g,b,1.0f)
@interface ZhenwupLogin_View () <UITableViewDelegate, UITableViewDataSource, KeenWireFieldDelegate,EmpriSegViewDelegate>

@property (strong, nonatomic) UIView *em18_viewBg;
@property (nonatomic, assign) NSInteger zwp01_type;
@property (nonatomic, strong) ZhenwupSegView *em14_segment;
@property (strong, nonatomic) KeenWireField *em14_inputTxtView;
@property (strong, nonatomic) UIButton *em11_moreBtn;
@property (strong, nonatomic) KeenWireField *em14_inputPsdView;
@property (strong, nonatomic) UIButton *em11_fgtPsdBtn;
@property (strong, nonatomic) UIButton *em11_loginBtn;
@property (strong, nonatomic) UITableView *em14_HistoryTableView;
@property (strong, nonatomic) NSMutableArray *em14_HistoryAccounts;
@property (strong, nonatomic) NSMutableArray *em_historyTelUser;
@property (strong, nonatomic) ZhenwupLogin_Server *em14_LoginServer;
@property (strong, nonatomic) ZhenwupUserInfo_Entity *em14_SelectUser;
@property (nonatomic, strong) ZhenwupAccount_Server *em11_AccountServer;

@end

@implementation ZhenwupLogin_View

- (instancetype)init {
    self = [super initWithCurType:@"1"];
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

- (ZhenwupAccount_Server *)em11_AccountServer {
    if (!_em11_AccountServer) {
        _em11_AccountServer = [[ZhenwupAccount_Server alloc] init];
    }
    return _em11_AccountServer;
}
-(void)setEnter:(NSString *)enter{
    [self em14_SetupDatas];
}
- (void)em14_setupViews {
    
    self.zwp01_type = 0;
    
    [self em14_ShowBackBtn:YES];
    
    self.em14_TitleImgV.hidden=YES;
        
    self.em18_viewBg = [[UIView alloc] initWithFrame:CGRectMake(35, 60, self.em_width-70, 137)];
    [self addSubview:self.em18_viewBg];
    
    
  
    self.em14_segment = [[ZhenwupSegView alloc] initWithTitleArr:@[MUUQYLocalizedString(@"EMKey_Email_Text"), MUUQYLocalizedString(@"EMKey_WordTel")] WithFrame:CGRectMake(20, 0, self.em18_viewBg.em_width-40, 30)];
    self.em14_segment.delegate=self;
    [self.em18_viewBg addSubview:self.em14_segment];

    
    
    
    self.em14_inputTxtView = [[KeenWireField alloc] initWithFrame:CGRectMake(0, 45, self.em18_viewBg.em_width, 40)];
    self.em14_inputTxtView.em14_TextField.placeholder = MUUQYLocalizedString(@"EMKey_AccountNum_Placeholder_Text");
    self.em14_inputTxtView.delegate = self;
    self.em14_inputTxtView.em14_TextField.keyboardType = UIKeyboardTypeEmailAddress;
    [self.em18_viewBg addSubview:self.em14_inputTxtView];
    
    self.em14_inputTxtView.em14_fieldLeftIcon.image = [ZhenwupHelper_Utils imageName:@"zhenwuimacc"];
    self.em14_inputTxtView.em14_fieldLeftIcon.frame= CGRectMake(13, 11.8, 22.3, 16.3);
    
    self.em11_moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.em11_moreBtn.frame = CGRectMake(0, 0, 32, 32);
    self.em11_moreBtn.contentEdgeInsets = UIEdgeInsetsMake(7, 7, 7, 7);
    [self.em11_moreBtn setImage:[ZhenwupHelper_Utils imageName:@"zhenwuimpush"] forState:UIControlStateNormal];
    [self.em11_moreBtn addTarget:self action:@selector(em14_HandleClickedHistoryBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.em14_inputTxtView em14_setRightView:self.em11_moreBtn];
    
    self.em14_inputPsdView = [[KeenWireField alloc] initWithFrame:CGRectMake(0, self.em14_inputTxtView.em_bottom + 12, self.em18_viewBg.em_width, 40)];
    self.em14_inputPsdView.em14_TextField.placeholder = MUUQYLocalizedString(@"EMKey_Password_Placeholder_Text");
    self.em14_inputPsdView.em14_TextField.secureTextEntry = YES;
    self.em14_inputPsdView.delegate = self;
    [self.em18_viewBg addSubview:self.em14_inputPsdView];
    self.em18_viewBg.em_height = self.em14_inputPsdView.em_bottom;
    
    self.em14_inputPsdView.em14_fieldLeftIcon.image = [ZhenwupHelper_Utils imageName:@"zhenwuimresetPwd"];
    self.em14_inputPsdView.em14_fieldLeftIcon.frame= CGRectMake(13, 10.8, 18.5, 20.7);
    
    self.em11_loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.em11_loginBtn.tag = 100;
    self.em11_loginBtn.frame = CGRectMake(80, self.em18_viewBg.em_bottom + 15, self.em_width-160, 40);
    self.em11_loginBtn.titleLabel.font = [ZhenwupTheme_Utils em_colors_NormalFont];
//    [self.em11_loginBtn setTitle:MUUQYLocalizedString(@"EMKey_Login_Text") forState:UIControlStateNormal];
    [self.em11_loginBtn setTitle:@"Login" forState:UIControlStateNormal];

    [ self.em11_loginBtn setBackgroundImage: [ZhenwupHelper_Utils imageName:@"zhenwuimb5"] forState:0];
    self.em11_loginBtn.clipsToBounds = true;
    
   
    
    
    [self.em11_loginBtn addTarget:self action:@selector(em14_HandleClickedlogBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.em11_loginBtn];
    
//    self.em11_loginBtn.em_centerX = self.em14_segment.em_centerX;
    
    
    self.em11_fgtPsdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.em11_fgtPsdBtn.frame = CGRectMake(0, self.em11_loginBtn.em_bottom + 10, 120, 33);
    self.em11_fgtPsdBtn.titleLabel.font = [ZhenwupTheme_Utils khxl_FontSize13];
    self.em11_fgtPsdBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.em11_fgtPsdBtn setTitle:MUUQYLocalizedString(@"EMKey_ForgetPassword_Text") forState:UIControlStateNormal];
    [self.em11_fgtPsdBtn setTitleColor:[ZhenwupTheme_Utils khxl_SmallGrayColor] forState:UIControlStateNormal];
    [self.em11_fgtPsdBtn addTarget:self action:@selector(em14_HandleClickedfgtPsdBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.em11_fgtPsdBtn];
    
    [self.em11_fgtPsdBtn sizeToFit];
    self.em11_fgtPsdBtn.em_size = CGSizeMake(MAX(self.em11_fgtPsdBtn.em_width + 20, 128), 33);
    self.em11_fgtPsdBtn.em_centerX = self.em18_viewBg.em_centerX;
    
    self.em14_HistoryTableView = [[UITableView alloc] initWithFrame:CGRectMake(self.em18_viewBg.em_left, self.em18_viewBg.em_top + self.em14_inputTxtView.em_height -3 + 45, self.em14_inputTxtView.em_width, 92) style:UITableViewStylePlain];
    self.em14_HistoryTableView.hidden = YES;
    self.em14_HistoryTableView.delegate = self;
    self.em14_HistoryTableView.dataSource = self;
    self.em14_HistoryTableView.tableFooterView = [UIView new];
    self.em14_HistoryTableView.layer.borderWidth = EM_1_PIXEL_SIZE;
    
//    self.em14_HistoryTableView.backgroundColor=EM_RGBA(43, 47, 53, 1) ;
    
    self.em14_HistoryTableView.layer.cornerRadius = 6;
    self.em14_HistoryTableView.layer.borderColor = [ZhenwupTheme_Utils khxl_SmalltitleColor].CGColor;
    self.em14_HistoryTableView.backgroundColor= EM_RGBA(43, 47, 53, 1) ; 
    self.em14_HistoryTableView.layer.borderWidth = 1;
    

//    self.em14_HistoryTableView.layer.borderColor = [ZhenwupTheme_Utils em_colors_LineColor].CGColor;
    [self.em14_HistoryTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:[NSString stringWithFormat:@"%@",@"HistoryAccountCell"]];
    [self addSubview:self.em14_HistoryTableView];
    
    [self em14_SetupDatas];
}
- (UIImage *)imageWithColor:(UIColor *)color {
     CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
     UIGraphicsBeginImageContext(rect.size);
     CGContextRef context = UIGraphicsGetCurrentContext();

     CGContextSetFillColorWithColor(context, [color CGColor]);
     CGContextFillRect(context, rect);

     UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
     UIGraphicsEndImageContext();
     return image;
}

-(void)em14_segValeDidChange:(NSInteger)index{
    [self em11_HiddenHistoryTable];
    switch (index) {
            //对应placeholder要更改
        case 0:
        {
            self.zwp01_type = 0;
            self.em14_inputTxtView.em14_fieldLeftIcon.image = [ZhenwupHelper_Utils imageName:@"zhenwuimacc"];
        //    self.em14_inputTxtView.em14_fieldLeftIcon.frame
            self.em14_inputTxtView.em14_fieldLeftIcon.frame= CGRectMake(13, 11.8, 22.3, 16.3);
            self.em14_inputTxtView.zwp01_tel = false;
            self.em14_inputTxtView.em14_TextField.placeholder = MUUQYLocalizedString(@"EMKey_AccountNum_Placeholder_Text");
            self.em14_inputPsdView.em14_TextField.placeholder = MUUQYLocalizedString(@"EMKey_Password_Placeholder_Text");
            [self em14_SetupDatas];
            
//            [self.em14_segment setBackgroundImage:[ZhenwupHelper_Utils imageName:@"zhenwuimseg1"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        }
            break;
        default:
        {
            self.zwp01_type = 1;
            self.em14_inputTxtView.em14_fieldLeftIcon.image = [ZhenwupHelper_Utils imageName:@"zhenwuimphone"];
        //    self.em14_inputTxtView.em14_fieldLeftIcon.frame
            self.em14_inputTxtView.em14_fieldLeftIcon.frame= CGRectMake(13, 10, 13.1, 20);
            self.em14_inputTxtView.zwp01_tel = false;
            self.em14_inputTxtView.em14_TextField.placeholder = MUUQYLocalizedString(@"EMKey_AccountNum_Placeholder_Text");
            self.em14_inputPsdView.em14_TextField.placeholder = MUUQYLocalizedString(@"EMKey_Password_Placeholder_Text");
            [self em14_SetupDatas];
            

        }
            break;
    }
}

- (void)em14_SetupDatas {
    NSMutableArray *historyAccounts;
    if (self.zwp01_type == 0) {
        historyAccounts = [NSMutableArray arrayWithArray:[ZhenwupLocalData_Server em14_loadAllSavedLoginedUser]];
        self.em14_HistoryAccounts = [[NSMutableArray alloc] initWithCapacity:historyAccounts.count];
    }
    else{
        historyAccounts = [NSMutableArray arrayWithArray:[ZhenwupTelDataServer em14_loadAllSavedLoginedUser]];
        self.em_historyTelUser = [[NSMutableArray alloc] initWithCapacity:historyAccounts.count];
    }
    
    self.em14_inputTxtView.em14_TextField.text = @"";
    self.em14_inputPsdView.em14_TextField.text = @"";
    for (ZhenwupUserInfo_Entity *user in [historyAccounts reverseObjectEnumerator]) {
        if (self.zwp01_type == 0) {
            if (user.accountType == EM_AccountTypeMuu) {
                [self.em14_HistoryAccounts addObject:user];
                ZhenwupUserInfo_Entity *lastLoginUser = self.em14_HistoryAccounts.firstObject;
                self.em14_SelectUser = lastLoginUser;
                self.em14_inputTxtView.em14_TextField.text = lastLoginUser.userName;
                self.em14_inputPsdView.em14_TextField.text = lastLoginUser?[NSString stringWithFormat:@"%@",@"********"]:@"";
            }
        }
        else{
            [self.em_historyTelUser addObject:user];
            ZhenwupUserInfo_Entity *lastLoginUser = self.em_historyTelUser.firstObject;
            self.em14_SelectUser = lastLoginUser;
            self.em14_inputTxtView.em14_TextField.text = lastLoginUser.userName;
            self.em14_inputPsdView.em14_TextField.text = lastLoginUser?[NSString stringWithFormat:@"%@",@"********"]:@"";
        }
        
    }
    
    [self.em14_HistoryTableView reloadData];
    
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


- (void)em14_HandleClickedfgtPsdBtn:(id)sender {
    [self em11_HiddenHistoryTable];
    if (self.delegate && [self.delegate respondsToSelector:@selector(em18_ForgetPwdAtLoginView:)]) {
        
        
        [self em14_dataWithevent:@"findPwd" WithRe:@""];
        [self.delegate em18_ForgetPwdAtLoginView:self];
    }
}

- (void)em14_HandleClickedlogBtn:(id)sender {
    [self em11_HiddenHistoryTable];
    NSString *account = _em14_inputTxtView.em14_TextField.text;
    NSString *password = _em14_inputPsdView.em14_TextField.text;
    
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
    
    if (self.zwp01_type == 0) {
        
       
        [self em11_emailLoginWithAccount:account password:password];
    }else{
        [self em_telLoginWithAccount:account password:password em14_telDist:MUUQYLocalizedString(@"EMKey_nowDist")];
    }
}

- (void)em11_emailLoginWithAccount:(NSString *)account password:(NSString *)password
{
    
    [MBProgressHUD em14_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    
    [self em14_dataWithevent:@"clickEmailLogin" WithRe:@""];
    [self.em14_LoginServer lhxy_DeviceActivate:account md5Password:password responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD em14_DismissLoadingHUD];
        
        if (result.em14_responseCode == EM_ResponseCodeSuccess) {
            [self em14_dataWithevent:@"clickMobileLoginSuccess" WithRe: [result description2]];
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(em18_CloseAccountLoginView:loginSucess:)]) {
                [weakSelf.delegate em18_CloseAccountLoginView:weakSelf loginSucess:YES];
            } else {
                [weakSelf removeFromSuperview];
            }
        } else {
            [self em14_dataWithevent:@"clickMobileLoginFail" WithRe: [result description2]];
            weakSelf.em14_inputPsdView.em14_TextField.text = @"";
            [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
        }
    }];
}

- (void)em_telLoginWithAccount:(NSString *)account password:(NSString *)password em14_telDist:(NSString *)em14_telDist
{
    [MBProgressHUD em14_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    
    [self em14_dataWithevent:@"clickMobileLogin" WithRe:@""];
    [self.em14_LoginServer lhxy_telLogin:account md5Password:password em14_telDist:em14_telDist responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        
        [MBProgressHUD em14_DismissLoadingHUD];
        
        if (result.em14_responseCode == EM_ResponseCodeSuccess) {
            [self em14_dataWithevent:@"clickMobileLoginSuccess" WithRe: [result description2]];
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(em18_CloseAccountLoginView:loginSucess:)]) {
                [weakSelf.delegate em18_CloseAccountLoginView:weakSelf loginSucess:YES];
            } else {
                [weakSelf removeFromSuperview];
            }
        } else {
            [self em14_dataWithevent:@"clickMobileLoginFail" WithRe: [result description2]];
            weakSelf.em14_inputPsdView.em14_TextField.text = @"";
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
    if (self.zwp01_type == 0) {
        if (sender.tag - 1 < self.em14_HistoryAccounts.count) {
            ZhenwupUserInfo_Entity *user = self.em14_HistoryAccounts[sender.tag - 1];
            [self.em14_HistoryAccounts removeObject:user];
            
            [ZhenwupLocalData_Server em14_removeLoginedUserInfoFormHistory:user];
        }
    }else{
        if (sender.tag - 1 < self.em_historyTelUser.count) {
            ZhenwupUserInfo_Entity *user = self.em_historyTelUser[sender.tag - 1];
            [self.em_historyTelUser removeObject:user];
            
            [ZhenwupTelDataServer em14_removeLoginedUserInfoFormHistory:user];
        }
    }
    
    
    [self.em14_HistoryTableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self em11_HiddenHistoryTable];
    
    if (self.zwp01_type == 0) {
        self.em14_SelectUser = self.em14_HistoryAccounts[indexPath.row];
        self.em14_inputTxtView.em14_TextField.text = self.em14_SelectUser.userName;
        self.em14_inputPsdView.em14_TextField.text = (self.em14_HistoryAccounts.count>0)?[NSString stringWithFormat:@"%@",@"********"]:@"";
    }else{
        self.em14_SelectUser = self.em_historyTelUser[indexPath.row];
        self.em14_inputTxtView.em14_TextField.text = self.em14_SelectUser.userName;
        self.em14_inputPsdView.em14_TextField.text = (self.em_historyTelUser.count>0)?[NSString stringWithFormat:@"%@",@"********"]:@"";
    }
    
    
    
}

//EM_RGBA(43, 47, 53, 1) ;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.zwp01_type == 0) {
        return self.em14_HistoryAccounts.count;
    }else
        return self.em_historyTelUser.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%@",@"HistoryAccountCell"] forIndexPath:indexPath];
    [cell.contentView em_removeAllSubviews];
    cell.contentView.backgroundColor=[UIColor clearColor];
    cell.backgroundColor=[UIColor clearColor];
//    khxl_SmalltitleColor
    
    ZhenwupUserInfo_Entity *user;
    if (self.zwp01_type == 0) {
        user = self.em14_HistoryAccounts[indexPath.row];
    }else{
        user = self.em_historyTelUser[indexPath.row];
    }
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, cell.em_width - cell.em_height - 15, cell.em_height)];
    if (user.accountType == EM_AccountTypeMuu) {
        lab.text = user.userName;
    } else {
        lab.text = user.userID;
    }
    lab.font = [ZhenwupTheme_Utils em_colors_NormalFont];
    lab.textColor=[UIColor whiteColor];
    [cell.contentView addSubview:lab];
    
    UIButton *delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    delBtn.tag = indexPath.row + 1;
    delBtn.frame = CGRectMake(cell.em_width - cell.em_height/2,3* cell.em_height/8, cell.em_height/4, cell.em_height/4);
    [delBtn setImage:[ZhenwupHelper_Utils imageName:@"zhenwuimclose"] forState:UIControlStateNormal];
    [delBtn addTarget:self action:@selector(em14_HandleClickedDelHistoryAccountBtn:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:delBtn];
    
    return cell;
}


- (BOOL)em14_InputTextFieldViewShouldReturn:(KeenWireField *)inputView {
    self.em14_SelectUser = nil;
    if (inputView == self.em14_inputTxtView) {
        [self.em14_inputPsdView.em14_TextField becomeFirstResponder];
    } else if (inputView == self.em14_inputPsdView) {
        
    }
    return YES;
}

- (void)em14_InputTextFieldViewTextDidChange:(KeenWireField *)inputView {
    self.em14_SelectUser = nil;
    if (inputView == self.em14_inputTxtView) {
        self.em14_inputPsdView.em14_TextField.text = @"";
    }
}
- (void)em14_dataWithevent:(NSString *)event  WithRe:(NSString *)re{
    [self.em11_AccountServer em14_dataWithevent:event WithRe:re withResponseBlock:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        if (result.em14_responseCode == EM_ResponseCodeSuccess) {
            
        } else {
            
        }
    }];
}
@end
