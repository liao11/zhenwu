
#import "ZhenwupSDKHeart_Server.h"
#import "ZhenwupWeakProxy_Utils.h"
#import "ZhenwupOpenAPI.h"
#import "ZhenwupHelper_Utils.h"

@interface ZhenwupSDKHeart_Server ()
{
    NSTimer *em14_RefreshTokenTimer;
    NSTimer *em14_heartBeatTimer;
    NSDate  *em14_heartBeatStartDate;
}

@end

@implementation ZhenwupSDKHeart_Server

+ (instancetype)sharedInstance {
    static ZhenwupSDKHeart_Server* shareHeart = nil;
    static dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        shareHeart = [[self alloc] init];
    });
    return shareHeart;
}

- (void)dealloc {
    [self em14_stopSDKHeartBeat];
    [self em14_stopRefreshTokenTimer];
}

- (void)em14_startRefreshTokenTimer {
    [self em14_stopRefreshTokenTimer];
    
    em14_RefreshTokenTimer = [NSTimer scheduledTimerWithTimeInterval:5*60
                                                              target:[ZhenwupWeakProxy_Utils proxyWithTarget:self]
                                                            selector:@selector(em14_doRefreshTokenAction:)
                                                            userInfo:nil
                                                             repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:em14_RefreshTokenTimer forMode:NSRunLoopCommonModes];
    [em14_RefreshTokenTimer fire];
}

- (void)em14_stopRefreshTokenTimer {
    if (em14_RefreshTokenTimer != nil) {
        if (em14_RefreshTokenTimer.isValid) {
            [em14_RefreshTokenTimer invalidate];
        }
        em14_RefreshTokenTimer = nil;
    }
}
- (void)em14_startSDKHeartBeat {
    em14_heartBeatStartDate = [NSDate date];
    
    [self em14_startSDKHeartBeatWithTimeInterval:60];
}

- (void)em14_startSDKHeartBeatWithTimeInterval:(NSTimeInterval)heartBeatTi {
    [self em14_stopSDKHeartBeat];
    
    em14_heartBeatTimer = [NSTimer timerWithTimeInterval:heartBeatTi
                                                  target:[ZhenwupWeakProxy_Utils proxyWithTarget:self]
                                                selector:@selector(em14_doHeartBeatAction:)
                                                userInfo:nil
                                                 repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:em14_heartBeatTimer forMode:NSRunLoopCommonModes];
    [em14_heartBeatTimer fire];
}

- (void)em14_stopSDKHeartBeat {
    if (em14_heartBeatTimer != nil) {
        if (em14_heartBeatTimer.isValid) {
            [em14_heartBeatTimer invalidate];
        }
        em14_heartBeatTimer = nil;
    }
}

- (void)em14_doRefreshTokenAction:(NSTimer *)timer {
    MYMGLog(@"RefreshToken～ 间隔 = %f", timer.timeInterval);
    [self em14_RefreshToken:^(ZhenwupResponseObject_Entity * _Nonnull result) {}];
}

- (void)em14_doHeartBeatAction:(NSTimer *)timer {
    NSTimeInterval durationHeartBeat = [NSDate date].timeIntervalSince1970 - em14_heartBeatStartDate.timeIntervalSince1970;
    MYMGLog(@"心跳蹦～ 持续时间 = %f, 间隔 = %f", durationHeartBeat, timer.timeInterval);
    if (timer.timeInterval == 1*60 && ABS(durationHeartBeat) >= 5*60) {
        [self em14_startSDKHeartBeatWithTimeInterval:5*60];
    } else {
        [self em14_keepSDKHeartBeat:^(ZhenwupResponseObject_Entity *result) {}];
    }
}


- (void)em14_keepSDKHeartBeat:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:EMSDKGlobalInfo.userInfo.userID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyUId]];
    [params setObject:EMSDKGlobalInfo.userInfo.userName?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyUsername]];
    [params setObject:EMSDKGlobalInfo.userInfo.token?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyToken]];
    
    [params setObject:EMSDKGlobalInfo.gameInfo.sessionID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeySessionID]];
    [params setObject:EMSDKGlobalInfo.gameInfo.chServerID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyServiceID]];
    [params setObject:EMSDKGlobalInfo.gameInfo.chRoleID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyRoleID]];
    [params setObject:EMSDKGlobalInfo.gameInfo.cpRoleID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyRoleID]];
    [params setObject:EMSDKGlobalInfo.gameInfo.cpRoleName?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyCpRoleName]];
    [params setObject:@(EMSDKGlobalInfo.gameInfo.cpRoleLevel).stringValue forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyCpRoleLevel]];
    
    [self em14_SetDeviceInfosIntoParams:params];

    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpHeartbeatPath];
    [self em14_PostRequestURL:url parameters:params responseBlock:responseBlock];
}

@end
