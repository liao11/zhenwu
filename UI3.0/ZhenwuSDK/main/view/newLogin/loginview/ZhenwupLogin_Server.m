
#import "ZhenwupLogin_Server.h"
#import "ZhenwupLocalData_Server.h"
#import "NSString+GrossExtension.h"
#import "UIDevice+GrossExtension.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <Adjust/Adjust.h>
#import "EM_Define.h"
#import "ZhenwupHelper_Utils.h"
#import <Firebase/Firebase.h>

static NSUInteger deviceActiveFailureCount = 0;
static NSUInteger sdkInitFailureCount = 0;

@implementation ZhenwupLogin_Server

- (void)lhxy_InitSDK:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"1" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyRA]];
    [params setObject:[UIDevice em14_getCurrentDeviceNetworkingStates]?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyDeviceNetwork]];
    [params setObject:[UIDevice em14_getCurrentDeviceNetworkingStates]?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyDeviceModelProvider]];
    [params setObject:[UIDevice gainAppVersion]?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyAppVersion]];

    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpInitialPath];
    [self em14_PostRequestURL:url parameters:params responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull em11_result) {
        if (em11_result.em14_responseCode == EM_ResponseCodeNetworkError && sdkInitFailureCount < 6) {
            sdkInitFailureCount += 1;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self lhxy_InitSDK:responseBlock];
            });
        } else {
            MYMGLog(@"SDK初始化失败的次数 = %ld", (long)sdkInitFailureCount);
            sdkInitFailureCount = 0;
            em11_result.em14_responseType = EM_ResponseTypeSDKInital;
            
            if (responseBlock) {
                responseBlock(em11_result);
            }
            
            if (EMSDKAPI.delegate && [EMSDKAPI.delegate respondsToSelector:@selector(zwp01_initialSDKFinished:)]) {
                [EMSDKAPI.delegate zwp01_initialSDKFinished:em11_result];
            }
        }
    }];
}

- (void)lhxy_DeviceActivate:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:[UIDevice gainAppVersion]?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyAppVersion]];
    
    [self em14_SetDeviceInfosIntoParams:params];
    
    ADJEvent *event = [ADJEvent eventWithEventToken:@"8dbjkc"];//  激活
    [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"platform_id"] value:@"2"];
    [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"device_id"] value:[UIDevice em_getDeviceNo2]?:@""];
    NSString *ta_account_id=@"";
    NSString *ta_distinct_id=[UIDevice em_getDeviceNo];
    
    [Adjust addSessionCallbackParameter:@"platform_id" value:@"2"];
    [Adjust addSessionCallbackParameter:@"device_id" value:[UIDevice em_getDeviceNo2]?:@""];
    [Adjust addSessionCallbackParameter:@"ta_account_id" value:ta_account_id];
    [Adjust addSessionCallbackParameter:@"ta_distinct_id" value:ta_distinct_id];
    [Adjust trackEvent:event];
    
    
    
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpDeviceActivePath];
    [self em14_PostRequestURL:url parameters:params responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        if (result.em14_responseCode == EM_ResponseCodeNetworkError && deviceActiveFailureCount < 6) {
            deviceActiveFailureCount += 1;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self lhxy_DeviceActivate:responseBlock];
            });
        } else {
            MYMGLog(@"SDK设备激活失败的次数 = %ld", (long)deviceActiveFailureCount);
            deviceActiveFailureCount = 0;
            if (responseBlock) {
                responseBlock(result);
            }
        }
    }];
}

