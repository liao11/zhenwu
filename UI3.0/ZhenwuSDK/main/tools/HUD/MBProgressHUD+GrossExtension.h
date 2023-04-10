
#import <MBProgressHUD/MBProgressHUD.h>
@interface MBProgressHUD (MYMGExtension)

+ (MBProgressHUD *)em14_ShowLoadingHUD;
+ (void)em14_DismissLoadingHUD;

+ (void)em14_showSuccess_Toast:(NSString *)message;
+ (void)em14_ShowWarning_Toast:(NSString *)message;
+ (void)em14_showError_Toast:(NSString *)message;

@end

