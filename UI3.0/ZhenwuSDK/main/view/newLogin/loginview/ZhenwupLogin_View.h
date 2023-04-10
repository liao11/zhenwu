
#import "ZhenwupBaseWindow_View.h"

NS_ASSUME_NONNULL_BEGIN

@class ZhenwupLogin_View;

@protocol EM1_Login_ViewDelegate <NSObject>

- (void)em18_CloseLoginView:(ZhenwupLogin_View *)loginView loginSucess:(BOOL)success;
- (void)em18_RegisterAtLoginView:(ZhenwupLogin_View *)loginView;
- (void)em18_PushAccountLoginView:(ZhenwupLogin_View *)loginView;
- (void)em18_CloseAccountLoginView:(ZhenwupLogin_View *)accountLoginView loginSucess:(BOOL)success;
- (void)em18_ForgetPwdAtLoginView:(ZhenwupLogin_View *)accountLoginView;

@end
@interface ZhenwupLogin_View : ZhenwupBaseWindow_View

@property (nonatomic, weak) id<EM1_Login_ViewDelegate> delegate;

- (void)em11_HiddenHistoryTable;
@property(nonatomic,strong)NSString *enter;
@end

NS_ASSUME_NONNULL_END
