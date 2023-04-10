
#import "ZhenwupAccount_Server.h"
#import "NSString+GrossExtension.h"
#import "UIDevice+GrossExtension.h"
#import "ZhenwupOpenAPI.h"
#import "ZhenwupLocalData_Server.h"
#import <Adjust/Adjust.h>
#import <Firebase/Firebase.h>

@implementation ZhenwupAccount_Server

- (void)em11_RegisterAccountWithUserName:(NSString *)userName password:(NSString *)password verifyCode:(NSString *)verifyCode regType:(NSString *)regType responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:userName?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyUsername]];
    [params setObject:[[password hash_md5] uppercaseString]?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyPassword]];
    [params setObject:verifyCode?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyAccountCode]];
    [params setObject:regType?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyRegType]];
    
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpNormalRegPath];
    [self em14_PostRequestURL:url parameters:params responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull em11_result) {
        em11_result.em14_responseType = EM_ResponseTypeRegister;
        if (em11_result.em14_responseCode == EM_ResponseCodeSuccess) {
            EMSDKGlobalInfo.userInfo.userName = userName;
            if ([regType isEqualToString:@"2"]) {
                EMSDKGlobalInfo.userInfo.password = em11_result.em14_responeResult[@"passwd"];
            }else{
                EMSDKGlobalInfo.userInfo.password = [[password hash_md5] uppercaseString];
            }
            
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

- (void)em11_findAccount:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpFindAccountsPath];
    [self em14_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

- (void)em11_SendFindAccountVerufy2Email:(NSString *)email responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:email?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyEamil]];
    
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpVerifyEmailPath];
    [self em14_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

- (void)em11_SendRegisterVerify2Email:(NSString *)email responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:email?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyEamil]];
    
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpSendRegVerifyCodePath];
    [self em14_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

- (void)em11_ResetPwdWithBindEmail:(NSString *)email verifyCode:(NSString *)verifyCode newPassword:(NSString *)newPassword responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:email?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyEamil]];
    [params setObject:verifyCode?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyAccountCode]];
    [params setObject:[[newPassword hash_md5] uppercaseString]?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyNewPwd]];
    
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpModifyPasswordPath];
    [self em14_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

- (void)em11_SendBindEmailVerifyCode2Email:(NSString *)email responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:email?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyEamil]];
    [params setObject:EMSDKGlobalInfo.userInfo.userID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyUId]];
    [params setObject:EMSDKGlobalInfo.userInfo.token?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyToken]];
    
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpBindVerifyCodePath];
    [self em14_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

- (void)em11_BindEmail:(NSString *)email withVerifyCode:(NSString *)verifyCode responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:email?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyEamil]];
    [params setObject:verifyCode?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyAccountCode]];
    [params setObject:EMSDKGlobalInfo.userInfo.userID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyUId]];
    [params setObject:EMSDKGlobalInfo.userInfo.token?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyToken]];
    
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpBindEmailPath];
    [self em14_PostRequestURL:url parameters:params responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull em11_result) {
        if (em11_result.em14_responseCode == EM_ResponseCodeSuccess) {
            EMSDKGlobalInfo.userInfo.isBind = YES;
            EMSDKGlobalInfo.userInfo.isBindEmail = YES;
            EMSDKGlobalInfo.userInfo.userName = email;
//            if (EMSDKGlobalInfo.userInfo.accountType == EM_AccountTypeGuest) {
//                EMSDKGlobalInfo.userInfo.accountType = EM_AccountTypeMuu;
//            }
            [ZhenwupLocalData_Server em14_saveLoginedUserInfo:EMSDKGlobalInfo.userInfo];
        }
        
        if (responseBlock) {
            responseBlock(em11_result);
        }
    }];
}

