
#import "ZhenwupSDKMainView_Controller.h"

#import "ZhenwupAutoLogin_View.h"
#import "ZhenwupAccountLogin_View.h"
#import "ZhenwupRegister_View.h"
#import "ZhenwupResetPwd_View.h"

#import "ZhenwupShortcut_View.h"
#import "ZhenwupAccount_View.h"

#import "ZhenwupAccountUpgrade_View.h"
#import "ZhenwupModifyPwd_View.h"
#import "ZhenwupAccount_Server.h"

#import "ZhenwupGuestAccountPrompt_View.h"
#import "GrossAlertCrlV.h"
#import "ZhenwupOneClickLoginV.h"
#import "ZhenwupLocalData_Server.h"
#import "ZhenwupTelDataServer.h"
#import "ZhenwupOpenAPI.h"
#import "ZhenwupSDKGlobalInfo_Entity.h"
#import "UIView+GrossExtension.h"
#import "ZhenwupTheme_Utils.h"
#import "ZhenwupChooseLoginView.h"
#import "ZhenwupLogin_View.h"
#import "ZhenwupRecentNewsV.h"



#import "ZhenwupOutConfirmV.h"

#import "ZhenwupBindTelView.h"

#import "ZhenwupRecentNews2V.h"
#import "ZhenwupCouponV2.h"

#import "ZhenwupOneClickLoginV2.h"
@interface ZhenwupSDKMainView_Controller () <EM1_AutoLogin_ViewDelegate, EM1_AccountLogin_ViewDelegate, EM1_RegisterViewDelegate, EM1_ResetPwd_ViewDelegate, EM1_ModifyPwd_ViewDelegate, EM1_Account_ViewDelegate, EM1_AccountUpgrade_ViewDelegate, EM1_GuestAccountPrompt_ViewDelegate,EM1_Login_ViewDelegate,EM_RecentNewsVDelegate,EM1_OutConfirmVDelegate,EM1_BindTelViewDelegate,EM1_ChooseLoginViewDelegate,EM1_OneClickLoginVDelegate,EM_RecentNews2VDelegate,EmpireOneClickLoginV2Delegate>

@property (nonatomic, strong) ZhenwupLogin_View *em18_LoginView;

@property (nonatomic, strong) ZhenwupOneClickLoginV2 *em18_LoginEmailView;


@property (nonatomic, strong) ZhenwupAutoLogin_View *em11_AutoLoginView;
@property (nonatomic, strong) ZhenwupAccountLogin_View *em14_AccountLoginView;
@property (nonatomic, strong) ZhenwupRegister_View *khxl_RegisterView;
@property (nonatomic, strong) ZhenwupResetPwd_View *zwp01_ResetPwdView;

@property (nonatomic, strong) ZhenwupAccount_Server *em11_AccountServer;
@property (nonatomic, strong) ZhenwupAccountUpgrade_View *em11_AccountUpgradeView;
@property (nonatomic, strong) ZhenwupModifyPwd_View *khxl_ModifyPasswordView;

@property (nonatomic, strong) ZhenwupGuestAccountPrompt_View *zwp01_GuestAccountPromptView;
@property (nonatomic, strong) ZhenwupAccount_View *em_AccountView;

@property (nonatomic, strong) ZhenwupRecentNewsV *lhxy_rencentV;
@property (nonatomic, strong) ZhenwupRecentNews2V *lhxy_rencent2V;




@property (nonatomic, strong) ZhenwupCouponV2 *lhxy_couponV2;
@property (nonatomic, strong) ZhenwupOutConfirmV *khxl_confirmV;



@property (nonatomic, strong) ZhenwupBindTelView *em18_tieTelV;
@property (nonatomic, strong) ZhenwupChooseLoginView *em_chooseLoginV;
@property (nonatomic, strong) ZhenwupOneClickLoginV *em14_oneClickV;
@end

@implementation ZhenwupSDKMainView_Controller

