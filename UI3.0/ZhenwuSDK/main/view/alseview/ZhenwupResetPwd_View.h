
#import "ZhenwupBaseWindow_View.h"

NS_ASSUME_NONNULL_BEGIN

@class ZhenwupResetPwd_View;
@protocol EM1_ResetPwd_ViewDelegate <NSObject>

- (void)em11_onClickCloseResetPwdView_Delegate:(ZhenwupResetPwd_View *)resetPwdView isFromLogin:(BOOL)isFromLogin;
- (void)em11_resetPwdSuccess_Delegate:(ZhenwupResetPwd_View *)resetPwdView;
@end
@interface ZhenwupResetPwd_View : ZhenwupBaseWindow_View

@property (nonatomic, weak) id<EM1_ResetPwd_ViewDelegate> delegate;
@property (nonatomic, assign) BOOL isFromLogin;
@property(nonatomic,strong)NSString *enter;

@end

NS_ASSUME_NONNULL_END
