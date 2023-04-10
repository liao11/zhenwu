
#import "ZhenwupBaseWindow_View.h"

NS_ASSUME_NONNULL_BEGIN

@class ZhenwupModifyPwd_View;
@protocol EM1_ModifyPwd_ViewDelegate <NSObject>

- (void)em11_HandleCloseModifyPwdView_Delegate:(ZhenwupModifyPwd_View *)modifyPwdView;
@end

@interface ZhenwupModifyPwd_View : ZhenwupBaseWindow_View

@property (nonatomic, weak) id<EM1_ModifyPwd_ViewDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