- (void)dealloc {
    MYMGLog(@"%@ dealloc..", NSStringFromClass([self class]));
}

- (instancetype)init {
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.frame = [UIScreen mainScreen].bounds;
    _em18_LoginView.center = self.center;
    
    _em18_LoginEmailView.center = self.center;
    _em11_AutoLoginView.center = self.center;
    _em14_AccountLoginView.center = self.center;
    _khxl_RegisterView.center = self.center;
    _zwp01_ResetPwdView.center = self.center;
  
  
    _em11_AccountUpgradeView.center = self.center;
    _khxl_ModifyPasswordView.center = self.center;

    _zwp01_GuestAccountPromptView.center = self.center;
    _em_AccountView.center = self.center;


    _lhxy_rencentV.center = self.center;
  
    _lhxy_couponV2.center = self.center;
    
    _khxl_confirmV.center = self.center;
 

    _em18_tieTelV.center = self.center;
    _em_chooseLoginV.center = self.center;
    _em14_oneClickV.center = self.center;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_em14_AccountLoginView em11_HiddenHistoryTable];
    [self endEditing:YES];
}


- (ZhenwupLogin_View *)em18_LoginView {
    if (!_em18_LoginView) {
        _em18_LoginView = [[ZhenwupLogin_View alloc] init];
        _em18_LoginView.delegate = self;
    }
    return _em18_LoginView;
}

- (ZhenwupOneClickLoginV2 *)em18_LoginEmailView {
    if (!_em18_LoginEmailView) {
        _em18_LoginEmailView = [[ZhenwupOneClickLoginV2 alloc] init];
        _em18_LoginEmailView.delegate = self;
    }
    return _em18_LoginEmailView;
}

- (ZhenwupChooseLoginView *)em_chooseLoginV{
    if (!_em_chooseLoginV) {
        _em_chooseLoginV = [[ZhenwupChooseLoginView alloc] init];
        _em_chooseLoginV.delegate = self;
    }
    return _em_chooseLoginV;
}

- (ZhenwupAutoLogin_View *)em11_AutoLoginView {
    if (!_em11_AutoLoginView) {
        _em11_AutoLoginView = [[ZhenwupAutoLogin_View alloc] init];
        _em11_AutoLoginView.delegate = self;
    }
    return _em11_AutoLoginView;
}

- (ZhenwupAccountLogin_View *)em14_AccountLoginView {
    if (!_em14_AccountLoginView) {
        _em14_AccountLoginView = [[ZhenwupAccountLogin_View alloc] init];
        _em14_AccountLoginView.delegate = self;
    }
    return _em14_AccountLoginView;
}

- (ZhenwupRegister_View *)khxl_RegisterView {
    if (!_khxl_RegisterView) {
        _khxl_RegisterView = [[ZhenwupRegister_View alloc] init];
        _khxl_RegisterView.delegate = self;
    }
    return _khxl_RegisterView;
}

- (ZhenwupOneClickLoginV *)em14_oneClickV{
    if (!_em14_oneClickV) {
        _em14_oneClickV = [[ZhenwupOneClickLoginV alloc] init];
        _em14_oneClickV.delegate = self;
    }
    return _em14_oneClickV;
}

- (ZhenwupResetPwd_View *)zwp01_ResetPwdView {
    if (!_zwp01_ResetPwdView) {
        _zwp01_ResetPwdView = [[ZhenwupResetPwd_View alloc] init];
        _zwp01_ResetPwdView.delegate = self;
    }
    return _zwp01_ResetPwdView;
}



- (ZhenwupBindTelView *)em18_tieTelV{
    if (!_em18_tieTelV) {
        _em18_tieTelV = [[ZhenwupBindTelView alloc]init];
        _em18_tieTelV.delegate = self;
    }
    return _em18_tieTelV;
}


- (ZhenwupAccountUpgrade_View *)em11_AccountUpgradeView {
    if (!_em11_AccountUpgradeView) {
        _em11_AccountUpgradeView = [[ZhenwupAccountUpgrade_View alloc] init];
        _em11_AccountUpgradeView.delegate = self;
    }
    return _em11_AccountUpgradeView;
}

