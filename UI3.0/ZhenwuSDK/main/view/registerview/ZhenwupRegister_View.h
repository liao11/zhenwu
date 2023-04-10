
#import "ZhenwupBaseWindow_View.h"

NS_ASSUME_NONNULL_BEGIN

@class ZhenwupRegister_View;
@protocol EM1_RegisterViewDelegate <NSObject>

- (void)em11_HandlePopRegisterView:(ZhenwupRegister_View *)registerView;
- (void)em11_HandleDidRegistSuccess:(ZhenwupRegister_View *)registerView;

@end

@interface ZhenwupRegister_View : ZhenwupBaseWindow_View

@property (nonatomic, weak) id<EM1_RegisterViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
