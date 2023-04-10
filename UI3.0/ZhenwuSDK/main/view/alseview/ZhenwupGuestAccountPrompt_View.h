
#import "ZhenwupBaseWindow_View.h"

NS_ASSUME_NONNULL_BEGIN

@class ZhenwupGuestAccountPrompt_View;
@protocol EM1_GuestAccountPrompt_ViewDelegate <NSObject>

- (void)em11_HandleClosePromptView:(ZhenwupGuestAccountPrompt_View *)promptView;
- (void)em11_HandleUpgrateFromPromptView:(ZhenwupGuestAccountPrompt_View *)promptView upgrateCompletion:(void(^)(void))completion;
@end

@interface ZhenwupGuestAccountPrompt_View : ZhenwupBaseWindow_View

@property (nonatomic, weak) id<EM1_GuestAccountPrompt_ViewDelegate> delegate;
@property (nonatomic, copy, nullable) void(^em11_HandleBeforeClosedView)(void);
@end

NS_ASSUME_NONNULL_END