- (ZhenwupModifyPwd_View *)khxl_ModifyPasswordView {
    if (!_khxl_ModifyPasswordView) {
        _khxl_ModifyPasswordView = [[ZhenwupModifyPwd_View alloc] init];
        _khxl_ModifyPasswordView.delegate = self;
    }
    return _khxl_ModifyPasswordView;
}



- (ZhenwupGuestAccountPrompt_View *)zwp01_GuestAccountPromptView {
    if (!_zwp01_GuestAccountPromptView) {
        _zwp01_GuestAccountPromptView = [[ZhenwupGuestAccountPrompt_View alloc] init];
        _zwp01_GuestAccountPromptView.delegate = self;
    }
    return _zwp01_GuestAccountPromptView;
}

- (ZhenwupAccount_View *)em_AccountView {
    if (!_em_AccountView) {
        _em_AccountView = [[ZhenwupAccount_View alloc] init];
        _em_AccountView.delegate = self;
    }
    return _em_AccountView;
}




- (ZhenwupRecentNewsV *)lhxy_rencentV {
    if (!_lhxy_rencentV) {
        _lhxy_rencentV = [[ZhenwupRecentNewsV alloc] init];
        _lhxy_rencentV.delegate = self;
    }
    return _lhxy_rencentV;
}



- (ZhenwupRecentNews2V *)lhxy_rencent2V {
    if (!_lhxy_rencent2V) {
        _lhxy_rencent2V = [[ZhenwupRecentNews2V alloc] init];
        _lhxy_rencent2V.delegate = self;
    }
    return _lhxy_rencent2V;
}






- (ZhenwupCouponV2 *)lhxy_couponV2 {
    if (!_lhxy_couponV2) {
        _lhxy_couponV2 = [[ZhenwupCouponV2 alloc] init];
        _lhxy_couponV2.delegate = self;
    }
    return _lhxy_couponV2;
}








- (ZhenwupOutConfirmV *)khxl_confirmV
{
    if (!_khxl_confirmV) {
        _khxl_confirmV = [[ZhenwupOutConfirmV alloc]init];
        _khxl_confirmV.delegate = self;
    }
    return _khxl_confirmV;
}

- (void)em18_CloseLoginView:(ZhenwupLogin_View *)loginView loginSucess:(BOOL)success {
    if (success) {
        [self em14_u_HandleLoginSuccessedAtView:loginView];
    } else {
        EMSDKGlobalInfo.isShowedLoginView = NO;
        [self em14_u_MainViewRemoveFromSuperviewAndClear];
    }
}

- (void)em18_RegisterAtLoginView:(ZhenwupLogin_View *)loginView {
    [self em14_u_PushView:self.khxl_RegisterView fromView:loginView animated:YES];
}

- (void)em18_PushAccountLoginView:(ZhenwupLogin_View *)loginView {
    
    
    [self em14_u_PushView:self.em14_AccountLoginView fromView:loginView animated:YES];
}

- (void)em18_PresentAccountLoginAndRegisterView:(ZhenwupChooseLoginView *)loginView{
    [self em14_u_PushView:self.em14_oneClickV fromView:loginView animated:YES];
}

- (void)em11_HandlePopToLastV:(ZhenwupOneClickLoginV *)registerView{
    
    
    self.em_chooseLoginV.enter=@"1";
    [self em14_u_PushView:self.em_chooseLoginV fromView:registerView animated:YES];
}

- (void)em11_2HandlePopToLastV:(ZhenwupOneClickLoginV *)registerView{
    [self em14_u_PushView:self.em14_oneClickV fromView:registerView animated:YES];
}



- (void)em18_PresentFromOneClickToLogin:(ZhenwupOneClickLoginV *)registerView{
    self.em18_LoginView.enter=@"1";
    [self em14_u_PushView:self.em18_LoginView fromView:registerView animated:YES];
}