- (void)lhxy_DeviceActivate:(NSString *)username md5Password:(NSString *)password responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:username?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyUsername]];
    [params setObject:password?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyPassword]];
    [params setObject:@"1" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyPlaform]];
    [self em14_SetDeviceInfosIntoParams:params];
    
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpNormalLoginPath];
    [self em14_PostRequestURL:url parameters:params responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull em11_result) {
        em11_result.em14_responseType = EM_ResponseTypeNormalLogin;
        if (em11_result.em14_responseCode == EM_ResponseCodeSuccess) {
            EMSDKGlobalInfo.userInfo.userName = username;
            EMSDKGlobalInfo.userInfo.password = password;
            
            [EMSDKGlobalInfo em14_parserUserInfoFromResponseResult:em11_result.em14_responeResult];
            
            if ([em11_result.em14_responeResult[@"isReg"] boolValue]) {
                EMSDKGlobalInfo.userInfo.isReg = YES;
                ADJEvent *event = [ADJEvent eventWithEventToken:EMSDKGlobalInfo.adjustConfig.zwp01_eventTokenRegister];
                [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:EMSDKGlobalInfo.userInfo.userID?:@""];
                [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"注册来源"] value:[NSString stringWithFormat:@"%@",@"平台账户注册"]];
                NSString *ta_account_id=[NSString stringWithFormat:@"MUU%@",EMSDKGlobalInfo.userInfo.userID?:@""];
                NSString *ta_distinct_id=[UIDevice em_getDeviceNo];
                [Adjust addSessionCallbackParameter:@"userid" value:EMSDKGlobalInfo.userInfo.userID?:@""];
                [Adjust addSessionCallbackParameter:@"platform_id" value:@"2"];
                [Adjust addSessionCallbackParameter:@"device_id" value:[UIDevice em_getDeviceNo2]?:@""];
                [Adjust addSessionCallbackParameter:@"ta_account_id" value:ta_account_id];
                [Adjust addSessionCallbackParameter:@"ta_distinct_id" value:ta_distinct_id];
                
                [Adjust trackEvent:event];
                
                ADJEvent *event1 = [ADJEvent eventWithEventToken:EMSDKGlobalInfo.adjustConfig.zwp01_eventTokenAccRegister];
                [event1 addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:EMSDKGlobalInfo.userInfo.userID?:@""];
                [Adjust trackEvent:event1];
                
                ADJEvent *event2 = [ADJEvent eventWithEventToken:EMSDKGlobalInfo.adjustConfig.zwp01_eventTokenLogin];
                [event2 addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:EMSDKGlobalInfo.userInfo.userID?:@""];
                [event2 addPartnerParameter:[NSString stringWithFormat:@"%@",@"登录来源"] value:[NSString stringWithFormat:@"%@",@"账号注册成功后的登录"]];
                [Adjust trackEvent:event2];
                
                [FIRAnalytics logEventWithName:kFIREventSignUp parameters:@{ [NSString stringWithFormat:@"%@",@"注册来源"]: [NSString stringWithFormat:@"%@",@"平台账号注册"] }];
                [FIRAnalytics logEventWithName:kFIREventLogin parameters:@{ [NSString stringWithFormat:@"%@",@"登录来源"]: [NSString stringWithFormat:@"%@",@"平台账号登录"] }];
            }else{
                EMSDKGlobalInfo.userInfo.isReg = NO;
                ADJEvent *event = [ADJEvent eventWithEventToken:EMSDKGlobalInfo.adjustConfig.zwp01_eventTokenLogin];
                [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:EMSDKGlobalInfo.userInfo.userID?:@""];
                [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"登录来源"] value:[NSString stringWithFormat:@"%@",@"账号登录"]];
                [Adjust trackEvent:event];
                
                [FIRAnalytics logEventWithName:kFIREventLogin parameters:@{ [NSString stringWithFormat:@"%@",@"登录来源"]: [NSString stringWithFormat:@"%@",@"账号登录"] }];
            }
            
        }
        
        if (responseBlock) {
            responseBlock(em11_result);
        }
        
        if (EMSDKAPI.delegate && [EMSDKAPI.delegate respondsToSelector:@selector(zwp01_loginFinished:)]) {
            [EMSDKAPI.delegate zwp01_loginFinished:em11_result];
        }
    }];
}

