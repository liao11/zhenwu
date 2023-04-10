
#import "ZhenwupTheme_Utils.h"

#define EM_HEXRGBA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]
#define EM_HEXRGB(rgbValue)    EM_HEXRGBA(rgbValue,1.0f)
#define EM_RGBA(r,g,b,a)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
#define EM_RGB(r,g,b)          EM_RGBA(r,g,b,1.0f)

@implementation ZhenwupTheme_Utils

+ (UIColor *)em14_colorWithHexString:(NSString *)hexString {
    return [self em14_colorWithHexString:hexString alpha:1.0f];
}

+ (UIColor *)em14_colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    hexString = [[hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([hexString length] < 6) return [UIColor clearColor];
    
    if ([hexString hasPrefix:@"0X"]) hexString = [hexString substringFromIndex:2];
    if ([hexString hasPrefix:@"#"]) hexString = [hexString substringFromIndex:1];
    if ([hexString length] != 6) return [UIColor clearColor];
    
    
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    unsigned int hexNumber;
    if (![scanner scanHexInt:&hexNumber]) return [UIColor clearColor];
    
    return [UIColor colorWithRed:((float)((hexNumber & 0xFF0000) >> 16))/255.0
                           green:((float)((hexNumber & 0xFF00) >> 8))/255.0
                            blue:((float)(hexNumber & 0xFF))/255.0
                           alpha:alpha];
}


+ (UIColor *)em_colors_BackgroundColor {
    return UIColor.whiteColor;
}
+ (UIColor *)em_colors_MaskInputColor {
    return [UIColor whiteColor];
}
+ (UIColor *)em_colors_LineColor {
    return EM_HEXRGB(0xE6E6E6);
}
+ (UIColor *)em_colors_ButtonColor {
//
//    return EM_RGB(26, 190, 251);
    return [self em14_colorWithHexString:@"#ff8765"];
}
+ (UIColor *)em_colors_DisableColor {
    return EM_RGB(177, 188, 193);
}

+ (UIColor *)em_colors_headBgColor {
    return EM_RGB(156, 255, 255);
}

+ (UIColor *)em_colors_faceColor {
    return EM_RGB(60, 90, 153);
}

+ (UIColor *)em_colors_yellowColor {
    return EM_RGB(255, 223, 97);
}

+ (UIColor *)em_colors_MainColor {
    return EM_HEXRGB(0x0599B9);
}
+ (UIColor *)em_colors_SecondaryColor {
    return EM_HEXRGB(0x373941);
}
+ (UIColor *)em_colors_OthersColor {
    return EM_HEXRGB(0xfc5371);
}
+ (UIColor *)em_colors_FBBlueColor {
    return EM_HEXRGB(0x2684ff);
}
+ (UIColor *)em_colors_brown{
    return [self em14_colorWithHexString:@"#664630"];
}
+ (UIColor *)em_colors_DarkColor {
    return [UIColor blackColor];
}
+ (UIColor *)em_colors_DarkGrayColor {
    return EM_HEXRGB(0xffffff);
}
+ (UIColor *)em_colors_GrayColor {
    return EM_HEXRGB(0xffffff);
}
+ (UIColor *)em_colors_LightGrayColor {
    return EM_HEXRGB(0xced1d5);
}
+ (UIColor *)em_colors_LightColor {
    return [UIColor blackColor];
}


+ (UIColor *)em_colors_Light1Color {
    return [UIColor lightGrayColor];
}
+ (UIColor *)khxl_textPlaceholderColor {
    return EM_RGB(192,192,192);
}

+ (UIColor *)khxl_goldColor {
    return EM_RGB(212,178,54);
}

+ (UIColor *)khxl_SmallGrayColor {
//    return [self em14_colorWithHexString:@"#666666"];
    return [self em14_colorWithHexString:@"#ffffff"];
}


+ (UIColor *)khxl_SmalltitleColor {
//    return [self em14_colorWithHexString:@"#666666"];
    return [self em14_colorWithHexString:@"#0599B9"];
}


+ (UIColor *)khxl_redColor {
    return [self em14_colorWithHexString:@"#FE0000"];
}


+ (UIFont *)em_colors_LargestFont {
    return [UIFont systemFontOfSize:18];
}
+ (UIFont *)em_colors_LargeFont {
    return [UIFont systemFontOfSize:14];
}
+ (UIFont *)em_colors_NormalFont {
    return [UIFont systemFontOfSize:14];
}
+ (UIFont *)em_colors_SmallFont {
    return [UIFont systemFontOfSize:12];
}
+ (UIFont *)em_colors_LeastFont {
    return [UIFont systemFontOfSize:9];
}

+ (UIFont *)khxl_FontSize13 {
    return [UIFont systemFontOfSize:13];
}

+ (UIFont *)khxl_FontSize35 {
    return [UIFont systemFontOfSize:35];
}

+ (UIFont *)khxl_FontSize17 {
    return [UIFont systemFontOfSize:17];
}

+ (UIFont *)khxl_FontSize10 {
    return [UIFont systemFontOfSize:10];
}



+ (CAGradientLayer *)em_colors_GradientOrange:(CGRect)frame {
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = frame;
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(0, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:239/255.0 blue:103/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:254/255.0 green:108/255.0 blue:69/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0),@(1.0)];
    return gl;
}

+ (CAGradientLayer *)em_colors_GradientBlue:(CGRect)frame {
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = frame;
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(0, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:0/255.0 blue:159/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:55/255.0 green:247/255.0 blue:232/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:94/255.0 green:159/255.0 blue:243/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0),@(0.0),@(1.0)];
    return gl;
}

@end
