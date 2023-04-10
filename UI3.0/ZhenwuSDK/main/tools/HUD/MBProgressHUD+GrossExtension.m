
#import "MBProgressHUD+GrossExtension.h"
#import "ZhenwupHelper_Utils.h"
#import "ZhenwupTheme_Utils.h"
#import "ZhenwupOpenAPI.h"
#import "ZhenwupToast_View.h"
#import "ZhenwupSDKGlobalInfo_Entity.h"

@implementation MBProgressHUD (MYMGExtension)

+ (MBProgressHUD *)em14_ShowLoadingHUD
{
    UIView *view = [EMSDKGlobalInfo em14_CurrentVC].view.window;
    if (!view || view == nil) {
        if (@available(iOS 13.0, *)) {
            view = [[UIApplication sharedApplication].windows lastObject];
        } else {
            view = [UIApplication sharedApplication].keyWindow;
            if (!view || view == nil) {
                view = [[UIApplication sharedApplication].windows lastObject];
            }
        }
    }
    if (!view || view == nil) {
        return nil;
    }
    
    UIImageView *loadingImageView = [[UIImageView alloc] initWithImage:[ZhenwupHelper_Utils imageName:@"zhenwuimloading"]];
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:[NSString stringWithFormat:@"%@",@"transform.rotation.z"]];
    rotationAnimation.toValue = @(-M_PI * 2);
    rotationAnimation.repeatCount = HUGE;
    rotationAnimation.duration = 2.0;
    [loadingImageView.layer addAnimation:rotationAnimation forKey:[NSString stringWithFormat:@"%@",@"KCBasicAnimation_Rotation_HUDLoadingView"]];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.customView = loadingImageView;
    hud.bezelView.transform = CGAffineTransformMakeScale(0.7, 0.7);
    hud.bezelView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.7f];
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    
    return hud;
}

+ (void)em14_DismissLoadingHUD {
    UIView *view = [[UIApplication sharedApplication].windows lastObject];
    if (@available(iOS 13.0, *)) {
    } else {
        UIView *view0 = [UIApplication sharedApplication].keyWindow;
        [self hideHUDForView:view0 animated:YES];
    }
    UIView *view1 = [EMSDKGlobalInfo em14_CurrentVC].view.window;
    [self hideHUDForView:view animated:YES];
    [self hideHUDForView:view1 animated:YES];
}
+ (void)em14_showSuccess_Toast:(NSString *)message {
    [ZhenwupToast_View em14_showSuccess:message];
}

+ (void)em14_ShowWarning_Toast:(NSString *)message {
    [ZhenwupToast_View em14_ShowWarning:message];
}

+ (void)em14_showError_Toast:(NSString *)message {
    [ZhenwupToast_View em14_showError:message];
}

@end
