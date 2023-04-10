
#import <UIKit/UIKit.h>
#import "ZhenwupBaseTextField.h"
NS_ASSUME_NONNULL_BEGIN

@class ZhenwupVerifyInPutTextField_View;
@protocol EM_VerifyInputTextFieldDelegate <NSObject>
@optional

- (BOOL)em14_VerifyInputTextFieldViewShouldReturn:(ZhenwupVerifyInPutTextField_View *)inputView;
- (void)em14_VerifyInputTextFieldViewTextDidChange:(ZhenwupVerifyInPutTextField_View *)inputView;
- (BOOL)em14_HandleSendVerifyCode:(ZhenwupVerifyInPutTextField_View *)inputView;
@end

@interface ZhenwupVerifyInPutTextField_View : UIView

@property (nonatomic, strong) UIImageView *em14_fieldLeftIcon;
@property (nonatomic, strong) ZhenwupBaseTextField *em14_TextField;
@property (nullable, nonatomic, weak) id<EM_VerifyInputTextFieldDelegate> delegate;
- (void)em14_SetInputCornerRadius:(CGFloat)cornerRadius;
- (void)em14_ResetNormalSendStates;
@end

NS_ASSUME_NONNULL_END