- (void)lhxy_QuickLogin:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [self em14_SetDeviceInfosIntoParams:params];
    
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpQuickLoginPath];
    [self em14_PostRequestURL:url parameters:params responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull em11_result) {
        em11_result.em14_responseType = EM_ResponseTypeGuestLogin;
        
        if (em11_result.em14_responseCode == EM_ResponseCodeSuccess) {
            EMSDKGlobalInfo.userInfo.userName = [em11_result.em14_responeResult objectForKey:[NSString stringWithFormat:@"%@",@"username"]];
            EMSDKGlobalInfo.userInfo.password = [em11_result.em14_responeResult objectForKey:[NSString stringWithFormat:@"%@",@"passwd"]];
            EMSDKGlobalInfo.userInfo.isReg = [[em11_result.em14_responeResult objectForKey:[NSString stringWithFormat:@"%@",@"isReg"]] boolValue];
            [EMSDKGlobalInfo em14_parserUserInfoFromResponseResult:em11_result.em14_responeResult];
            
            if (EMSDKGlobalInfo.userInfo.isReg) {
                
                ADJEvent *event = [ADJEvent eventWithEventToken:EMSDKGlobalInfo.adjustConfig.zwp01_eventTokenRegister];
                [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:EMSDKGlobalInfo.userInfo.userID?:@""];
                [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"注册来源"] value:[NSString stringWithFormat:@"%@",@"快速登录注册"]];
                NSString *ta_account_id=[NSString stringWithFormat:@"MUU%@",EMSDKGlobalInfo.userInfo.userID?:@""];
                NSString *ta_distinct_id=[UIDevice em_getDeviceNo];
                [Adjust addSessionCallbackParameter:@"userid" value:EMSDKGlobalInfo.userInfo.userID?:@""];
                [Adjust addSessionCallbackParameter:@"platform_id" value:@"2"];
                [Adjust addSessionCallbackParameter:@"device_id" value:[UIDevice em_getDeviceNo2]?:@""];
                [Adjust addSessionCallbackParameter:@"ta_account_id" value:ta_account_id];
                [Adjust addSessionCallbackParameter:@"ta_distinct_id" value:ta_distinct_id];
                
                [Adjust trackEvent:event];
                
                ADJEvent *event1 = [ADJEvent eventWithEventToken:EMSDKGlobalInfo.adjustConfig.zwp01_eventTokenAccRegister];
                [event1 addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:EMSDKGlobalInfo.userInfo.userID?:@""];
                [Adjust trackEvent:event1];
                
                [FIRAnalytics logEventWithName:kFIREventSignUp parameters:@{ [NSString stringWithFormat:@"%@",@"注册来源"]: [NSString stringWithFormat:@"%@",@"快速登录注册"] }];
            }
            
            ADJEvent *event = [ADJEvent eventWithEventToken:EMSDKGlobalInfo.adjustConfig.zwp01_eventTokenLogin];
            [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:EMSDKGlobalInfo.userInfo.userID?:@""];
            [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"登录来源"] value:[NSString stringWithFormat:@"%@",@"快速登录"]];
            [Adjust trackEvent:event];
            
            [FIRAnalytics logEventWithName:kFIREventLogin parameters:@{ [NSString stringWithFormat:@"%@",@"登录来源"]: [NSString stringWithFormat:@"%@",@"快速登录"] }];
            
        } else {
            EMSDKGlobalInfo.userInfo.isReg = NO;
        }
        
        if (responseBlock) {
            responseBlock(em11_result);
        }
        
        if (EMSDKAPI.delegate && [EMSDKAPI.delegate respondsToSelector:@selector(zwp01_loginFinished:)]) {
            [EMSDKAPI.delegate zwp01_loginFinished:em11_result];
        }
    }];
}