- (void)em11_HandEmailwithEmial:(NSString *)email withView:(ZhenwupOneClickLoginV *)registerView{
    
    
    [self.em18_LoginEmailView setEmailwith:email];
    
    [self em14_u_PushView:self.em18_LoginEmailView fromView:registerView animated:YES];
    
}


- (void)em11_HandleDidOneClickEmailSuccess:(ZhenwupOneClickLoginV *)registerView{
    EMSDKGlobalInfo.isShowedLoginView = NO;
    [self em14_u_MainViewRemoveFromSuperviewAndClear];
    [ZhenwupShortcut_View em14_ShowShort];
}


- (void)em11_2HandleDidOneClickEmailSuccess:(ZhenwupOneClickLoginV *)registerView{
    EMSDKGlobalInfo.isShowedLoginView = NO;
    [self em14_u_MainViewRemoveFromSuperviewAndClear];
    [ZhenwupShortcut_View em14_ShowShort];
}

- (void)em18_FastAutLoginView:(ZhenwupAutoLogin_View *)autoLoginView loginSucess:(BOOL)success {
    if (success) {
        [self em14_u_HandleLoginSuccessedAtView:autoLoginView];
    } else {
        [self em14_u_PushView:self.em14_AccountLoginView fromView:autoLoginView animated:YES];
    }
}


- (void)em18_CloseAccountLoginView:(ZhenwupLogin_View *)accountLoginView loginSucess:(BOOL)success {
    if (success) {
        [self em14_u_HandleLoginSuccessedAtView:accountLoginView];
    } else {
        [self em14_u_PushView:self.em14_oneClickV fromView:accountLoginView animated:YES];
    }
}





- (void)em18_CloseChooseLoginView:(ZhenwupChooseLoginView *)loginView loginSucess:(BOOL)success{
    if (success) {
        [self em14_u_HandleLoginSuccessedAtView:loginView];
    }else{
        self.em_chooseLoginV.enter=@"1";
        [self em14_u_PushView:self.em_chooseLoginV fromView:loginView animated:YES];
    }
}

- (void)em18_ForgetPwdAtLoginView:(ZhenwupLogin_View *)accountLoginView {
    self.zwp01_ResetPwdView.isFromLogin = true;
    self.zwp01_ResetPwdView.isFromLogin = true;
    [self em14_u_PushView:self.zwp01_ResetPwdView fromView:accountLoginView animated:YES];
}


- (void)em11_HandlePopRegisterView:(ZhenwupRegister_View *)registerView {
    self.em18_LoginView.enter=@"1";
    [self em14_u_PushView:self.em18_LoginView fromView:registerView animated:YES];
}

- (void)em11_HandleDidRegistSuccess:(ZhenwupRegister_View *)registerView {
    EMSDKGlobalInfo.isShowedLoginView = NO;
    [self em14_u_MainViewRemoveFromSuperviewAndClear];
    [ZhenwupShortcut_View em14_ShowShort];
}


- (void)em11_onClickCloseResetPwdView_Delegate:(ZhenwupResetPwd_View *)resetPwdView isFromLogin:(BOOL)isFromLogin{
    if (isFromLogin) {
        self.em18_LoginView.enter=@"1";
        [self em14_u_PushView:self.em18_LoginView fromView:resetPwdView animated:YES];
    }else{
        [self em14_u_MainViewRemoveFromSuperviewAndClear];
    }
}

- (void)em11_resetPwdSuccess_Delegate:(ZhenwupResetPwd_View *)resetPwdView {
    [self em14_u_MainViewRemoveFromSuperviewAndClear];
}


- (void)em11_HandleCloseModifyPwdView_Delegate:(ZhenwupModifyPwd_View *)modifyPwdView {
    [self em14_u_MainViewRemoveFromSuperviewAndClear];
}