- (void)em11_UpdateAndCommitGameRoleLevel:(NSUInteger)level responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:EMSDKGlobalInfo.userInfo.userID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyUId]];
    [params setObject:EMSDKGlobalInfo.userInfo.token?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyToken]];
    [params setObject:EMSDKGlobalInfo.gameInfo.chServerID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyServiceID]];
    [params setObject:EMSDKGlobalInfo.gameInfo.chRoleID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyRoleID]];
    [params setObject:EMSDKGlobalInfo.gameInfo.cpRoleID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyCpRoleId]];
    [params setObject:EMSDKGlobalInfo.gameInfo.cpRoleName?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyCpRoleName]];
    [params setObject:@(level).stringValue forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyCpRoleLevel]];
    
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpCommitRoleLevelPath];
    [self em14_PostRequestURL:url parameters:params responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull em11_result) {
        if (responseBlock) {
            responseBlock(em11_result);
        }
        
        if (EMSDKAPI.delegate && [EMSDKAPI.delegate respondsToSelector:@selector(zwp01_commitGameRoleLevelFinished:)]) {
            [EMSDKAPI.delegate zwp01_commitGameRoleLevelFinished:em11_result];
        }
    }];
}

- (void)em11_GetUserInfo:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:EMSDKGlobalInfo.userInfo.userID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyUId]];
    [params setObject:EMSDKGlobalInfo.userInfo.token?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyToken]];
    
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpGetUserInfoPath];
    [self em14_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

- (void)em11_SendUpgradeVerifyCode2Email:(NSString *)email responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:email?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyEamil]];
    [params setObject:EMSDKGlobalInfo.userInfo.userID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyUId]];
    [params setObject:EMSDKGlobalInfo.userInfo.token?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyToken]];
    
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpSendUpgradeVerifyCodePath];
    [self em14_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

- (void)em11_UpgradeAccount:(NSString *)email withPassword:(NSString *)password andVerifyCode:(NSString *)verifyCode responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:email?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyEamil]];
    [params setObject:[[password hash_md5] uppercaseString]?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyPassword]];
    [params setObject:verifyCode?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyAccountCode]];
    [params setObject:EMSDKGlobalInfo.userInfo.userID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyUId]];
    [params setObject:EMSDKGlobalInfo.userInfo.token?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyToken]];
    
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpAccountUpgradePath];
    [self em14_PostRequestURL:url parameters:params responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull em11_result) {
        if (em11_result.em14_responseCode == EM_ResponseCodeSuccess) {
            EMSDKGlobalInfo.userInfo.isBind = YES;
            EMSDKGlobalInfo.userInfo.isBindEmail = YES;
            EMSDKGlobalInfo.userInfo.userName = email;
            EMSDKGlobalInfo.userInfo.password = [[password hash_md5] uppercaseString]?:@"";
            if (EMSDKGlobalInfo.userInfo.accountType == EM_AccountTypeGuest) {
                EMSDKGlobalInfo.userInfo.accountType = EM_AccountTypeMuu;
            }
            [ZhenwupLocalData_Server em14_saveLoginedUserInfo:EMSDKGlobalInfo.userInfo];
        }
        
        if (responseBlock) {
            responseBlock(em11_result);
        }
    }];
}

- (void)em11_ModifyPassword:(NSString *)password newPassword:(NSString *)newPassword reNewPassword:(NSString *)reNewPassword responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:[[password hash_md5] uppercaseString]?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyPassword]];
    [params setObject:[[newPassword hash_md5] uppercaseString]?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyNewPwd]];
    [params setObject:[[reNewPassword hash_md5] uppercaseString]?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyReNewPwd]];
    [params setObject:EMSDKGlobalInfo.userInfo.userID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyUId]];
    [params setObject:EMSDKGlobalInfo.userInfo.token?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyToken]];
    
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpModifyPwdPath];
    [self em14_PostRequestURL:url parameters:params responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull em11_result) {
        if (em11_result.em14_responseCode == EM_ResponseCodeSuccess) {
            EMSDKGlobalInfo.userInfo.password = [[newPassword hash_md5] uppercaseString];
            [ZhenwupLocalData_Server em14_saveLoginedUserInfo:EMSDKGlobalInfo.userInfo];
        }
        
        if (responseBlock) {
            responseBlock(em11_result);
        }
    }];
}