- (void)lhxy_Logout:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:EMSDKGlobalInfo.userInfo.userID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyUId]];
    [params setObject:EMSDKGlobalInfo.userInfo.userName?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyUsername]];
    [params setObject:EMSDKGlobalInfo.userInfo.token?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyToken]];
    EMSDKGlobalInfo.lastWayLogin = false;
    EMSDKGlobalInfo.sdkIsLogin = NO;
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpUserLogoutPath];
    [self em14_PostRequestURL:url parameters:params responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull em11_result) {
        em11_result.em14_responseType = EM_ResponseTypeLoginOut;
        
        if (responseBlock) {
            responseBlock(em11_result);
        }
        
        if (EMSDKAPI.delegate && [EMSDKAPI.delegate respondsToSelector:@selector(zwp01_logoutFinished:)]) {
            [EMSDKAPI.delegate zwp01_logoutFinished:em11_result];
        }
    }];
}
- (void)lhxy_Delte:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:EMSDKGlobalInfo.userInfo.userID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyUId]];
    NSString * userID=EMSDKGlobalInfo.userInfo.userID?:@"";
    [params setObject:EMSDKGlobalInfo.userInfo.userName?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyUsername]];
    [params setObject:EMSDKGlobalInfo.userInfo.token?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyToken]];
    EMSDKGlobalInfo.lastWayLogin = false;
    EMSDKGlobalInfo.sdkIsLogin = NO;
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpDelAcc];
    [self em14_PostRequestURL:url parameters:params responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull em11_result) {
        em11_result.em14_responseType = EM_ResponseTypeDelete;
        if (em11_result.em14_responseCode == EM_ResponseCodeSuccess) {
            
            
            ZhenwupUserInfo_Entity *user = [[ZhenwupUserInfo_Entity alloc]init];
            user.userID=userID;
            [ZhenwupLocalData_Server em14_removeLoginedUserInfoFormHistory:user];
        }
        if (responseBlock) {
            
          
            responseBlock(em11_result);
        }
        
        if (EMSDKAPI.delegate && [EMSDKAPI.delegate respondsToSelector:@selector(zwp01_deleteFinished:)]) {
            [EMSDKAPI.delegate zwp01_deleteFinished:em11_result];
        }
    }];
}
- (void)lhxy_EnterGame:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:EMSDKGlobalInfo.userInfo.userID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyUId]];
    [params setObject:EMSDKGlobalInfo.userInfo.token?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyToken]];
    [params setObject:EMSDKGlobalInfo.gameInfo.cpServerID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyCpServiceID]];
    [params setObject:EMSDKGlobalInfo.gameInfo.cpServerName?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyCpServiceName]];
    [params setObject:EMSDKGlobalInfo.gameInfo.cpRoleID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyCpRoleId]];
    [params setObject:EMSDKGlobalInfo.gameInfo.cpRoleName?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyCpRoleName]];
    [params setObject:@(EMSDKGlobalInfo.gameInfo.cpRoleLevel).stringValue forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyCpRoleLevel]];
    
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpEnjoyGamePath];
    [self em14_PostRequestURL:url parameters:params responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull em11_result) {
        em11_result.em14_responseType = EM_ResponseTypeEnterGame;
        
        if (em11_result.em14_responseCode == EM_ResponseCodeSuccess) {
            EMSDKGlobalInfo.gameInfo.chRoleID = [em11_result.em14_responeResult objectForKey:[NSString stringWithFormat:@"%@",@"role_id"]];
            EMSDKGlobalInfo.gameInfo.sessionID = [em11_result.em14_responeResult objectForKey:[NSString stringWithFormat:@"%@",@"session_id"]];;
            EMSDKGlobalInfo.gameInfo.chServerID = [em11_result.em14_responeResult objectForKey:[NSString stringWithFormat:@"%@",@"server_id"]];
            
            if ([[em11_result.em14_responeResult objectForKey:@"isFirstRole"] boolValue]) {
                
                ADJEvent *event = [ADJEvent eventWithEventToken:EMSDKGlobalInfo.adjustConfig.zwp01_eventTokenCreateRoles];
                [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:EMSDKGlobalInfo.userInfo.userID?:@""];
                [Adjust trackEvent:event];
                
                [FIRAnalytics logEventWithName:@"创建角色" parameters:@{
                    [NSString stringWithFormat:@"%@",@"创建角色Id"]: EMSDKGlobalInfo.gameInfo.chRoleID?:@"",
                    [NSString stringWithFormat:@"%@",@"session_id"]: EMSDKGlobalInfo.gameInfo.sessionID?:@"",
                    [NSString stringWithFormat:@"%@",@"server_id"]: EMSDKGlobalInfo.gameInfo.chServerID?:@""
                }];
            }
        }
        
        if (responseBlock) {
            responseBlock(em11_result);
        }
        
        if (EMSDKAPI.delegate && [EMSDKAPI.delegate respondsToSelector:@selector(zwp01_enterGameFinished:)]) {
            [EMSDKAPI.delegate zwp01_enterGameFinished:em11_result];
        }
    }];
}