- (void)em11_handleClosedBindTelView_Delegate:(ZhenwupBindTelView *)bindTelView{
    [self em14_u_MainViewRemoveFromSuperviewAndClear];
    if (bindTelView.em11_HandleBeforeClosedView) {
        [self em14_u_MainViewRemoveFromSuperviewAndClear];
    } else {

    }
}



- (void)em11_handleBindTelSuccess_Delegate:(ZhenwupBindTelView *)bindTelView{
    [self em14_u_MainViewRemoveFromSuperviewAndClear];
}


- (void)em11_handleCloseAccount_Delegate:(ZhenwupAccount_View *)accountView {
    [self em14_u_MainViewRemoveFromSuperviewAndClear];
}

- (void)em11_handleAccount_Delegate:(ZhenwupAccount_View *)accountView onClickBtn:(NSInteger)tag {
    switch (tag) {
        case 0:
//            [self em14_u_PushView:self.em_PersonalCenterView fromView:accountView animated:YES];
            break;
        case 1:
            self.em11_AccountUpgradeView.em11_HandleBeforeClosedView = nil;
            [self em14_u_PushView:self.em11_AccountUpgradeView fromView:accountView animated:YES];
            break;
        case 2:
          
            break;
        case 3:
            [self em14_u_PushView:self.khxl_ModifyPasswordView fromView:accountView animated:YES];
            break;
        case 4:
          
            break;
        case 5:
            [ZhenwupOpenAPI logout:NO];
            self.em18_LoginView.enter=@"1";
         
            break;
        default:
            break;
    }
}





- (void)em11_HandleDismissAccountUpgradeView_Delegate:(ZhenwupAccountUpgrade_View *)accountUpgradeView {
    [self em14_u_MainViewRemoveFromSuperviewAndClear];
    [ZhenwupShortcut_View em14_ShowShort];
}

- (void)em11_HandlePopAccountUpgradeView_Delegate:(ZhenwupAccountUpgrade_View *)accountUpgradeView {
    if (accountUpgradeView.em11_HandleBeforeClosedView) {
        [self em14_u_MainViewRemoveFromSuperviewAndClear];
    } else {
        [self em14_u_PushView:self.em_AccountView fromView:accountUpgradeView animated:YES];
    }
}






- (void)em11_HandleClosePromptView:(ZhenwupGuestAccountPrompt_View *)promptView {
    [self em14_u_MainViewRemoveFromSuperviewAndClear];
}

- (void)em11_HandleUpgrateFromPromptView:(ZhenwupGuestAccountPrompt_View *)promptView upgrateCompletion:(void(^)(void))completion {
    self.em11_AccountUpgradeView.em11_HandleBeforeClosedView = completion;
    [self em14_u_PushView:self.em11_AccountUpgradeView fromView:promptView animated:YES];
}

- (void)em11_handleCloseRecentNewsV:(ZhenwupRecentNewsV *)recentNewsV{
    [self em14_u_MainViewRemoveFromSuperviewAndClear];
}


- (void)em11_handleCloseRecentNews2V:(ZhenwupRecentNews2V *)recentNewsV{
    [self em14_u_MainViewRemoveFromSuperviewAndClear];
}








- (void)em11_handleCloseOutConfirmV:(ZhenwupOutConfirmV *)confirmV{
    [self em14_u_MainViewRemoveFromSuperviewAndClear];
}






