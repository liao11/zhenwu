
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZhenwupVerifyCodeImage_View : UIView

@property (nonatomic, strong) NSString *em14_codeString;
@property (nonatomic, assign) BOOL isRotation;
@property (nonatomic, copy) void(^em14_ResultCodeBolck)(NSString *codeString);

- (void)em14_refreshCode;

@end

NS_ASSUME_NONNULL_END