- (void)lhxy_FacebookLogin:(void(^)(void))showHubBlock responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    FBSDKLoginManager *fbLoginManager = [[FBSDKLoginManager alloc] init];
    [fbLoginManager logOut];
    [fbLoginManager logInWithPermissions:@[@"public_profile",@"email"] fromViewController:nil handler:^(FBSDKLoginManagerLoginResult * _Nullable result, NSError * _Nullable error) {
        MYMGLog(@"facebook账号登录 result.grantedPermissions = %@, error = %@",result.grantedPermissions, error);
        
        ZhenwupResponseObject_Entity *responseObj = [[ZhenwupResponseObject_Entity alloc] init];
        responseObj.em14_responseType = EM_ResponseTypeFacebookLogin;
        if (error) {
            responseObj.em14_responseCode = EM_ResponseCodeFacebookLoginFailure;
            responseObj.em14_responeMsg = MUUQYLocalizedString(@"EMKey_FBLoginError_Alert_Text");
            
            EM_RunInMainQueue(^{
                if (responseBlock) {
                    responseBlock(responseObj);
                }
                
                if (EMSDKAPI.delegate && [EMSDKAPI.delegate respondsToSelector:@selector(zwp01_loginFinished:)]) {
                    [EMSDKAPI.delegate zwp01_loginFinished:responseObj];
                }
            });
        } else if (result.isCancelled) {
            responseObj.em14_responseCode = EM_ResponseCodeFacebookLoginCancel;
            responseObj.em14_responeMsg = MUUQYLocalizedString(@"EMKey_FBLoginCancel_Alert_Text");
            
            EM_RunInMainQueue(^{
                if (responseBlock) {
                    responseBlock(responseObj);
                }
                
                if (EMSDKAPI.delegate && [EMSDKAPI.delegate respondsToSelector:@selector(zwp01_loginFinished:)]) {
                    [EMSDKAPI.delegate zwp01_loginFinished:responseObj];
                }
            });
        } else {
            EM_RunInMainQueue(^{
                if (showHubBlock) {
                    showHubBlock();
                }
            });
            [self em14_u_LoginWithFbToken:result.token responseBlock:responseBlock];
        }
    }];
}