+ (void)em11_showLoginView {
    if (EMSDKGlobalInfo.isShowedLoginView) return;
    EMSDKGlobalInfo.isShowedLoginView = YES;
    
    UIView *view = [self em14_u_GetCurrentWindowView];
    ZhenwupSDKMainView_Controller *mainView = nil;
    for (UIView *sub in view.subviews) {
        if ([sub isKindOfClass:[ZhenwupSDKMainView_Controller class]]) {
            mainView = (ZhenwupSDKMainView_Controller *)sub;
            break;
        }
    }
    if (mainView == nil) {
        mainView = [[ZhenwupSDKMainView_Controller alloc] init];
        [view addSubview:mainView];
    }
    
    ZhenwupUserInfo_Entity *lastLoginUser;
    if (EMSDKGlobalInfo.lastWayLogin == YES) {
        lastLoginUser = [ZhenwupTelDataServer em14_loadAllSavedLoginedUser].lastObject;
    }else{
        NSArray *historyAccounts = [ZhenwupLocalData_Server em14_loadAllSavedLoginedUser];
        lastLoginUser = historyAccounts.lastObject;
    }
    if (lastLoginUser && EMSDKGlobalInfo.sdkIsLogin == YES) {
        [mainView em14_u_PushView:mainView.em11_AutoLoginView fromView:nil animated:NO];
        [mainView.em11_AutoLoginView em11_AutoLoginWithLastLoginUser:lastLoginUser];
    } else {
        
        mainView.em_chooseLoginV.enter=@"1";
        [mainView em14_u_PushView:mainView.em_chooseLoginV fromView:nil animated:NO];
    }
}

+ (void)em11_showAccountView {
    UIView *view = [self em14_u_GetCurrentWindowView];
    ZhenwupSDKMainView_Controller *mainView = nil;
    for (UIView *sub in view.subviews) {
        if ([sub isKindOfClass:[ZhenwupSDKMainView_Controller class]]) {
            mainView = (ZhenwupSDKMainView_Controller *)sub;
            break;
        }
    }
    if (mainView == nil) {
        mainView = [[ZhenwupSDKMainView_Controller alloc] init];
        [view addSubview:mainView];
    }
    [mainView em14_u_PushView:mainView.em_AccountView fromView:nil animated:NO];
}

+ (void)em11_showCustomerServiceView {
    
}

+ (void)em14_showRencentV {
    UIView *view = [self em14_u_GetCurrentWindowView];
    ZhenwupSDKMainView_Controller *mainView = nil;
    for (UIView *sub in view.subviews) {
        if ([sub isKindOfClass:[ZhenwupSDKMainView_Controller class]]) {
            mainView = (ZhenwupSDKMainView_Controller *)sub;
            break;
        }
    }
    if (mainView == nil) {
        mainView = [[ZhenwupSDKMainView_Controller alloc] init];
        [view addSubview:mainView];
    }
    [mainView em14_u_PushView:mainView.lhxy_rencentV fromView:nil animated:NO];
}

+ (void)em14_showRencent2V {
    UIView *view = [self em14_u_GetCurrentWindowView];
    ZhenwupSDKMainView_Controller *mainView = nil;
    for (UIView *sub in view.subviews) {
        if ([sub isKindOfClass:[ZhenwupSDKMainView_Controller class]]) {
            mainView = (ZhenwupSDKMainView_Controller *)sub;
            break;
        }
    }
    if (mainView == nil) {
        mainView = [[ZhenwupSDKMainView_Controller alloc] init];
        [view addSubview:mainView];
    }
    [mainView em14_u_PushView:mainView.lhxy_rencent2V fromView:nil animated:NO];
}

+ (void)em14_showChongV {
  
}

+ (void)em_showTaskV {
  
}

+ (void)em14_showCouponV{
    
}


- (void)em14_showCouponV1{
    
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *str = [formatter stringFromDate:date];
    

    if([[NSUserDefaults standardUserDefaults] boolForKey:str]){
        //
    }else{
        
      
            __weak typeof(self) weakSelf = self;
            [self.em11_AccountServer khxl_obtainCouponLsitWithzwp01_lt:1 responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull result) {
                [MBProgressHUD em14_DismissLoadingHUD];
                if (result.em14_responseCode == EM_ResponseCodeSuccess) {
                   
                        NSArray *arr = (NSArray *)result.em14_responeResult;
                      
                    
                    if( [arr count]>0){
                        [ZhenwupCouponV2 em14_ShowShort];
                    }
                    
                    
                }
                
                
            }];
        
        
        
       
    }
    
    
    
   
    
    
