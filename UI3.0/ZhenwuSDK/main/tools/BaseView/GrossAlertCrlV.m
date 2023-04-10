
#import "GrossAlertCrlV.h"
#import "EM_Define.h"
#import <objc/runtime.h>

@implementation GrossAlertCrlV

- (void)dealloc {
    MYMGLog(@"%@ dealloc..",NSStringFromClass([self class]));
}

+ (UIAlertController *)showInfo:(NSString *)message
{
    return [self showAlertControllerWithTitle:[NSString stringWithFormat:@"%@",@"提示"]
                                      message:message
                               preferredStyle:UIAlertControllerStyleAlert
                                  actionBlock:nil
                            cancelButtonTitle:[NSString stringWithFormat:@"%@",@"确定"]
                            otherButtonTitles:nil];
}

+ (UIAlertController *)showAlert:(NSString *)message
{
    return [self showAlertControllerWithTitle:[NSString stringWithFormat:@"%@",@"警告"]
                                      message:message
                               preferredStyle:UIAlertControllerStyleAlert
                                  actionBlock:nil
                            cancelButtonTitle:[NSString stringWithFormat:@"%@",@"确定"]
                            otherButtonTitles:nil];
    
}

+ (UIAlertController *)showAlertTitle:(nullable NSString *)title
                              message:(nullable NSString *)message
                          actionBlock:(nullable void(^)(NSString *btnTitle, NSInteger btnIndex))actionBlock
                    cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                    otherButtonTitles:(nullable NSArray <NSString *> *)otherButtonTitles
{
    return [self showAlertControllerWithTitle:title
                                      message:message
                               preferredStyle:UIAlertControllerStyleAlert
                                  actionBlock:actionBlock
                            cancelButtonTitle:cancelButtonTitle
                            otherButtonTitles:otherButtonTitles];
}

+ (UIAlertController *)showAlertMessage:(nullable NSString *)message
                            actionBlock:(nullable void(^)(NSString *btnTitle, NSInteger btnIndex))actionBlock
                      cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                      otherButtonTitles:(nullable NSArray <NSString *> *)otherButtonTitles
{
    return [self showAlertControllerWithTitle:nil
                                      message:message
                               preferredStyle:UIAlertControllerStyleAlert
                                  actionBlock:actionBlock
                            cancelButtonTitle:cancelButtonTitle
                            otherButtonTitles:otherButtonTitles];
}

+ (UIAlertController *)showActionSheet:(nullable void(^)(NSString *btnTitle, NSInteger btnIndex))actionBlock
                     cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                     otherButtonTitles:(nullable NSArray <NSString *> *)otherButtonTitles
{
    return [self showActionSheet:actionBlock
               cancelButtonTitle:cancelButtonTitle
               otherButtonTitles:otherButtonTitles
               otherButtonColoer:nil];
}

+ (UIAlertController *)showActionSheet:(nullable void(^)(NSString *btnTitle, NSInteger btnIndex))actionBlock
                     cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                     otherButtonTitles:(nullable NSArray <NSString *> *)otherButtonTitles
                     otherButtonColoer:(nullable UIColor *)color
{
    return [self showAlertControllerWithTitle:nil
                                      message:nil
                               preferredStyle:UIAlertControllerStyleActionSheet
                                  actionBlock:actionBlock
                            cancelButtonTitle:cancelButtonTitle
                            otherButtonTitles:otherButtonTitles
                            otherButtonColoer:color];
}

+ (UIAlertController *)showAlertControllerWithTitle:(nullable NSString *)title
                                            message:(nullable NSString *)message
                                     preferredStyle:(UIAlertControllerStyle)preferredStyle
                                        actionBlock:(nullable void(^)(NSString *btnTitle, NSInteger btnIndex))actionBlock
                                  cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                                  otherButtonTitles:(nullable NSArray <NSString *> *)otherButtonTitles
{
    return [self showAlertControllerWithTitle:title
                                      message:message
                               preferredStyle:preferredStyle
                                  actionBlock:actionBlock
                            cancelButtonTitle:cancelButtonTitle
                            otherButtonTitles:otherButtonTitles
                            otherButtonColoer:nil];
}

