
#import "ZhenwupSDKGlobalInfo_Entity.h"
#import "ZhenwupLocalData_Server.h"
#import "ZhenwupInAppPurchase_Manager.h"
#import "ZhenwupUrlGlobalConfig_Entity.h"
#import "NSString+GrossExtension.h"
#import "ZhenwupOpenAPI.h"
#import "ZhenwupHelper_Utils.h"
#import "GrossAlertCrlV.h"
#import "ZhenwupW_ViewController.h"
#import <MessageUI/MFMailComposeViewController.h>
#import <Firebase/Firebase.h>

@interface ZhenwupSDKGlobalInfo_Entity () <MFMailComposeViewControllerDelegate>

@end

@implementation ZhenwupSDKGlobalInfo_Entity

+ (instancetype)SharedInstance {
    static ZhenwupSDKGlobalInfo_Entity* shareGlobalInfo = nil;
    static dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        shareGlobalInfo = [[self alloc] init];
    });
    return shareGlobalInfo;
}

- (instancetype)init {
    if (self = [super init]) {
        self.gameInfo = [[ZhenwupGameInfo_Entity alloc] init];
        self.userInfo = [[ZhenwupUserInfo_Entity alloc] init];
    }
    return self;
}

- (BOOL)sdkIsLogin {
    return [[NSUserDefaults standardUserDefaults] boolForKey:[NSString stringWithFormat:@"%@",@"NSUserDefaults_Key_SDKIsLoginState"]];
}

- (BOOL)lastWayLogin{
    return [[NSUserDefaults standardUserDefaults] boolForKey:[NSString stringWithFormat:@"%@",@"NSUserDefaults_Key_SDKLastLoginTel"]];
}

- (EM_ResponseType)sdkLoginType {
    return [[NSUserDefaults standardUserDefaults] integerForKey:[NSString stringWithFormat:@"%@",@"NSUserDefaults_Key_SDKLoginType"]];
}





- (void)setSdkIsLogin:(BOOL)sdkIsLogin {
    [[NSUserDefaults standardUserDefaults] setBool:sdkIsLogin forKey:[NSString stringWithFormat:@"%@",@"NSUserDefaults_Key_SDKIsLoginState"]];
}

- (void)setLastWayLogin:(BOOL)lastWayLogin{
    [[NSUserDefaults standardUserDefaults] setBool:lastWayLogin forKey:[NSString stringWithFormat:@"%@",@"NSUserDefaults_Key_SDKLastLoginTel"]];
}


- (void)setSdkConnectServer:(EM_SDKServer)sdkConnectServer {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    EM_SDKServer sdkServer = [userDefault integerForKey:[NSString stringWithFormat:@"%@",@"NSUserDefaults_Key_Sdk_Connect_Server"]];
    if (sdkServer != sdkConnectServer) {
        [userDefault setInteger:sdkConnectServer forKey:[NSString stringWithFormat:@"%@",@"NSUserDefaults_Key_Sdk_Connect_Server"]];
        [userDefault synchronize];
        
        
        [MYMGUrlConfig em14_updateCofigData];
        
        [ZhenwupLocalData_Server em14_removeAllLoginedUserHistory];
        
        self.sdkIsLogin = NO;
    }
}