- (void)em11_GetAllPresent:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:EMSDKGlobalInfo.userInfo.userID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyUId]];
    [params setObject:EMSDKGlobalInfo.userInfo.token?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyToken]];
    
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpGetAllPresentInfoPath];
    [self em14_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

- (void)em11_GetPresent:(NSInteger)presentId responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@(presentId).stringValue forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyPresentId]];
    [params setObject:EMSDKGlobalInfo.userInfo.userID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyUId]];
    [params setObject:EMSDKGlobalInfo.userInfo.token?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyToken]];
    
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpGetPresentInfoPath];
    [self em14_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

- (void)em11_GetMyPresents:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:EMSDKGlobalInfo.userInfo.userID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyUId]];
    [params setObject:EMSDKGlobalInfo.userInfo.token?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyToken]];
    
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpMyPresentInfoPath];
    [self em14_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

- (void)em11_GetCustomerService:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:EMSDKGlobalInfo.userInfo.userID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyUId]];
    [params setObject:EMSDKGlobalInfo.userInfo.token?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyToken]];
    
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpServiceInfoPath];
    [self em14_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

//充值记录
- (void)em11_GetOrderListRequest:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:EMSDKGlobalInfo.userInfo.userID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyUId]];
    [params setObject:EMSDKGlobalInfo.userInfo.token?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyToken]];
    [params setObject:[NSString stringWithFormat:@"%.f", [[NSDate date] timeIntervalSince1970]] forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyTimeStamp]];
    [params setObject:EMSDKAPI.zwp01_SDKVersion forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeySDKVersion]];
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpChongDataPath];
    [self em14_PostRequestURL:url parameters:params responseBlock:responseBlock];
}
//最新资讯
- (void)em11_GetNewsListRequest:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:EMSDKGlobalInfo.userInfo.userID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyUId]];
    [params setObject:EMSDKGlobalInfo.userInfo.token?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyToken]];
    [params setObject:[NSString stringWithFormat:@"%.f", [[NSDate date] timeIntervalSince1970]] forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyTimeStamp]];
    [params setObject:EMSDKAPI.zwp01_SDKVersion forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeySDKVersion]];
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpNewsInfoPath];
    [self em14_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

//手机注册发送验证码
- (void)em11_SendBindTelCodeRequestWithem14_telNum:(NSString *)em14_telNum zwp01_telDist:(NSString *)zwp01_telDist em11_ut:(NSString *)em11_ut responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:zwp01_telDist?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyTelDist]];
    [params setObject:em14_telNum?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyTel]];
    [params setObject:[NSString stringWithFormat:@"%.f", [[NSDate date] timeIntervalSince1970]] forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyTimeStamp]];
    [params setObject:EMSDKAPI.zwp01_SDKVersion forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeySDKVersion]];
    [params setObject:em11_ut?:@"1" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyTelUt]];
    
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpRegMobileCode];
    [self em14_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

//登录后发送验证码
- (void)em11_SendUpgradeTelCodeRequestWithem14_telNum:(NSString *)em14_telNum zwp01_telDist:(NSString *)zwp01_telDist responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:EMSDKGlobalInfo.userInfo.userID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyUId]];
    [params setObject:zwp01_telDist?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyTelDist]];
    [params setObject:em14_telNum?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyTel]];
    [params setObject:[NSString stringWithFormat:@"%.f", [[NSDate date] timeIntervalSince1970]] forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyTimeStamp]];
    [params setObject:EMSDKAPI.zwp01_SDKVersion forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeySDKVersion]];
    [params setObject:EMSDKGlobalInfo.userInfo.token?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyToken]];
    
    
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpObtainTelCode];
    [self em14_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

//完成新手任务
- (void)em11_sendFinishNewTaskRequest:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:EMSDKGlobalInfo.userInfo.userID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyUId]];
    [params setObject:EMSDKGlobalInfo.userInfo.token?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyToken]];
    [params setObject:[NSString stringWithFormat:@"%.f", [[NSDate date] timeIntervalSince1970]] forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyTimeStamp]];
    [params setObject:EMSDKAPI.zwp01_SDKVersion?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeySDKVersion]];
    [params setObject:EMSDKAPI.gameInfo.gameID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyGameId]];
    [params setObject:EMSDKAPI.gameInfo.cpRoleID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyCpRoleId]];
    [params setObject:[UIDevice em_getDeviceNo]?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyDeviceNO]];
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpFinishNewTask];
    [self em14_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

//获取优惠券列表
- (void)khxl_obtainCouponLsitWithzwp01_lt:(NSInteger)zwp01_lt responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:EMSDKGlobalInfo.userInfo.userID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyUId]];
    [params setObject:EMSDKGlobalInfo.userInfo.token?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyToken]];
    //lt 1-所有可使用的 2 未领取的 3 已领取的
    [params setObject:@(zwp01_lt).stringValue forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyListType]];
    [params setObject:EMSDKAPI.gameInfo.gameID forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyGameId]];
    
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpObtainCouponList];
    [self em14_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

//保存优惠券
- (void)zwp01_saveCouponLsitWithem_couponId:(NSInteger)em_couponId responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:EMSDKGlobalInfo.userInfo.userID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyUId]];
    [params setObject:EMSDKGlobalInfo.userInfo.token?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyToken]];
    [params setObject:EMSDKAPI.gameInfo.gameID forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyGameId]];
    [params setObject:@(em_couponId).stringValue forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyCouponId]];
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpSaveUserCoupon];
    [self em14_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

//获取任务列表
- (void)lhxy_getTaskLsitRequest:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:EMSDKGlobalInfo.userInfo.userID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyUId]];
    [params setObject:EMSDKGlobalInfo.userInfo.token?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyToken]];
    [params setObject:EMSDKAPI.gameInfo.gameID forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyGameId]];
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpTaskList];
    [self em14_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

//币明细
- (void)zwp01_getKionDetailRequest:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:EMSDKGlobalInfo.userInfo.userID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyUId]];
    [params setObject:EMSDKGlobalInfo.userInfo.token?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyToken]];
    [params setObject:EMSDKAPI.gameInfo.gameID forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyGameId]];
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpCoinDetail];
    [self em14_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

//手机注册
- (void)em11_RegisterAccountWithTel:(NSString *)tel password:(NSString *)password verifyCode:(NSString *)verifyCode zwp01_telDist:(NSString *)zwp01_telDist responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:tel?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyUsername]];
    [params setObject:[[password hash_md5] uppercaseString]?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyPassword]];
    [params setObject:verifyCode?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyAccountCode]];
    [params setObject:zwp01_telDist?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyTelDist]];
    
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpTelRegister];
    [self em14_PostRequestURL:url parameters:params responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull em11_result) {
        em11_result.em14_responseType = EM_ResponseTypeRegister;
        if (em11_result.em14_responseCode == EM_ResponseCodeSuccess) {
            EMSDKGlobalInfo.userInfo.userName = tel;
            EMSDKGlobalInfo.userInfo.password = [[password hash_md5] uppercaseString];
            EMSDKGlobalInfo.userInfo.isReg = YES;
            [EMSDKGlobalInfo em_parserTelInfoFromResponseResult:em11_result.em14_responeResult];
            
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
        }
        
        if (responseBlock) {
            responseBlock(em11_result);
        }
        
        if (EMSDKAPI.delegate && [EMSDKAPI.delegate respondsToSelector:@selector(zwp01_loginFinished:)]) {
            [EMSDKAPI.delegate zwp01_loginFinished:em11_result];
        }
    }];
}


