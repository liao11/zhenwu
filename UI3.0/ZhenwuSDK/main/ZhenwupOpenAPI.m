
#import "ZhenwupOpenAPI.h"

#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <Adjust/Adjust.h>

#import "ZhenwupSDKMainView_Controller.h"
#import "ZhenwupShortcut_View.h"

#import "ZhenwupLogin_Server.h"
#import "ZhenwupAccount_Server.h"
#import "ZhenwupSDKHeart_Server.h"
#import "ZhenwupInAppPurchase_Manager.h"
#import "ZhenwupSignInApple_Manager.h"
#import "ZhenwupLocalData_Server.h"

#import "NSString+GrossExtension.h"
#import "MBProgressHUD+GrossExtension.h"
#import "GrossAlertCrlV.h"
#import "ZhenwupHelper_Utils.h"
#import "ZhenwuSDK.h"
#import <Firebase/Firebase.h>
#import "UIDevice+GrossExtension.h"
#import "ZhenwupRecentNews2V.h"
#import "ZhenwupAccount_Server.h"
#import "ZhenwupShortcut_View.h"
@implementation ZhenwupOpenAPI
{
    NSString * _zwp01_SDKVersion;
}


- (void)setZwp01_localizedLanguage:(EM_Language)zwp01_localizedLanguage {
    NSLog(@"setzwp01_localizedLanguage");
    [[NSUserDefaults standardUserDefaults] setInteger:zwp01_localizedLanguage forKey:[NSString stringWithFormat:@"%@",@"NSUserDefaults_Key_Localized_Language"]];
    [ZhenwupShortcut_View em14_ResetLocalizedString];
}

- (EM_Language)zwp01_localizedLanguage {
    NSLog(@"zwp01_localizedLanguage");
    return [[NSUserDefaults standardUserDefaults] integerForKey:[NSString stringWithFormat:@"%@",@"NSUserDefaults_Key_Localized_Language"]];
}

- (ZhenwupUserInfo_Entity *)userInfo {
    if (EMSDKGlobalInfo.userInfo.userID && EMSDKGlobalInfo.userInfo.userID.length >0) {
        return EMSDKGlobalInfo.userInfo;
    }
    return nil;
}

- (ZhenwupGameInfo_Entity *)gameInfo {
    if (EMSDKGlobalInfo.gameInfo.gameID && EMSDKGlobalInfo.gameInfo.gameID.length >0) {
        return EMSDKGlobalInfo.gameInfo;
    }
    return nil;
}

- (NSString *)zwp01_SDKVersion {
    if (!_zwp01_SDKVersion) {
        _zwp01_SDKVersion = [NSString stringWithFormat:@"330%08ld", (long)ZhenwuSDKVersionNumber];
    }
    return _zwp01_SDKVersion;
}


+ (instancetype)SharedInstance {
    static ZhenwupOpenAPI* shareApi = nil;
    static dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        shareApi = [[self alloc] init];
    });
    return shareApi;
}

+ (void)zwp01_openDevLog:(BOOL)isOpen {
    NSLog(@"zwp01_openDevLog");
    EMSDKGlobalInfo.iszwp01_openDevLog = isOpen;
}

