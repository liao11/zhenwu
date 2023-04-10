
#import "ZhenwupRemoteData_Server.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZhenwupLogin_Server : ZhenwupRemoteData_Server

- (void)lhxy_InitSDK:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;

- (void)lhxy_DeviceActivate:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;

- (void)lhxy_DeviceActivate:(NSString *)username md5Password:(NSString *)password responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;

- (void)lhxy_QuickLogin:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;

- (void)lhxy_FacebookLogin:(void(^)(void))showHubBlock responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;

- (void)lhxy_VerifySignInWithApple:(NSString *)userId email:(NSString *)email authorizationCode:(NSString *)authorizationCode identityToken:(NSString *)identityToken responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;

- (void)lhxy_Logout:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;
- (void)lhxy_Delte:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;

- (void)lhxy_EnterGame:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;

//手机登录
- (void)lhxy_telLogin:(NSString *)username md5Password:(NSString *)password em14_telDist:(NSString *)em14_telDist responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;

- (void)lhxy_tiePresentWithGameId:(NSString *)em11_gameId em14_roleId:(NSString *)em14_roleId Request:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;

@end

NS_ASSUME_NONNULL_END