- (void)em14_parserUserInfoFromResponseResult:(NSDictionary *)result {
    EMSDKGlobalInfo.sdkIsLogin = YES;
    
    self.userInfo.userID = [result objectForKey:[NSString stringWithFormat:@"%@",@"userid"]];
    self.userInfo.token = [result objectForKey:[NSString stringWithFormat:@"%@",@"token"]];
    self.userInfo.autoToken = [result objectForKey:[NSString stringWithFormat:@"%@",@"auto_token"]];
    self.userInfo.isBind = [[result objectForKey:[NSString stringWithFormat:@"%@",@"isBind"]] boolValue];
    self.userInfo.isBindMobile = [[result objectForKey:[NSString stringWithFormat:@"%@",@"isBindMobile"]] boolValue];
    EMSDKAPI.em_tiePresent = [[result objectForKey:[NSString stringWithFormat:@"%@%@",@"isBindG",@"ift"]] boolValue];
    if ([[result objectForKey:[NSString stringWithFormat:@"%@",@"email"]] validateEmail]) {
        self.userInfo.isBindEmail = true;
    }else{
        self.userInfo.isBindEmail = false;
    }
    self.userInfo.accountType = [[result objectForKey:[NSString stringWithFormat:@"%@",@"account_type"]] integerValue];
    self.lightState = [[result objectForKey:[NSString stringWithFormat:@"%@",@"light"]] integerValue];
    
    
    if (self.userInfo.userID) {
        [FIRAnalytics setUserID:self.userInfo.userID];
    }
    [ZhenwupLocalData_Server em14_saveLoginedUserInfo:self.userInfo];
    
    NSArray *products = [result objectForKey:[NSString stringWithFormat:@"%@",@"product"]];
    
    if (products && products.count > 0) {
        NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:products.count];
        for (int i = 0; i < products.count; i++) {
            [arr addObject:[NSString stringWithFormat:@"%@", products[i]]];
        }
        self.productIdentifiers = [NSSet setWithArray:arr];
    } else {
        self.productIdentifiers = [[NSSet alloc] init];
    }
    
    self.customorSeviceMail = [result objectForKey:[NSString stringWithFormat:@"%@",@"kf_email"]]?:@"";
    
    [[ZhenwupInAppPurchase_Manager em11_SharedManager] em11_recheckCachePurchaseOrderReceipts];
}

- (void)em_parserTelInfoFromResponseResult:(NSDictionary *)result {
    EMSDKGlobalInfo.sdkIsLogin = YES;
    
    self.userInfo.userID = [result objectForKey:[NSString stringWithFormat:@"%@",@"userid"]];
    self.userInfo.token = [result objectForKey:[NSString stringWithFormat:@"%@",@"token"]];
    self.userInfo.autoToken = [result objectForKey:[NSString stringWithFormat:@"%@",@"auto_token"]];
    self.userInfo.isBind = [[result objectForKey:[NSString stringWithFormat:@"%@",@"isBind"]] boolValue];
    self.userInfo.isBindMobile = [[result objectForKey:[NSString stringWithFormat:@"%@",@"isBindMobile"]] boolValue];
    EMSDKAPI.em_tiePresent = [[result objectForKey:[NSString stringWithFormat:@"%@%@",@"isBindG",@"ift"]] boolValue];
    
    self.userInfo.accountType = [[result objectForKey:[NSString stringWithFormat:@"%@",@"account_type"]] integerValue];
    self.lightState = [[result objectForKey:[NSString stringWithFormat:@"%@",@"light"]] integerValue];
    
    if ([[result objectForKey:[NSString stringWithFormat:@"%@",@"email"]] validateEmail]) {
        self.userInfo.isBindEmail = true;
    }else{
        self.userInfo.isBindEmail = false;
    }
    
    if (self.userInfo.userID) {
        [FIRAnalytics setUserID:self.userInfo.userID];
    }
    [ZhenwupTelDataServer em14_saveLoginedUserInfo:self.userInfo];
    
    NSArray *products = [result objectForKey:[NSString stringWithFormat:@"%@",@"product"]];
    
    if (products && products.count > 0) {
        NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:products.count];
        for (int i = 0; i < products.count; i++) {
            [arr addObject:[NSString stringWithFormat:@"%@", products[i]]];
        }
        self.productIdentifiers = [NSSet setWithArray:arr];
    } else {
        self.productIdentifiers = [[NSSet alloc] init];
    }
    
    self.customorSeviceMail = [result objectForKey:[NSString stringWithFormat:@"%@",@"kf_email"]]?:@"";
    
    [[ZhenwupInAppPurchase_Manager em11_SharedManager] em11_recheckCachePurchaseOrderReceipts];
}

