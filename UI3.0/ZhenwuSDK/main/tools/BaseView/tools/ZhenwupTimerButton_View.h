
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class ZhenwupTimerButton_View;
@protocol EM_TimerButton_ViewDelegate <NSObject>
@optional

- (BOOL)em14_ClickedTimerButtonView:(ZhenwupTimerButton_View *)view;
@end

@interface ZhenwupTimerButton_View : UIView

@property (nonatomic, assign) NSTimeInterval em14_TimeInterval;
@property (nonatomic, copy) NSString * em14_BtnTitle;
@property (nonatomic, strong) UIButton *em14_Button;
@property (nullable, nonatomic, weak) id<EM_TimerButton_ViewDelegate> delegate;

- (void)em14_ResetNormalSendStates;
@end

NS_ASSUME_NONNULL_END