//签到
- (void)lhxy_userSignRequest:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:EMSDKGlobalInfo.userInfo.userID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyUId]];
    [params setObject:EMSDKGlobalInfo.userInfo.token?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyToken]];
    [params setObject:EMSDKAPI.zwp01_SDKVersion forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeySDKVersion]];
    [params setObject:[NSString stringWithFormat:@"%.f", [[NSDate date] timeIntervalSince1970]] forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyTimeStamp]];
    
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpUserSign];
    [self em14_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

//获取角色
- (void)lhxy_getUserRoleRequest:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:EMSDKGlobalInfo.userInfo.userID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyUId]];
    [params setObject:EMSDKGlobalInfo.userInfo.token?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyToken]];
    [params setObject:EMSDKAPI.zwp01_SDKVersion forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeySDKVersion]];
    [params setObject:[NSString stringWithFormat:@"%.f", [[NSDate date] timeIntervalSince1970]] forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyTimeStamp]];
    
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpObtainUserRole];
    [self em14_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

//交换礼品？
- (void)lhxy_exchangePresentWithGameId:(NSString *)em11_gameId em14_roleId:(NSString *)em14_roleId Request:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:EMSDKAPI.gameInfo.gameID forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyGameId]];
    [params setObject:EMSDKGlobalInfo.userInfo.userID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyUId]];
    [params setObject:EMSDKGlobalInfo.userInfo.token?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyToken]];
    [params setObject:em14_roleId?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyCpRoleId]];
    [params setObject:em11_gameId?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyCpServiceID]];
    
    
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpChangePresent];
    [self em14_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

//手机绑定
- (void)em11_bindMobileCodeRequestWithem14_telNum:(NSString *)em14_telNum zwp01_telDist:(NSString *)zwp01_telDist verifyCode:(NSString *)verifyCode responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:EMSDKGlobalInfo.userInfo.userID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyUId]];
    [params setObject:zwp01_telDist?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyTelDist]];
    [params setObject:em14_telNum?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyTel]];
    [params setObject:[NSString stringWithFormat:@"%.f", [[NSDate date] timeIntervalSince1970]] forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyTimeStamp]];
    [params setObject:EMSDKAPI.zwp01_SDKVersion forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeySDKVersion]];
    [params setObject:verifyCode?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyAccountCode]];
    [params setObject:EMSDKGlobalInfo.userInfo.token?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyToken]];
    
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpRegBindTel];
    [self em14_PostRequestURL:url parameters:params responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull em11_result) {
        if (em11_result.em14_responseCode == EM_ResponseCodeSuccess) {
            EMSDKGlobalInfo.userInfo.isBind = YES;
            EMSDKGlobalInfo.userInfo.isBindMobile = YES;
//            EMSDKGlobalInfo.userInfo.userName = em14_telNum;
            if (EMSDKGlobalInfo.userInfo.accountType == EM_AccountTypeGuest) {
                EMSDKGlobalInfo.userInfo.accountType = EM_AccountTypeMuu;
            }
            [ZhenwupLocalData_Server em14_saveLoginedUserInfo:EMSDKGlobalInfo.userInfo];
        }
        
        if (responseBlock) {
            responseBlock(em11_result);
        }
    }];
}