+ (void)zwp01_launchSDKWithConfig:(ZhenwupSDKConfig_Entity *)config application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    EMSDKGlobalInfo.isEnterGame = NO;
    EMSDKGlobalInfo.gameInfo.gameID = config.gameID;
    EMSDKGlobalInfo.gameInfo.gameKey = config.gameKey;
    EMSDKGlobalInfo.adjustConfig = config.adjustConfig;
    EMSDKGlobalInfo.sdkConnectServer = config.sdkConnectServer;
    
    [MYMGUrlConfig em14_updateCofigData];
    
    NSString *environment = ADJEnvironmentSandbox;
    if (ZW_EnvironmentProduction == config.adjustConfig.environment) {
        environment = ADJEnvironmentProduction;
    }
    
    
    
    ADJLogLevel logLevel = (EMSDKGlobalInfo.iszwp01_openDevLog ? ADJLogLevelVerbose : ADJLogLevelSuppress);
    ADJConfig *adjustConfig = [ADJConfig configWithAppToken:config.adjustConfig.adjustAppToken environment:environment];
    [adjustConfig setLogLevel:logLevel];
    [Adjust appDidLaunch:adjustConfig];
    

    [FIRApp configure];
    
    [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
    [FBSDKSettings setAppID:config.facebookAppID];
    FBSDKLoginManager *fbManager = [[FBSDKLoginManager alloc] init];
    [fbManager logOut];
    [[ZhenwupLogin_Server new] lhxy_DeviceActivate:^(ZhenwupResponseObject_Entity * _Nonnull result) {}];

    [[ZhenwupSignInApple_Manager em11_SharedManager] em11_CheckCredentialState];
    
    [FIRAnalytics logEventWithName:[NSString stringWithFormat:@"%@",@"App启动"] parameters:nil];
    
    if (@available(iOS 10.0, *)) {
      
      
      [UNUserNotificationCenter currentNotificationCenter].delegate = [self SharedInstance];
      UNAuthorizationOptions authOptions = UNAuthorizationOptionAlert |
          UNAuthorizationOptionSound | UNAuthorizationOptionBadge;
      [[UNUserNotificationCenter currentNotificationCenter]
          requestAuthorizationWithOptions:authOptions
          completionHandler:^(BOOL granted, NSError * _Nullable error) {
            
          }];
    } else {
      
      UIUserNotificationType allNotificationTypes =
      (UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge);
      UIUserNotificationSettings *settings =
      [UIUserNotificationSettings settingsForTypes:allNotificationTypes categories:nil];
      [application registerUserNotificationSettings:settings];
    }

    [application registerForRemoteNotifications];
}

+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    [FBSDKAppEvents activateApp];
    return [[FBSDKApplicationDelegate sharedInstance] application:application openURL:url sourceApplication:sourceApplication annotation:annotation];
}

+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    [FBSDKAppEvents activateApp];
    return [[FBSDKApplicationDelegate sharedInstance] application:application openURL:url options:options];
}

+ (void)zwp01_initialSDK {
    [MBProgressHUD em14_ShowLoadingHUD];
    [[ZhenwupLogin_Server new] lhxy_InitSDK:^(ZhenwupResponseObject_Entity *result) {
        [MBProgressHUD em14_DismissLoadingHUD];
        if (result.em14_responeResult && [result.em14_responeResult isKindOfClass:[NSDictionary class]]) {
            
            
            EMSDKGlobalInfo.em14_sdkFlag = [result.em14_responeResult[[NSString stringWithFormat:@"%@",@"v_ctrl"]] integerValue];
            EMSDKGlobalInfo.login_agree = result.em14_responeResult[[NSString stringWithFormat:@"%@",@"login_agree"]];
            EMSDKGlobalInfo.reg_agree = result.em14_responeResult[[NSString stringWithFormat:@"%@",@"reg_agree "]]?:EMSDKGlobalInfo.login_agree;
//            EMSDKGlobalInfo.hint = result.em14_responeResult[[NSString stringWithFormat:@"%@",@"hint"]]?:@"";
            
            EMSDKGlobalInfo.notice = result.em14_responeResult[[NSString stringWithFormat:@"%@",@"notice"]]?:@"";
            
            EMSDKGlobalInfo.em11_GvCheck = [result.em14_responeResult[@"gv_checked"] boolValue]?:EMSDKGlobalInfo.em11_GvCheck;
            
            
            if (EMSDKGlobalInfo.notice.length>0) {
                NSLog(@"EMSDKGlobalInfo.notice  ===%@",EMSDKGlobalInfo.notice);
                [self em14_showRencentV];
            }
           
            
            
            
            
            
        } else {
            EMSDKGlobalInfo.em14_sdkFlag = EM_SDKFlagNone;
        }
    }];
}

+ (void)em14_showRencentV {
    
    
    [ZhenwupSDKMainView_Controller em14_showRencent2V];
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
//    
//    
//    [mainView em14_u_PushView:mainView.lhxy_rencentV fromView:nil animated:NO];
//    ZhenwupRecentNews2V *_lhxy_rencentV = [[ZhenwupRecentNews2V alloc] init];
//
//    _lhxy_rencentV.delegate = self;
////    mainView
//
//
////    [mainView yl
//    [mainView em14_u_PushView:_lhxy_rencentV fromView:nil animated:NO];
    
    
    
}



