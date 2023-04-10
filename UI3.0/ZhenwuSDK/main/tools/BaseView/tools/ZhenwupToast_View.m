
#import "ZhenwupToast_View.h"
#import "UIView+GrossExtension.h"
#import "ZhenwupTheme_Utils.h"
#import "ZhenwupHelper_Utils.h"
#import "ZhenwupWeakProxy_Utils.h"

@interface ZhenwupToast_View ()

@property (nonatomic, strong) UIImageView *em14_ToastImageView;
@property (nonatomic, strong) UILabel *em14_ToastLab;
@end

@implementation ZhenwupToast_View

+ (void)em14_showSuccess:(NSString *)message {
     [self em14_u_showToast:[NSString stringWithFormat:@"%@",@"zhenwuimsuccess"] message:message];
}

+ (void)em14_ShowWarning:(NSString *)message {
     [self em14_u_showToast:[NSString stringWithFormat:@"%@",@"zhenwuimwarn"] message:message];
}

+ (void)em14_showError:(NSString *)message {
    [self em14_u_showToast:[NSString stringWithFormat:@"%@",@"zhenwuimerror"] message:message];
}

+ (void)em14_u_showToast:(NSString *)icon message:(NSString *)message {
    UIView *topView = [[UIApplication sharedApplication].windows lastObject];
    ZhenwupToast_View *toastView = [[ZhenwupToast_View alloc] init];
    toastView.em14_ToastImageView.image = [ZhenwupHelper_Utils imageName:icon];
    toastView.em14_ToastLab.text = message;
    [topView addSubview:toastView];
    [topView bringSubviewToFront:toastView];
    [toastView em14_u_ShowToast];
}

- (void)dealloc {
    MYMGLog(@"%@ dealloc..", NSStringFromClass([self class]));
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self em14_SetupDefaultViews];
    }
    return self;
}

- (void)em14_SetupDefaultViews {
    CGFloat margin = 10.0f;
    CGFloat width = MIN([UIScreen mainScreen].bounds.size.width - margin*2, 500);
    self.frame = CGRectMake(margin, [[UIApplication sharedApplication] statusBarFrame].size.height, width, 30 + margin*2);
    self.backgroundColor = [ZhenwupTheme_Utils em_colors_BackgroundColor];
    self.layer.cornerRadius = 5.0;
    self.layer.masksToBounds = YES;
    
    
    self.em14_ToastImageView = [[UIImageView alloc] initWithFrame:CGRectMake(margin, (self.em_height-20.0)/2, 20, 20)];
    [self addSubview:self.em14_ToastImageView];
    
    self.em14_ToastLab = [[UILabel alloc] initWithFrame:CGRectMake(self.em14_ToastImageView.em_right+margin, margin, self.em_width- margin*2 - self.em14_ToastImageView.em_right, 30)];
    self.em14_ToastLab.font = [ZhenwupTheme_Utils em_colors_SmallFont];
    self.em14_ToastLab.textColor = [ZhenwupTheme_Utils em_colors_LightColor];
    self.em14_ToastLab.numberOfLines = 0;
    [self addSubview:self.em14_ToastLab];
    self.em_bottom = 0;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    self.em_width = MIN([UIScreen mainScreen].bounds.size.width - 20, 500);
    self.em_centerX = self.superview.em_width / 2;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self em14_u_DismissToast];
}


- (void)em14_u_ShowToast {
    self.em_bottom = 0;
    UIEdgeInsets safeAreaInsets = UIEdgeInsetsMake(20, 0, 0, 0);
    if (@available(iOS 11.0, *)) {
        UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
        safeAreaInsets = window.safeAreaInsets;
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.em_top = MAX(safeAreaInsets.top, 20);
    } completion:^(BOOL finished) {
        [self performSelector:@selector(em14_u_DismissToast) withObject:nil afterDelay:2.5];
    }];
}

- (void)em14_u_DismissToast {
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