//修改手机密码
- (void)em11_ResetPwdWithBindTel:(NSString *)tel verifyCode:(NSString *)verifyCode newPassword:(NSString *)newPassword em11_ut:(NSString *)em11_ut zwp01_telDist:(NSString *)zwp01_telDist  responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:tel?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyTel]];
    [params setObject:[NSString stringWithFormat:@"%.f", [[NSDate date] timeIntervalSince1970]] forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyTimeStamp]];
    [params setObject:verifyCode?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyAccountCode]];
    [params setObject:EMSDKAPI.zwp01_SDKVersion forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeySDKVersion]];
    [params setObject:[[newPassword hash_md5] uppercaseString]?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyNewPwd]];
    [params setObject:em11_ut?:@"1" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyTelUt]];
    [params setObject:zwp01_telDist?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyTelDist]];
    
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpResetTelPwd];
    [self em14_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

//游客登录升级（手机号）
- (void)em11_UpgradeAccountWithTel:(NSString *)tel withPassword:(NSString *)password andVerifyCode:(NSString *)verifyCode zwp01_telDist:(NSString *)zwp01_telDist responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:tel?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyTel]];
    [params setObject:[[password hash_md5] uppercaseString]?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyPassword]];
    [params setObject:verifyCode?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyAccountCode]];
    [params setObject:EMSDKGlobalInfo.userInfo.userID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyUId]];
    [params setObject:EMSDKGlobalInfo.userInfo.token?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyToken]];
    [params setObject:zwp01_telDist?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyTelDist]];
    
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpAccTelUpgrade];
    [self em14_PostRequestURL:url parameters:params responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull em11_result) {
        if (em11_result.em14_responseCode == EM_ResponseCodeSuccess) {
            EMSDKGlobalInfo.userInfo.isBind = YES;
            EMSDKGlobalInfo.userInfo.isBindMobile = YES;
            EMSDKGlobalInfo.userInfo.userName = tel;
            EMSDKGlobalInfo.userInfo.password = [[password hash_md5] uppercaseString]?:@"";
            if (EMSDKGlobalInfo.userInfo.accountType == EM_AccountTypeGuest) {
                EMSDKGlobalInfo.userInfo.accountType = EM_AccountTypeTel;
            }
            [ZhenwupLocalData_Server em14_saveLoginedUserInfo:EMSDKGlobalInfo.userInfo];
        }
        
        if (responseBlock) {
            responseBlock(em11_result);
        }
    }];
}