- (void)lhxy_VerifySignInWithApple:(NSString *)userId email:(NSString *)email authorizationCode:(NSString *)authorizationCode identityToken:(NSString *)identityToken responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"3" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyThirdPlatform]];
    [params setObject:userId?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyThirdAccount]];
    [params setObject:email?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyEamil]];
    [params setObject:authorizationCode?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyAppleAuthorizationCode]];
    [params setObject:identityToken?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyAppleIdentityToken]];
    [params setObject:@"1" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyPlaform]];
    
    [self em14_SetDeviceInfosIntoParams:params];
    
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpVerifySignInWithAppleId];
    [self em14_PostRequestURL:url parameters:params responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull em11_result) {
        em11_result.em14_responseType = EM_ResponseTypeAppleLogin;
        
        if (em11_result.em14_responseCode == EM_ResponseCodeSuccess) {
            EMSDKGlobalInfo.userInfo.userName = [em11_result.em14_responeResult objectForKey:[NSString stringWithFormat:@"%@",@"username"]];
            EMSDKGlobalInfo.userInfo.password = [em11_result.em14_responeResult objectForKey:[NSString stringWithFormat:@"%@",@"passwd"]];
            EMSDKGlobalInfo.userInfo.isReg = [[em11_result.em14_responeResult objectForKey:[NSString stringWithFormat:@"%@",@"isReg"]] boolValue];
            [EMSDKGlobalInfo em14_parserUserInfoFromResponseResult:em11_result.em14_responeResult];
            
            if (EMSDKGlobalInfo.userInfo.isReg) {
                
                ADJEvent *event = [ADJEvent eventWithEventToken:EMSDKGlobalInfo.adjustConfig.zwp01_eventTokenRegister];
                [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:EMSDKGlobalInfo.userInfo.userID?:@""];
                [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"注册来源"] value:[NSString stringWithFormat:@"%@",@"苹果注册"]];
                NSString *ta_account_id=[NSString stringWithFormat:@"MUU%@",EMSDKGlobalInfo.userInfo.userID?:@""];
                NSString *ta_distinct_id=[UIDevice em_getDeviceNo];
                [Adjust addSessionCallbackParameter:@"userid" value:EMSDKGlobalInfo.userInfo.userID?:@""];
                [Adjust addSessionCallbackParameter:@"platform_id" value:@"2"];
                [Adjust addSessionCallbackParameter:@"device_id" value:[UIDevice em_getDeviceNo2]?:@""];
                [Adjust addSessionCallbackParameter:@"ta_account_id" value:ta_account_id];
                [Adjust addSessionCallbackParameter:@"ta_distinct_id" value:ta_distinct_id];
                [Adjust trackEvent:event];
                
                ADJEvent *event1 = [ADJEvent eventWithEventToken:EMSDKGlobalInfo.adjustConfig.zwp01_eventTokenAccRegister];
                [event1 addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:EMSDKGlobalInfo.userInfo.userID?:@""];
                [Adjust trackEvent:event1];
                
                [FIRAnalytics logEventWithName:kFIREventSignUp parameters:@{ [NSString stringWithFormat:@"%@",@"注册来源"]: [NSString stringWithFormat:@"%@",@"苹果账号注册"] }];
            }
            
            ADJEvent *event = [ADJEvent eventWithEventToken:EMSDKGlobalInfo.adjustConfig.zwp01_eventTokenLogin];
            [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:EMSDKGlobalInfo.userInfo.userID?:@""];
            [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"登录来源"] value:[NSString stringWithFormat:@"%@",@"苹果登录"]];
            [Adjust trackEvent:event];
            
            [FIRAnalytics logEventWithName:kFIREventLogin parameters:@{ [NSString stringWithFormat:@"%@",@"登录来源"]: [NSString stringWithFormat:@"%@",@"苹果登录"] }];
        } else {
            EMSDKGlobalInfo.userInfo.isReg = NO;
        }
        
        if (responseBlock) {
            responseBlock(em11_result);
        }
        
        if (EMSDKAPI.delegate && [EMSDKAPI.delegate respondsToSelector:@selector(zwp01_loginFinished:)]) {
            [EMSDKAPI.delegate zwp01_loginFinished:em11_result];
        }
    }];
}


