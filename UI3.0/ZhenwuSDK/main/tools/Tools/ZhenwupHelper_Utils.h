
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define MUUQYLocalizedString(key)  [ZhenwupHelper_Utils em14_getLocalFromDocAndKey:key]

NS_ASSUME_NONNULL_BEGIN

@interface ZhenwupHelper_Utils : NSObject

+ (NSBundle *)em14_resBundle:(Class)classtype;
    
+ (UIImage *)imageName:(NSString *)name;

+ (UIImage *)imageWithDataName:(NSString *)dataName;

+ (NSString *)em14_getLocalFromDocAndKey:(NSString *)key;

+ (UIImage *)em14_encodeImageView:(NSString *)filePath;

+ (NSString *)em14_normalDecodeString:(NSString *)em14_encodeString;

+ (NSString *)em14_decodeString:(NSString*)em14_encodeString em14_key:(NSString*)em14_key;

+ (NSDictionary *)em14_getWordParam;


@end

NS_ASSUME_NONNULL_END