//    UIView *view = [self em14_u_GetCurrentWindowView];
//    ZhenwupSDKMainView_Controller *mainView = nil;
//    for (UIView *sub in view.subviews) {
//        if ([sub isKindOfClass:[ZhenwupSDKMainView_Controller class]]) {
//            mainView = (ZhenwupSDKMainView_Controller *)sub;
//            break;
//        }
//    }
//    if (mainView == nil) {
//        mainView = [[ZhenwupSDKMainView_Controller alloc] init];
//        [view addSubview:mainView];
//    }
//    [mainView em14_u_PushView:mainView.lhxy_couponV2 fromView:nil animated:NO];
}


+ (void)em_showMyAccV{
    
}

+ (void)em11_showMyShopV{
   
}

+ (void)em14_showConfirmV{
    UIView *view = [self em14_u_GetCurrentWindowView];
    ZhenwupSDKMainView_Controller *mainView = nil;
    for (UIView *sub in view.subviews) {
        if ([sub isKindOfClass:[ZhenwupSDKMainView_Controller class]]) {
            mainView = (ZhenwupSDKMainView_Controller *)sub;
            break;
        }
    }
    if (mainView == nil) {
        mainView = [[ZhenwupSDKMainView_Controller alloc] init];
        [view addSubview:mainView];
    }
    [mainView em14_u_PushView:mainView.khxl_confirmV fromView:nil animated:NO];
}

+ (void)em11_logoutAction{
    [ZhenwupOpenAPI logout:NO];
//    UIView *view = [self em14_u_GetCurrentWindowView];
//    ZhenwupSDKMainView_Controller *mainView = nil;
//    for (UIView *sub in view.subviews) {
//        if ([sub isKindOfClass:[ZhenwupSDKMainView_Controller class]]) {
//            mainView = (ZhenwupSDKMainView_Controller *)sub;
//            break;
//        }
//    }
//    if (mainView == nil) {
//        mainView = [[ZhenwupSDKMainView_Controller alloc] init];
//        [view addSubview:mainView];
//    }
//    [mainView em14_u_PushView:mainView.em_chooseLoginV fromView:nil animated:NO];
}

+ (void)em18_showModifyPwdV{
    UIView *view = [self em14_u_GetCurrentWindowView];
    ZhenwupSDKMainView_Controller *mainView = nil;
    for (UIView *sub in view.subviews) {
        if ([sub isKindOfClass:[ZhenwupSDKMainView_Controller class]]) {
            mainView = (ZhenwupSDKMainView_Controller *)sub;
            break;
        }
    }
    if (mainView == nil) {
        mainView = [[ZhenwupSDKMainView_Controller alloc] init];
        [view addSubview:mainView];
    }
    mainView.zwp01_ResetPwdView.isFromLogin = false;
    [mainView em14_u_PushView:mainView.zwp01_ResetPwdView fromView:nil animated:NO];
}

+ (void)em18_showPresentV{

}

+ (void)em18_showUpgradVCompletion:(void(^)(void))completion{
    UIView *view = [self em14_u_GetCurrentWindowView];
    ZhenwupSDKMainView_Controller *mainView = nil;
    for (UIView *sub in view.subviews) {
        if ([sub isKindOfClass:[ZhenwupSDKMainView_Controller class]]) {
            mainView = (ZhenwupSDKMainView_Controller *)sub;
            break;
        }
    }
    if (mainView == nil) {
        mainView = [[ZhenwupSDKMainView_Controller alloc] init];
        [view addSubview:mainView];
    }
    mainView.em11_AccountUpgradeView.em11_HandleBeforeClosedView = completion;
    [mainView em14_u_PushView:mainView.em11_AccountUpgradeView fromView:nil animated:NO];
    
}


+ (void)em18_showTieMailCompletion:(void(^)(void))completion{
  
    
}

