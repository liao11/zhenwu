
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GrossAlertCrlV : UIAlertController
+ (UIAlertController *)showAlertControllerWithTitle:(nullable NSString *)title
                                            message:(nullable NSString *)message
                                     preferredStyle:(UIAlertControllerStyle)preferredStyle
                                        actionBlock:(nullable void(^)(NSString *btnTitle, NSInteger btnIndex))actionBlock
                                  cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                                  otherButtonTitles:(nullable NSArray <NSString *> *)otherButtonTitles
                                  otherButtonColoer:(nullable UIColor *)color;
+ (UIAlertController *)showAttTitle:(nullable NSAttributedString *)attTitle
                         attMessage:(nullable NSAttributedString *)attMessage
                     preferredStyle:(UIAlertControllerStyle)preferredStyle
                        actionBlock:(nullable void(^)(NSInteger btnIndex))actionBlock
                  cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                  otherButtonTitles:(nullable NSArray <NSString *> *)otherButtonTitles
                        buttonColor:(nullable NSArray <UIColor *> *)buttonColor;
#pragma mark - Alert

+ (UIAlertController *)showInfo:(NSString *_Nullable)message;
+ (UIAlertController *)showAlert:(NSString *_Nullable)message;

+ (UIAlertController *)showAlertTitle:(nullable NSString *)title
                              message:(nullable NSString *)message
                          actionBlock:(nullable void(^)(NSString *btnTitle, NSInteger btnIndex))actionBlock
                    cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                    otherButtonTitles:(nullable NSArray <NSString *> *)otherButtonTitles;

+ (UIAlertController *)showAlertMessage:(nullable NSString *)message
                            actionBlock:(nullable void(^)(NSString *btnTitle, NSInteger btnIndex))actionBlock
                      cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                      otherButtonTitles:(nullable NSArray <NSString *> *)otherButtonTitles;

#pragma mark - ActionSheet
+ (UIAlertController *)showActionSheet:(nullable void(^)(NSString *btnTitle, NSInteger btnIndex))actionBlock
                     cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                     otherButtonTitles:(nullable NSArray <NSString *> *)otherButtonTitles;
+ (UIAlertController *)showActionSheet:(nullable void(^)(NSString *btnTitle, NSInteger btnIndex))actionBlock
                     cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                     otherButtonTitles:(nullable NSArray <NSString *> *)otherButtonTitles
                     otherButtonColoer:(nullable UIColor *)color;
@end

NS_ASSUME_NONNULL_END
