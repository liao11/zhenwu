
#import "ZhenwupBaseWindow_View.h"

NS_ASSUME_NONNULL_BEGIN

@class ZhenwupAccount_View;
@protocol EM1_Account_ViewDelegate <NSObject>

- (void)em11_handleCloseAccount_Delegate:(ZhenwupAccount_View *)accountView;
- (void)em11_handleAccount_Delegate:(ZhenwupAccount_View *)accountView onClickBtn:(NSInteger)tag;
@end

@interface ZhenwupAccount_View : ZhenwupBaseWindow_View

@property (nonatomic, weak) id<EM1_Account_ViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
