
#import <UIKit/UIKit.h>
#import "ZhenwupBaseTextField.h"
NS_ASSUME_NONNULL_BEGIN

@class KeenWireField;
@protocol KeenWireFieldDelegate <NSObject>
@optional

- (BOOL)em14_InputTextFieldViewShouldReturn:(KeenWireField *)inputView;
- (void)em14_InputTextFieldViewTextDidChange:(KeenWireField *)inputView;
@end

@interface KeenWireField : UIView

@property (nonatomic, assign) bool zwp01_tel;
@property (nonatomic, strong) UIButton *em_telBtn;
@property (nonatomic, strong) UIImageView *em14_fieldLeftIcon;
@property (nonatomic, strong) ZhenwupBaseTextField *em14_TextField;
@property (nullable, nonatomic, weak) id<KeenWireFieldDelegate> delegate;
- (void)em14_setRightView:(UIView *)rightView;

@end

NS_ASSUME_NONNULL_END