+ (UIView *)em14_u_GetCurrentWindowView {
    
    return EMSDKAPI.context.view;
}


+ (void)activateApp {
    [FBSDKAppEvents activateApp];
}

+ (void)zwp01_completeNoviceTask {
    ADJEvent *event = [ADJEvent eventWithEventToken:EMSDKGlobalInfo.adjustConfig.zwp01_eventTokenCompleteNoviceTask];
    [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:EMSDKGlobalInfo.userInfo.userID?:@""];
    [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"game_id"] value:EMSDKGlobalInfo.gameInfo.gameID?:@""];
    [Adjust trackEvent:event];

    [FIRAnalytics logEventWithName:[NSString stringWithFormat:@"%@",@"完成新手任务"] parameters:@{ [NSString stringWithFormat:@"%@",@"user_id"]: EMSDKGlobalInfo.userInfo.userID?:@"", [NSString stringWithFormat:@"%@",@"game_id"]: EMSDKGlobalInfo.gameInfo.gameID?:@""}];
    
    [[ZhenwupAccount_Server new] em11_sendFinishNewTaskRequest:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        
    }];
}


+ (void)zwp01_begincdnTask{
    ADJEvent *event = [ADJEvent eventWithEventToken:EMSDKGlobalInfo.adjustConfig.zwp01_eventTokenbegincdnTask];
    [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:EMSDKGlobalInfo.userInfo.userID?:@""];
    [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"game_id"] value:EMSDKGlobalInfo.gameInfo.gameID?:@""];
    [Adjust trackEvent:event];

    [FIRAnalytics logEventWithName:[NSString stringWithFormat:@"%@",@"cdn加载"] parameters:@{ [NSString stringWithFormat:@"%@",@"user_id"]: EMSDKGlobalInfo.userInfo.userID?:@"", [NSString stringWithFormat:@"%@",@"game_id"]: EMSDKGlobalInfo.gameInfo.gameID?:@""}];
    
}
+ (void)zwp01_finishcdnTask{
    ADJEvent *event = [ADJEvent eventWithEventToken:EMSDKGlobalInfo.adjustConfig.zwp01_eventTokenfinishcdnTask];
    [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:EMSDKGlobalInfo.userInfo.userID?:@""];
    [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"game_id"] value:EMSDKGlobalInfo.gameInfo.gameID?:@""];
    [Adjust trackEvent:event];

    [FIRAnalytics logEventWithName:[NSString stringWithFormat:@"%@",@"cdn加载结束"] parameters:@{ [NSString stringWithFormat:@"%@",@"user_id"]: EMSDKGlobalInfo.userInfo.userID?:@"", [NSString stringWithFormat:@"%@",@"game_id"]: EMSDKGlobalInfo.gameInfo.gameID?:@""}];
}
+ (void)zwp01_beginNoviceTask{
    
    ADJEvent *event = [ADJEvent eventWithEventToken:EMSDKGlobalInfo.adjustConfig.zwp01_eventTokenbeginNoviceTask];
    [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:EMSDKGlobalInfo.userInfo.userID?:@""];
    [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"game_id"] value:EMSDKGlobalInfo.gameInfo.gameID?:@""];
    [Adjust trackEvent:event];

    [FIRAnalytics logEventWithName:[NSString stringWithFormat:@"%@",@"新手引导开始"] parameters:@{ [NSString stringWithFormat:@"%@",@"user_id"]: EMSDKGlobalInfo.userInfo.userID?:@"", [NSString stringWithFormat:@"%@",@"game_id"]: EMSDKGlobalInfo.gameInfo.gameID?:@""}];
    
    
}
//

+ (void)zwp01_showSuspension{
    [[ZhenwupShortcut_View em14_SharedView] em14_HandleTapAction1];
}






+ (void)zwp01_setShortCutHidden:(BOOL)hidden {
    EM_RunInMainQueue(^{
        if (EMSDKGlobalInfo.em14_sdkFlag & EM_SDKFlagShortcut) {
            [ZhenwupShortcut_View em14_SharedView].hidden = hidden;
        } else {
            [ZhenwupShortcut_View em14_SharedView].hidden = YES;
        }
    });
}

