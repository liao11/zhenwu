
#import <Foundation/Foundation.h>
#import "GMGBase64Defines.h"

@interface GMGBase64 : NSObject

+(NSData *)encodeData:(NSData *)data;

+(NSData *)decodeData:(NSData *)data;

+(NSData *)encodeBytes:(const void *)bytes length:(NSUInteger)length;

+(NSData *)decodeBytes:(const void *)bytes length:(NSUInteger)length;

+(NSString *)stringByEncodingData:(NSData *)data;

+(NSString *)stringByEncodingBytes:(const void *)bytes length:(NSUInteger)length;

+(NSData *)decodeString:(NSString *)string;

+(NSData *)cqh_SafeEncodeData:(NSData *)data
                      padded:(BOOL)padded;

+(NSData *)cqh_SafeDecodeData:(NSData *)data;

+(NSData *)cqh_SafeEncodeBytes:(const void *)bytes
                       length:(NSUInteger)length
                       padded:(BOOL)padded;

+(NSData *)alhm_SafeDecodeBytes:(const void *)bytes length:(NSUInteger)length;

+(NSString *)stringByWebSafeEncodingData:(NSData *)data
                                  padded:(BOOL)padded;

+(NSString *)stringByWebSafeEncodingBytes:(const void *)bytes
                                   length:(NSUInteger)length
                                   padded:(BOOL)padded;

+(NSData *)alhm_SafeDecodeString:(NSString *)string;

@end
