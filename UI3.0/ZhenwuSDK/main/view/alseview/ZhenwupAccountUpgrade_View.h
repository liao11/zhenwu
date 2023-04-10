
#import "ZhenwupBaseWindow_View.h"

NS_ASSUME_NONNULL_BEGIN

@class ZhenwupAccountUpgrade_View;
@protocol EM1_AccountUpgrade_ViewDelegate <NSObject>

- (void)em11_HandleDismissAccountUpgradeView_Delegate:(ZhenwupAccountUpgrade_View *)accountUpgradeView;
- (void)em11_HandlePopAccountUpgradeView_Delegate:(ZhenwupAccountUpgrade_View *)accountUpgradeView;
@end

@interface ZhenwupAccountUpgrade_View : ZhenwupBaseWindow_View

@property (nonatomic, weak) id<EM1_AccountUpgrade_ViewDelegate> delegate;
@property (nonatomic, copy, nullable) void(^em11_HandleBeforeClosedView)(void);
@end

NS_ASSUME_NONNULL_END