- (void)em11_getGoodTypeRequest:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:EMSDKGlobalInfo.userInfo.userID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyUId]];
    [params setObject:EMSDKGlobalInfo.userInfo.token?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyToken]];
    [params setObject:[NSString stringWithFormat:@"%.f", [[NSDate date] timeIntervalSince1970]] forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyTimeStamp]];
    [params setObject:EMSDKAPI.zwp01_SDKVersion forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeySDKVersion]];
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpGetGood];
    [self em14_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

- (void)em11_getGoodListWithem_goodType:(NSString *)em_goodType responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:EMSDKGlobalInfo.userInfo.userID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyUId]];
    [params setObject:EMSDKGlobalInfo.userInfo.token?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyToken]];
    [params setObject:[NSString stringWithFormat:@"%.f", [[NSDate date] timeIntervalSince1970]] forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyTimeStamp]];
    [params setObject:EMSDKAPI.zwp01_SDKVersion forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeySDKVersion]];
    [params setObject:em_goodType?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyGoodType]];
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpGoodList];
    [self em14_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

- (void)em14_delAccResponseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:EMSDKGlobalInfo.userInfo.userID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyUId]];
    [params setObject:EMSDKGlobalInfo.userInfo.token?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyToken]];
    [params setObject:EMSDKAPI.gameInfo.gameID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyGameId]];
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpDelAcc];
    [self em14_PostRequestURL:url parameters:params responseBlock:responseBlock];
}


- (void)em14_dataWithevent:(NSString *)event  WithRe:(NSString *)re withResponseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];

    [params setObject:EMSDKAPI.gameInfo.gameID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyGameId]];
    [params setObject:event?:@"" forKey:@"en"];
    
    
//    [params setObject:[self getjson:re]?:@"" forKey:@"re"];
    [params setObject:re?:@"" forKey:@"re"];
    [params setObject:[UIDevice em_getDeviceNo]?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyDeviceNO]];

    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpDataup];
    
    if (EMSDKGlobalInfo.em14_sdkFlag & EM_SDKFlagData) {
        [self em14_PostRequestURL:url parameters:params responseBlock:responseBlock];
    }
    
  
}

-(NSString *)getjson:(NSDictionary *)dic{
    if (!dic) {
        return @"";
    }
    if([dic isEqual:@""]){
        return @"";
    }
    NSError *error = nil;
    NSData *jsonData = nil;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *keyString = nil;
        NSString *valueString = nil;
        if ([key isKindOfClass:[NSString class]]) {
            keyString = key;
        }else{
            keyString = [NSString stringWithFormat:@"%@",key];
        }

        if ([obj isKindOfClass:[NSString class]]) {
            valueString = obj;
        }else{
            valueString = [NSString stringWithFormat:@"%@",obj];
        }

        [dict setObject:valueString forKey:keyString];
    }];
    jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    if ([jsonData length] == 0 || error != nil) {
        return nil;
    }
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSLog(@"jsonString=====%@",jsonString);
    
    
    return jsonString;
}

@end
