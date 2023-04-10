
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (MYMGExtension)

- (BOOL)isEmpty;
- (NSString *)trim;

- (NSString *)urlEncoding;
- (NSString *)urlDecodedString;

+ (NSString *)uuid;

- (BOOL)validatePassword;
- (BOOL)validateEmail;
- (BOOL)isValidateMobile;
@end

@interface NSString (MYMGVersion)

+ (NSString *)appVersion;
+ (NSString *)appShortVersion;
+ (NSString *)appBundleIdentifier;
+ (NSString *)appDisplayName;
+ (NSString *)obtainChannel;
+ (NSString *)obtainSubChannel;
@end

@interface NSString (MYMGHashes)

- (NSString *)hash_md5;
- (NSString *)hash_base64Encode;

@end

NS_ASSUME_NONNULL_END