+ (void)em_obtainPresentWithGameId:(NSString *)em11_gameId em14_roleId:(NSString *)em14_roleId{
    
    if (EMSDKGlobalInfo.userInfo.isBindMobile) {
        if (EMSDKAPI.em_tiePresent) {
            
        }
        else
        {
            //走请求绑定礼包
            [MBProgressHUD em14_ShowLoadingHUD];
            [[ZhenwupLogin_Server new] lhxy_tiePresentWithGameId:em11_gameId em14_roleId:em14_roleId Request:^(ZhenwupResponseObject_Entity * _Nonnull result) {
                
                [MBProgressHUD em14_DismissLoadingHUD];
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
    }
    else
    {
        //走绑定手机号
        [ZhenwupSDKMainView_Controller em18_showBindTelVWithGameId:em11_gameId em14_roleId:em14_roleId];
    }
}

+ (void)zwp01_firebaseEventWithName:(NSString *)name parameters:(nullable NSDictionary<NSString *, id> *)parameters {
    [FIRAnalytics logEventWithName:name parameters:parameters];
}

+ (void)zwp01_adjustEventWithEventToken:(NSString *)eventToken parameters:(nullable NSDictionary<NSString *, id> *)parameters {
    
    
    
    
    
    __block ADJEvent *event = [ADJEvent eventWithEventToken:eventToken];
    [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:EMSDKGlobalInfo.userInfo.userID?:@""];
    if (parameters && [parameters isKindOfClass:[NSDictionary class]] && parameters.count > 0) {
        [parameters enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [event addPartnerParameter:key value:obj];
        }];
    }
    [Adjust trackEvent:event];
}

+ (void)showLoginView {
    [ZhenwupSDKMainView_Controller em11_showLoginView];
    [self getFCMRegistrationToken];
}

+ (void)logout:(BOOL)showAlertView {
    if (showAlertView) {
        [GrossAlertCrlV showAlertTitle:MUUQYLocalizedString(@"EMKey_Logout_Text") message:MUUQYLocalizedString(@"EMKey_Logout_Alert_Text") actionBlock:^(NSString * _Nonnull btnTitle, NSInteger btnIndex) {
            if (btnIndex != 0) {
                [self em14_u_logoutRequest];
            }
        } cancelButtonTitle:MUUQYLocalizedString(@"EMKey_CancelButton_Text") otherButtonTitles:@[MUUQYLocalizedString(@"EMKey_ConfirmButton_Text")]];
    } else {
        [self em14_u_logoutRequest];
    }
}
+ (void)zwp01_delete:(BOOL)showAlertView{
    if (showAlertView) {
        [GrossAlertCrlV showAlertTitle:MUUQYLocalizedString(@"EMKey_deletet_Text ") message:MUUQYLocalizedString(@"EMKey_Logout_Alert_Text") actionBlock:^(NSString * _Nonnull btnTitle, NSInteger btnIndex) {
            if (btnIndex != 0) {
                [self em14_u_deleteRequest];
            }
        } cancelButtonTitle:MUUQYLocalizedString(@"EMKey_CancelButton_Text") otherButtonTitles:@[MUUQYLocalizedString(@"EMKey_ConfirmButton_Text")]];
    } else {
        [self em14_u_deleteRequest];
    }
}
+ (void)zwp01_enterGameIntoServerId:(NSString *)serverId serverName:(NSString *)serverName withRoleId:(NSString *)roleId roleName:(NSString *)roleName andRoleLevel:(NSUInteger)roleLevel {
    if (EMSDKGlobalInfo.isEnterGame) return;
    EMSDKGlobalInfo.isEnterGame = YES;
    
    EMSDKGlobalInfo.gameInfo.cpServerID = serverId;
    EMSDKGlobalInfo.gameInfo.cpServerName = serverName;
    EMSDKGlobalInfo.gameInfo.cpRoleID = roleId;
    EMSDKGlobalInfo.gameInfo.cpRoleName = roleName;
    EMSDKGlobalInfo.gameInfo.cpRoleLevel = roleLevel;
    
    [MBProgressHUD em14_ShowLoadingHUD];
    [[ZhenwupLogin_Server new] lhxy_EnterGame:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD em14_DismissLoadingHUD];
        if (result.em14_responseCode == EM_ResponseCodeSuccess) {
            if (EMSDKGlobalInfo.em14_sdkFlag & EM_SDKFlagHeart) {
                [MYMGSDKHeart em14_startRefreshTokenTimer];
                [MYMGSDKHeart em14_startSDKHeartBeat];
            }
        } else {
            EMSDKGlobalInfo.isEnterGame = NO;
            [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
        }
    }];
}

+ (void)zwp01_updateAndCommitGameRoleLevel:(NSUInteger)level {
    [[ZhenwupAccount_Server new] em11_UpdateAndCommitGameRoleLevel:level responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull result) {}];
}