- (void)em14_u_LoginWithFbToken:(FBSDKAccessToken *)fbToken responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:fbToken.userID parameters:@{} HTTPMethod:FBSDKHTTPMethodGET];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id fb_result, NSError *error) {
        if (error) {
            ZhenwupResponseObject_Entity *responseObj = [[ZhenwupResponseObject_Entity alloc] init];
            responseObj.em14_responseType = EM_ResponseTypeFacebookLogin;
            responseObj.em14_responeMsg = error.domain;
            responseObj.em14_responeResult = error.userInfo;
            responseObj.em14_responseCode = EM_ResponseCodeFacebookLoginFailure;
              
            EM_RunInMainQueue(^{
                if (responseBlock) {
                    responseBlock(responseObj);
                }
                
                if (EMSDKAPI.delegate && [EMSDKAPI.delegate respondsToSelector:@selector(zwp01_loginFinished:)]) {
                    [EMSDKAPI.delegate zwp01_loginFinished:responseObj];
                }
            });
        } else {
            [self em14_u_LoginWithThirdPlatform:@"1" account:fbToken.userID token:fbToken.tokenString responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull em11_result) {
                em11_result.em14_responseType = EM_ResponseTypeFacebookLogin;
                                    
                if (em11_result.em14_responseCode == EM_ResponseCodeSuccess) {
                    EMSDKGlobalInfo.userInfo.isReg = [[em11_result.em14_responeResult objectForKey:[NSString stringWithFormat:@"%@",@"isReg"]] boolValue];
                    EMSDKGlobalInfo.userInfo.userName = [em11_result.em14_responeResult objectForKey:[NSString stringWithFormat:@"%@",@"username"]];
                    EMSDKGlobalInfo.userInfo.password = [em11_result.em14_responeResult objectForKey:[NSString stringWithFormat:@"%@",@"passwd"]];
                    EMSDKGlobalInfo.userInfo.fbUserName = [fb_result objectForKey:[NSString stringWithFormat:@"%@",@"name"]];
                    [EMSDKGlobalInfo em14_parserUserInfoFromResponseResult:em11_result.em14_responeResult];
                    
                    if (EMSDKGlobalInfo.userInfo.isReg) {
                        
                        ADJEvent *event = [ADJEvent eventWithEventToken:EMSDKGlobalInfo.adjustConfig.zwp01_eventTokenRegister];
                        [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:EMSDKGlobalInfo.userInfo.userID?:@""];
                        [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"注册来源"] value:[NSString stringWithFormat:@"%@",@"Facebook注册"]];
                        NSString *ta_account_id=[NSString stringWithFormat:@"MUU%@",EMSDKGlobalInfo.userInfo.userID?:@""];
                        NSString *ta_distinct_id=[UIDevice em_getDeviceNo];
                        [Adjust addSessionCallbackParameter:@"userid" value:EMSDKGlobalInfo.userInfo.userID?:@""];
                        [Adjust addSessionCallbackParameter:@"platform_id" value:@"2"];
                        [Adjust addSessionCallbackParameter:@"device_id" value:[UIDevice em_getDeviceNo2]?:@""];
                        [Adjust addSessionCallbackParameter:@"ta_account_id" value:ta_account_id];
                        [Adjust addSessionCallbackParameter:@"ta_distinct_id" value:ta_distinct_id];
                        [Adjust trackEvent:event];
                        
                        ADJEvent *event1 = [ADJEvent eventWithEventToken:EMSDKGlobalInfo.adjustConfig.zwp01_eventTokenFBRegister];
                        [event1 addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:EMSDKGlobalInfo.userInfo.userID?:@""];
                        [Adjust trackEvent:event1];
                        
                        [FIRAnalytics logEventWithName:kFIREventSignUp parameters:@{ [NSString stringWithFormat:@"%@",@"注册来源"]: [NSString stringWithFormat:@"%@",@"FB账号注册"] }];
                    }
                    
                    ADJEvent *event = [ADJEvent eventWithEventToken:EMSDKGlobalInfo.adjustConfig.zwp01_eventTokenLogin];
                    [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:EMSDKGlobalInfo.userInfo.userID?:@""];
                    [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"登录来源"] value:[NSString stringWithFormat:@"%@",@"FB登录"]];
                    [Adjust trackEvent:event];
                    
                    [FIRAnalytics logEventWithName:kFIREventLogin parameters:@{ [NSString stringWithFormat:@"%@",@"登录来源"]: [NSString stringWithFormat:@"%@",@"FB账号登录"] }];
                } else {
                    EMSDKGlobalInfo.userInfo.isReg = NO;
                }
                    
                if (responseBlock) {
                    responseBlock(em11_result);
                }
                
                if (EMSDKAPI.delegate && [EMSDKAPI.delegate respondsToSelector:@selector(zwp01_loginFinished:)]) {
                    [EMSDKAPI.delegate zwp01_loginFinished:em11_result];
                }
            }];
        }
    }];
}

