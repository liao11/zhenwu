
#import "ZhenwupBaseWindow_View.h"

NS_ASSUME_NONNULL_BEGIN

@class ZhenwupAccountLogin_View,ZhenwupResponseObject_Entity;
@protocol EM1_AccountLogin_ViewDelegate <NSObject>

- (void)em18_CloseAccountLoginView:(ZhenwupAccountLogin_View *)accountLoginView loginSucess:(BOOL)success;
- (void)em18_ForgetPwdAtLoginView:(ZhenwupAccountLogin_View *)accountLoginView;
@end

@interface ZhenwupAccountLogin_View : ZhenwupBaseWindow_View

@property (nonatomic, weak) id<EM1_AccountLogin_ViewDelegate> delegate;
- (void)em11_HiddenHistoryTable;
@end

NS_ASSUME_NONNULL_END