+ (void)em18_showBindTelCompletion:(void(^)(void))completion{
    UIView *view = [self em14_u_GetCurrentWindowView];
    ZhenwupSDKMainView_Controller *mainView = nil;
    for (UIView *sub in view.subviews) {
        if ([sub isKindOfClass:[ZhenwupSDKMainView_Controller class]]) {
            mainView = (ZhenwupSDKMainView_Controller *)sub;
            break;
        }
    }
    if (mainView == nil) {
        mainView = [[ZhenwupSDKMainView_Controller alloc] init];
        [view addSubview:mainView];
    }
    mainView.em18_tieTelV.em11_HandleBeforeClosedView = completion;
    [mainView em14_u_PushView:mainView.em18_tieTelV fromView:nil animated:NO];
    
}

+ (void)em18_showBindTelVWithGameId:(NSString *)em11_gameId em14_roleId:(NSString *)em14_roleId{
    UIView *view = [self em14_u_GetCurrentWindowView];
    ZhenwupSDKMainView_Controller *mainView = nil;
    for (UIView *sub in view.subviews) {
        if ([sub isKindOfClass:[ZhenwupSDKMainView_Controller class]]) {
            mainView = (ZhenwupSDKMainView_Controller *)sub;
            break;
        }
    }
    if (mainView == nil) {
        mainView = [[ZhenwupSDKMainView_Controller alloc] init];
        [view addSubview:mainView];
    }
    mainView.em18_tieTelV.em_needTiePresent = true;
    mainView.em18_tieTelV.em11_gameId = em11_gameId;
    mainView.em18_tieTelV.em14_roleId = em14_roleId;
    [mainView em14_u_PushView:mainView.em18_tieTelV fromView:nil animated:NO];
}

+ (void)em14_showPersonInfoV{

}

+ (UIView *)em14_u_GetCurrentWindowView {
    
    return EMSDKAPI.context.view;
}

- (void)em14_u_MainViewRemoveFromSuperviewAndClear {
    [self removeFromSuperview];
}

- (void)em14_u_HandleLoginSuccessedAtView:(UIView *)view {
    
    
    
    EMSDKGlobalInfo.isShowedLoginView = NO;
    if ((EMSDKGlobalInfo.em14_sdkFlag & EM_SDKFlagBindemail) && EMSDKGlobalInfo.userInfo.accountType == EM_AccountTypeGuest && EMSDKGlobalInfo.userInfo.isReg == NO) {
        
        
        self.zwp01_GuestAccountPromptView.em11_HandleBeforeClosedView = ^{
            [ZhenwupShortcut_View em14_ShowShort];
        };
        [self em14_u_PushView:self.zwp01_GuestAccountPromptView fromView:view animated:YES];
    } else {
        [self em14_u_MainViewRemoveFromSuperviewAndClear];
        [ZhenwupShortcut_View em14_ShowShort];
    }
    
    
    
   
    if (EMSDKGlobalInfo.em14_sdkFlag & EM_SDKFlagCoup) {
        
        [self em14_showCouponV1];
        
    } else {
      
    }
    
    
    
    
    
    
}

- (void)em14_u_PushView:(UIView *)view fromView:(UIView *)parentView animated:(BOOL)animated {
    if (parentView == nil) {
        [self em_removeAllSubviews];
    }
    
    if ([self.subviews containsObject:view] == NO) {
        [self addSubview:view];
    }
    
    [self.superview bringSubviewToFront:self];
    
    if (animated) {
        view.alpha = 0.5f;
        [UIView animateWithDuration:0.25 animations:^{
            parentView.alpha = 0.0;
            view.alpha = 1.0;
        } completion:^(BOOL finished) {
            
        }];
    } else {
        view.alpha = 1.0;
        view.hidden = NO;
        parentView.hidden = YES;
    }
}

- (ZhenwupAccount_Server *)em11_AccountServer {
    if (!_em11_AccountServer) {
        _em11_AccountServer = [[ZhenwupAccount_Server alloc] init];
    }
    return _em11_AccountServer;
}


@end
