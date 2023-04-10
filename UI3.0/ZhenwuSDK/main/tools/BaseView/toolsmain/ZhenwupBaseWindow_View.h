
#import <UIKit/UIKit.h>
#import "UIView+GrossExtension.h"
#import "MBProgressHUD+GrossExtension.h"
#import "ZhenwupTheme_Utils.h"
#import "ZhenwupHelper_Utils.h"
#import "ZhenwupAccount_Server.h"
NS_ASSUME_NONNULL_BEGIN

@interface ZhenwupBaseWindow_View : UIView

@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UILabel *em14_TitleLab;
@property (nonatomic, strong) UIImageView *bgview;
@property (nonatomic, strong) UIImageView *em14_TitleImgV;
@property (nonatomic, strong) UIButton *em14_BackBtn;
@property (nonatomic, strong) UIButton *em14_CloseBtn;
- (instancetype)initWithCurType:(NSString *)curType;

- (void)em14_ShowBackBtn:(BOOL)show;
- (void)em14_ShowCloseBtn:(BOOL)show;
- (void)em14_HandleClickedBackBtn:(id)sender;
- (void)em14_HandleClickedCloseBtn:(id)sender;
@end

NS_ASSUME_NONNULL_END