+ (UIAlertController *)showAlertControllerWithTitle:(nullable NSString *)title
                                            message:(nullable NSString *)message
                                     preferredStyle:(UIAlertControllerStyle)preferredStyle
                                        actionBlock:(nullable void(^)(NSString *btnTitle, NSInteger btnIndex))actionBlock
                                  cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                                  otherButtonTitles:(nullable NSArray <NSString *> *)otherButtonTitles
                                  otherButtonColoer:(nullable UIColor *)color
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    
    if (cancelButtonTitle) {
        [alertController addAction:[UIAlertAction actionWithTitle:cancelButtonTitle
                                                            style:UIAlertActionStyleCancel
                                                          handler:^(UIAlertAction * _Nonnull action) {
                                                              if (actionBlock) {
                                                                  actionBlock(cancelButtonTitle, 0);
                                                              }
                                                          }]];
    }
    
    if (otherButtonTitles && otherButtonTitles.count > 0) {
        NSInteger index = 1;
        for (NSString *btnTitle in otherButtonTitles) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:btnTitle
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * _Nonnull action) {
                                                               if (actionBlock) {
                                                                   actionBlock(btnTitle, index);
                                                               }
                                                           }];
            if (color) {
                
                [action setValue:color forKey:[NSString stringWithFormat:@"%@",@"_titleTextColor"]];
            }
            
            [alertController addAction:action];
            index++;
        }
    }
    
    [[EMSDKGlobalInfo em14_CurrentVC] presentViewController:alertController animated:YES completion:nil];
    
    return alertController;
}

+ (UIAlertController *)showAttTitle:(nullable NSAttributedString *)attTitle
                         attMessage:(nullable NSAttributedString *)attMessage
                     preferredStyle:(UIAlertControllerStyle)preferredStyle
                        actionBlock:(nullable void(^)(NSInteger btnIndex))actionBlock
                  cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                  otherButtonTitles:(nullable NSArray <NSString *> *)otherButtonTitles
                        buttonColor:(nullable NSArray <UIColor *> *)buttonColor
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:preferredStyle];
    
    
    if (attTitle) {
        [alertController setValue:attTitle forKey:[NSString stringWithFormat:@"%@",@"attributedTitle"]];
    }
    
    
    if (attMessage) {
        [alertController setValue:attMessage forKey:[NSString stringWithFormat:@"%@",@"attributedMessage"]];
    }
    
    if (cancelButtonTitle) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle
                                                               style:UIAlertActionStyleCancel
                                                             handler:^(UIAlertAction * _Nonnull action) {
                                                                 if (actionBlock) {
                                                                     actionBlock(0);
                                                                 }
                                                             }];
        
        if (buttonColor && buttonColor.count > 0) {
            UIColor *color = buttonColor[0];
            [cancelAction setValue:color forKey:[NSString stringWithFormat:@"%@",@"_titleTextColor"]];
            
            
            
        }
        [alertController addAction:cancelAction];
    }
    
    if (otherButtonTitles && otherButtonTitles.count > 0) {
        NSInteger index = 1;
        for (NSString *btnTitle in otherButtonTitles) {
            UIAlertAction *action = [UIAlertAction actionWithTitle:btnTitle
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * _Nonnull action) {
                                                               if (actionBlock) {
                                                                   actionBlock(index);
                                                               }
                                                           }];
            
            if (buttonColor && buttonColor.count > index) {
                UIColor *color = buttonColor[index];
                [action setValue:color forKey:[NSString stringWithFormat:@"%@",@"_titleTextColor"]];
            }
            [alertController addAction:action];
            index++;
        }
    }
    
    [[EMSDKGlobalInfo em14_CurrentVC] presentViewController:alertController animated:YES completion:nil];
    
    return alertController;
}

@end