- (void)em14_u_LoginWithThirdPlatform:(NSString *)platform account:(NSString *)account token:(NSString *)token responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:platform?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyThirdPlatform]];
    [params setObject:account?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyThirdAccount]];
    [params setObject:token?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyAppleIdentityToken]];
    [params setObject:@"1" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyPlaform]];
    
    [self em14_SetDeviceInfosIntoParams:params];
    
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpThirdLoginPath];
    [self em14_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

//手机登录
- (void)lhxy_telLogin:(NSString *)username md5Password:(NSString *)password em14_telDist:(NSString *)em14_telDist responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:username?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyUsername]];
    [params setObject:password?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyPassword]];
    [params setObject:@"1" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyPlaform]];
    
    [params setObject:em14_telDist?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyTelDist]];
    
    [self em14_SetDeviceInfosIntoParams:params];
    
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpTelLogin];
    [self em14_PostRequestURL:url parameters:params responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull em11_result) {
        em11_result.em14_responseType = EM_ResponseTypeTelLogin;
        if (em11_result.em14_responseCode == EM_ResponseCodeSuccess) {
            EMSDKGlobalInfo.userInfo.userName = username;
            EMSDKGlobalInfo.userInfo.password = password;
            
            EMSDKGlobalInfo.lastWayLogin = YES;
            [EMSDKGlobalInfo em_parserTelInfoFromResponseResult:em11_result.em14_responeResult];
            
            if ([em11_result.em14_responeResult[@"isReg"] boolValue]) {
                EMSDKGlobalInfo.userInfo.isReg = YES;
                ADJEvent *event = [ADJEvent eventWithEventToken:EMSDKGlobalInfo.adjustConfig.zwp01_eventTokenRegister];
                [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:EMSDKGlobalInfo.userInfo.userID?:@""];
                [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"注册来源"] value:[NSString stringWithFormat:@"%@",@"平台账户注册"]];
                NSString *ta_account_id=[NSString stringWithFormat:@"MUU%@",EMSDKGlobalInfo.userInfo.userID?:@""];
                NSString *ta_distinct_id=[UIDevice em_getDeviceNo];
                [Adjust addSessionCallbackParameter:@"userid" value:EMSDKGlobalInfo.userInfo.userID?:@""];
                [Adjust addSessionCallbackParameter:@"platform_id" value:@"2"];
                [Adjust addSessionCallbackParameter:@"device_id" value:[UIDevice em_getDeviceNo2]?:@""];
                [Adjust addSessionCallbackParameter:@"ta_account_id" value:ta_account_id];
                [Adjust addSessionCallbackParameter:@"ta_distinct_id" value:ta_distinct_id];
                [Adjust trackEvent:event];
                
                ADJEvent *event1 = [ADJEvent eventWithEventToken:EMSDKGlobalInfo.adjustConfig.zwp01_eventTokenAccRegister];
                [event1 addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:EMSDKGlobalInfo.userInfo.userID?:@""];
                [Adjust trackEvent:event1];
                
                ADJEvent *event2 = [ADJEvent eventWithEventToken:EMSDKGlobalInfo.adjustConfig.zwp01_eventTokenLogin];
                [event2 addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:EMSDKGlobalInfo.userInfo.userID?:@""];
                [event2 addPartnerParameter:[NSString stringWithFormat:@"%@",@"登录来源"] value:[NSString stringWithFormat:@"%@",@"账号注册成功后的登录"]];
                [Adjust trackEvent:event2];
                
                [FIRAnalytics logEventWithName:kFIREventSignUp parameters:@{ [NSString stringWithFormat:@"%@",@"注册来源"]: [NSString stringWithFormat:@"%@",@"平台账号注册"] }];
                [FIRAnalytics logEventWithName:kFIREventLogin parameters:@{ [NSString stringWithFormat:@"%@",@"登录来源"]: [NSString stringWithFormat:@"%@",@"平台账号登录"] }];
            }else{
                EMSDKGlobalInfo.userInfo.isReg = NO;
                ADJEvent *event = [ADJEvent eventWithEventToken:EMSDKGlobalInfo.adjustConfig.zwp01_eventTokenLogin];
                [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:EMSDKGlobalInfo.userInfo.userID?:@""];
                [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"登录来源"] value:[NSString stringWithFormat:@"%@",@"账号登录"]];
                [Adjust trackEvent:event];
                
                [FIRAnalytics logEventWithName:kFIREventLogin parameters:@{ [NSString stringWithFormat:@"%@",@"登录来源"]: [NSString stringWithFormat:@"%@",@"账号登录"] }];
            }
        }
        
        if (responseBlock) {
            responseBlock(em11_result);
        }
        
        if (EMSDKAPI.delegate && [EMSDKAPI.delegate respondsToSelector:@selector(zwp01_loginFinished:)]) {
            [EMSDKAPI.delegate zwp01_loginFinished:em11_result];
        }
    }];
}

- (void)lhxy_tiePresentWithGameId:(NSString *)em11_gameId em14_roleId:(NSString *)em14_roleId Request:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:EMSDKAPI.gameInfo.gameID forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyGameId]];
    [params setObject:EMSDKGlobalInfo.userInfo.userID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyUId]];
    [params setObject:EMSDKGlobalInfo.userInfo.token?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyToken]];
    [params setObject:em14_roleId?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyCpRoleId]];
    [params setObject:em11_gameId?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyCpServiceID]];
    
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpTiePresent];
    [self em14_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

@end
