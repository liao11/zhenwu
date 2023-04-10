
#import "NSString+GrossExtension.h"
#import <CommonCrypto/CommonDigest.h>
#import <GTMBase64/GTMBase64.h>

@implementation NSString (MYMGExtension)

- (BOOL)isEmpty {
    return !self || nil == self || [self isKindOfClass:[NSNull class]]
    || 0 == [[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length];
}

- (NSString *)trim {
    return  [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)urlEncoding {
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

- (NSString *)urlDecodedString {
    return [self stringByRemovingPercentEncoding];
}

+ (NSString *)uuid {
    return [NSUUID UUID].UUIDString;
}

- (BOOL)validatePassword {
    NSString * regex = @"^([a-zA-Z]|[a-zA-Z0-9_]|[0-9]){6,20}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:self];
}

- (BOOL)validateEmail {
    if (self.length <= 0) {
        return NO;
    }
    NSString *emailRegex = @"[\\w-]+(\\.[\\w-]+)*@[\\w-]+(\\.[\\w-]+)+";
    NSPredicate *emailResult = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailResult evaluateWithObject:self];
}

- (BOOL)isValidateMobile {
    NSString *phoneRegex = @"^\\d{10}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    return [phoneTest evaluateWithObject:self];
}

@end

@implementation NSString (MYMGVersion)

+ (NSString *)appVersion {
    return [[NSBundle mainBundle].infoDictionary objectForKey:[NSString stringWithFormat:@"%@",@"CFBundleVersion"]];
}

+ (NSString *)appShortVersion {
    return [[NSBundle mainBundle].infoDictionary objectForKey:[NSString stringWithFormat:@"%@",@"CFBundleShortVersionString"]];
}

+ (NSString *)appBundleIdentifier {
    return [[NSBundle mainBundle] bundleIdentifier];
}

+ (NSString *)appDisplayName {
    return [[NSBundle mainBundle].infoDictionary objectForKey:[NSString stringWithFormat:@"%@",@"CFBundleDisplayName"]];
}

+ (NSString *)obtainChannel {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:[NSString stringWithFormat:@"%@",@"ChannelKey"]];
}

+ (NSString *)obtainSubChannel {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:[NSString stringWithFormat:@"%@",@"SubChannelKey"]];
}

@end

@implementation NSString (MYMGHashes)

- (NSString *)hash_md5
{
    
    const char* ptr = [self UTF8String];
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    
    CC_MD5(ptr, (CC_LONG)strlen(ptr), md5Buffer);
    
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", md5Buffer[i]];
    }
    
    return output;
}

- (NSString *)hash_base64Encode {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    data = [GTMBase64 encodeData:data];
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}
@end
