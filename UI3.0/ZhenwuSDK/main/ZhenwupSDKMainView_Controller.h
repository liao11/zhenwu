
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZhenwupResponseObject_Entity;

@interface ZhenwupSDKMainView_Controller : UIView

+ (void)em11_showLoginView;
+ (void)em11_showAccountView;
+ (void)em11_showCustomerServiceView;
+ (void)em14_showRencentV;
+ (void)em11_logoutAction;
+ (void)em18_showModifyPwdV;
+ (void)em18_showPresentV;
+ (void)em14_showChongV;
+ (void)em_showTaskV;
+ (void)em14_showCouponV;
+ (void)em14_showConfirmV;
+ (void)em18_showUpgradVCompletion:(void(^)(void))completion;
+ (void)em18_showTieMailCompletion:(void(^)(void))completion;
+ (void)em11_showMyShopV;
+ (void)em14_showRencent2V;
+ (void)em_showMyAccV;
+ (void)em14_showPersonInfoV;
+ (void)em18_showBindTelCompletion:(void(^)(void))completion;
+ (void)em18_showBindTelVWithGameId:(NSString *)em11_gameId em14_roleId:(NSString *)em14_roleId;
- (void)em14_u_PushView:(UIView *)view fromView:(UIView *)parentView animated:(BOOL)animated;
@end

NS_ASSUME_NONNULL_END
