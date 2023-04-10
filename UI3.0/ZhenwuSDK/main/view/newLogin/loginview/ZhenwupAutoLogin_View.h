
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class ZhenwupAutoLogin_View,ZhenwupUserInfo_Entity;
@protocol EM1_AutoLogin_ViewDelegate <NSObject>

- (void)em18_FastAutLoginView:(ZhenwupAutoLogin_View *)autoLoginView loginSucess:(BOOL)success;

@end

@interface ZhenwupAutoLogin_View : UIView

@property (nonatomic, weak) id<EM1_AutoLogin_ViewDelegate> delegate;

- (void)em11_AutoLoginWithLastLoginUser:(ZhenwupUserInfo_Entity *)lastLoginUser;
@end

NS_ASSUME_NONNULL_END
