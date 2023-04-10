
#import "ZhenwupRemoteData_Server.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZhenwupAccount_Server : ZhenwupRemoteData_Server

- (void)em11_RegisterAccountWithUserName:(NSString *)userName password:(NSString *)password verifyCode:(NSString *)verifyCode regType:(NSString *)regType responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;

- (void)em11_findAccount:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;

- (void)em11_SendFindAccountVerufy2Email:(NSString *)email responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;

- (void)em11_SendRegisterVerify2Email:(NSString *)email responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;

- (void)em11_ResetPwdWithBindEmail:(NSString *)email verifyCode:(NSString *)verifyCode newPassword:(NSString *)newPassword responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;

- (void)em11_SendBindEmailVerifyCode2Email:(NSString *)email responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;

- (void)em11_BindEmail:(NSString *)email withVerifyCode:(NSString *)verifyCode responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;

- (void)em11_UpdateAndCommitGameRoleLevel:(NSUInteger)level responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;

- (void)em11_GetUserInfo:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;

- (void)em11_SendUpgradeVerifyCode2Email:(NSString *)email responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;

- (void)em11_UpgradeAccount:(NSString *)email withPassword:(NSString *)password andVerifyCode:(NSString *)verifyCode responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;

- (void)em11_ModifyPassword:(NSString *)password newPassword:(NSString *)newPassword reNewPassword:(NSString *)reNewPassword responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;

- (void)em11_GetAllPresent:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;

- (void)em11_GetPresent:(NSInteger)presentId responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;

- (void)em11_GetMyPresents:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;

- (void)em11_GetCustomerService:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;

- (void)em11_GetOrderListRequest:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;
- (void)em11_GetNewsListRequest:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;
- (void)em11_SendBindTelCodeRequestWithem14_telNum:(NSString *)em14_telNum zwp01_telDist:(NSString *)zwp01_telDist em11_ut:(NSString *)em11_ut responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;
//账号升级发送验证码
- (void)em11_SendUpgradeTelCodeRequestWithem14_telNum:(NSString *)em14_telNum zwp01_telDist:(NSString *)zwp01_telDist responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;
//完成新手任务
- (void)em11_sendFinishNewTaskRequest:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;
//优惠券列表
- (void)khxl_obtainCouponLsitWithzwp01_lt:(NSInteger)zwp01_lt responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;
//保存优惠券
- (void)zwp01_saveCouponLsitWithem_couponId:(NSInteger)em_couponId responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;
//任务中心
- (void)lhxy_getTaskLsitRequest:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;
//币明细
- (void)zwp01_getKionDetailRequest:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;

//手机注册
- (void)em11_RegisterAccountWithTel:(NSString *)tel password:(NSString *)password verifyCode:(NSString *)verifyCode zwp01_telDist:(NSString *)zwp01_telDist responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;

//签到
- (void)lhxy_userSignRequest:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;

//获取角色
- (void)lhxy_getUserRoleRequest:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;

//交换礼品？
- (void)lhxy_exchangePresentWithGameId:(NSString *)em11_gameId em14_roleId:(NSString *)em14_roleId Request:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;

//手机绑定
- (void)em11_bindMobileCodeRequestWithem14_telNum:(NSString *)em14_telNum zwp01_telDist:(NSString *)zwp01_telDist verifyCode:(NSString *)verifyCode responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;

//修改手机密码
- (void)em11_ResetPwdWithBindTel:(NSString *)tel verifyCode:(NSString *)verifyCode newPassword:(NSString *)newPassword em11_ut:(NSString *)em11_ut zwp01_telDist:(NSString *)zwp01_telDist  responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;

- (void)em11_UpgradeAccountWithTel:(NSString *)tel withPassword:(NSString *)password andVerifyCode:(NSString *)verifyCode zwp01_telDist:(NSString *)zwp01_telDist responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;

- (void)em11_getGoodTypeRequest:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;

- (void)em11_getGoodListWithem_goodType:(NSString *)em_goodType responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;

- (void)em14_delAccResponseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;




- (void)em14_dataWithevent:(NSString *)event  WithRe:(NSString *)re withResponseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;

@end

NS_ASSUME_NONNULL_END