- (void)clearUselessInfo {
    NSString *gameID = self.gameInfo.gameID;
    NSString *gameKey = self.gameInfo.gameKey;
    self.gameInfo = [[ZhenwupGameInfo_Entity alloc] init];
    self.userInfo = [[ZhenwupUserInfo_Entity alloc] init];
    self.gameInfo.gameID = gameID;
    self.gameInfo.gameKey = gameKey;
}

- (UIViewController *)em14_CurrentVC {
    if (EMSDKAPI.context) {
        return EMSDKAPI.context;
    }
    
    return [ZhenwupSDKGlobalInfo_Entity em14_u_getCurrentVC];
}


+ (UIViewController *)em14_u_getCurrentVC
{
    id<UIApplicationDelegate> delegate = [UIApplication sharedApplication].delegate;
    if ([delegate respondsToSelector:@selector(window)]) {
        return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].delegate.window.rootViewController];
    }
    return [self topViewControllerWithRootViewController:[[UIApplication sharedApplication].windows lastObject].rootViewController];

}

+ (UIViewController *)topViewControllerWithRootViewController:(UIViewController*)rootViewController
{
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    }
    else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    }
    else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
        
    }
    else {
        return rootViewController;
    }
}


- (void)em14_PresendWithUrlString:(NSString *)URLString {
    if (!URLString || [URLString isEmpty]) {
        
        return;
    }
    
    [ZhenwupOpenAPI zwp01_setShortCutHidden:YES];
    ZhenwupW_ViewController *vc = [[ZhenwupW_ViewController alloc] init];
    vc.alhm_uString = URLString;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [[self em14_CurrentVC] presentViewController:nav animated:YES completion:nil];
}


- (void)em14_SendEmail:(NSString *)email {
    if (![MFMailComposeViewController canSendMail]) {
        [GrossAlertCrlV showAlertTitle:MUUQYLocalizedString(@"EMKey_TipsTitle_Text") message:MUUQYLocalizedString(@"EMKey_ConfigEmailAccount_Tips_Text") actionBlock:^(NSString * _Nonnull btnTitle, NSInteger btnIndex) {
            if (btnIndex != 0) {
                
                NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",@"mailto://"]];
                if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL:url];
                }
            }
        } cancelButtonTitle:MUUQYLocalizedString(@"EMKey_CancelButton_Text") otherButtonTitles:@[MUUQYLocalizedString(@"EMKey_ConfirmButton_Text")]];
        return;
    }
    
    [ZhenwupOpenAPI zwp01_setShortCutHidden:YES];
    MFMailComposeViewController *mailSender = [[MFMailComposeViewController alloc] init];
    mailSender.mailComposeDelegate = self;
    [mailSender setSubject:MUUQYLocalizedString(@"EMKey_Feedback_Text")];
    [mailSender setToRecipients:[NSArray arrayWithObject:email?:@""]];
    
    
    
    
    
    
    [EMSDKAPI.context presentViewController:mailSender animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [ZhenwupOpenAPI zwp01_setShortCutHidden:NO];
    [controller dismissViewControllerAnimated:YES completion:nil];
    
    NSString *msg;
    switch (result) {
        case MFMailComposeResultCancelled:
        {
            msg = [NSString stringWithFormat:@"%@",@"用户取消编辑邮件"];
        }
            break;
        case MFMailComposeResultSaved:
        {
            msg = [NSString stringWithFormat:@"%@",@"用户成功保存邮件"];
        }
            break;
        case MFMailComposeResultSent:
        {
            
            msg = [NSString stringWithFormat:@"%@",@"用户点击发送，将邮件放到队列中，还没发送"];
        }
            break;
        case MFMailComposeResultFailed:
        {
            msg = [NSString stringWithFormat:@"%@",@"用户试图保存或者发送邮件失败"];
        }
            break;
    }
    
}
@end