+ (BOOL)zwp01_clearAllHistoryAccounts {
    return [ZhenwupLocalData_Server em14_removeAllLoginedUserHistory];
}

+ (void)getFCMRegistrationToken {
    
    [[FIRMessaging messaging] tokenWithCompletion:^(NSString *token, NSError *error) {
      if (error != nil) {
        
      } else {
        
      }
    }];
}

+ (void)zwp01_getPurchaseProduces {
    [[ZhenwupInAppPurchase_Manager em11_SharedManager] em11_getPurchaseProduces:NO];
}

+ (void)zwp01_startPurchaseProduceOrder:(ZhenwupCPPurchaseOrder_Entity *)purchaseOrder {
    EM_RunInMainQueue(^{
        [[ZhenwupInAppPurchase_Manager em11_SharedManager] em11_startPurchaseProduceOrder:[ZhenwupPurchaseProduceOrder_Entity initWithCPPurchaseOrder:purchaseOrder]];
    });
}






+ (void)zwp01_sdkRequestPath:(NSString *)path parameters:(NSDictionary *)parameters responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    [[ZhenwupRemoteData_Server new] em14_RequestPath:path parameters:parameters responseBlock:responseBlock];
}


+ (void)em14_u_logoutRequest {
    [MBProgressHUD em14_ShowLoadingHUD];
    [[ZhenwupLogin_Server new] lhxy_Logout:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD em14_DismissLoadingHUD];
        if (result.em14_responseCode == EM_ResponseCodeSuccess) {
            [MBProgressHUD em14_showSuccess_Toast:result.em14_responeMsg];
            
            [self em14_u_clearUselessInfo];
        } else {
            [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
        }
    }];
}

+ (void)em14_u_deleteRequest {
    [MBProgressHUD em14_ShowLoadingHUD];
    

    
    [[ZhenwupLogin_Server new] lhxy_Delte:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD em14_DismissLoadingHUD];
        if (result.em14_responseCode == EM_ResponseCodeSuccess) {
            [MBProgressHUD em14_showSuccess_Toast:result.em14_responeMsg];
          
            [self em14_u_clearUselessInfo];
        } else {
            [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
        }
    }];
}


+ (void)em14_u_clearUselessInfo {
    EMSDKGlobalInfo.isEnterGame = NO;
    
    [ZhenwupShortcut_View em14_DismissShort];
    [EMSDKGlobalInfo clearUselessInfo];
    [MYMGSDKHeart em14_stopRefreshTokenTimer];
    [MYMGSDKHeart em14_stopSDKHeartBeat];
}

- (void)zwp01_HandleLogTapAction:(UITapGestureRecognizer *)recognizer {
    [ZhenwupOpenAPI zwp01_openDevLog:YES];
    
    [MBProgressHUD em14_showSuccess_Toast:[NSString stringWithFormat:@"%@",@"打开SDK日志"]];
}
+(void)zwp01_u_pay{
    
    
    
    
    NSDictionary *params = @{[NSString stringWithFormat:@"%@",@"game_id"] : EMSDKGlobalInfo.gameInfo.gameID?:@"", [NSString stringWithFormat:@"%@",@"userid"]:[EMSDKGlobalInfo.userInfo.userID hash_md5]?:@"", [NSString stringWithFormat:@"%@",@"token"]: [EMSDKGlobalInfo.userInfo.token hash_base64Encode]?:@""};
    BOOL em11_GvCheck = EMSDKGlobalInfo.em11_GvCheck;
    
    
    
    NSString *url = [ZhenwupRemoteData_Server em14_BuildFinalUrl:em11_GvCheck?MYMGUrlConfig.em14_httpsdomain.em14_returnupsBaseUrl:MYMGUrlConfig.em14_httpsdomain.em14_backupsBaseUrl WithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpAutoLoginPath andParams:params];

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}
@end
