
#import <UIKit/UIKit.h>
#import "ZhenwupBaseTextField.h"
NS_ASSUME_NONNULL_BEGIN

@class PureHFieldV;
@protocol PureHFieldVDelegate <NSObject>
@optional

- (BOOL)em14_HorizontalInputTextFieldViewShouldReturn:(PureHFieldV *)inputView;
- (void)em14_HorizontalInputTextFieldViewTextDidChange:(PureHFieldV *)inputView;
@end

@interface PureHFieldV : UIView

@property (nonatomic, strong) UILabel *em14_TitleLab;
@property (nonatomic, strong) ZhenwupBaseTextField *em14_TextField;
@property (nonatomic, assign) CGFloat em14_FixedTitleWidth;
@property (nullable, nonatomic, weak) id<PureHFieldVDelegate> delegate;
- (void)em14_setRightView:(UIView *)rightView;
@end

NS_ASSUME_NONNULL_END
