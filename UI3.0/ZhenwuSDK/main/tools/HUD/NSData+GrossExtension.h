
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (MYMGExtension)

- (NSData *)AES128EncryptWithKey:(NSString *)key iv:(NSString *)iv;

- (NSData *)AES128DecryptWithKey:(NSString *)key iv:(NSString *)iv;

@end

NS_ASSUME_NONNULL_END
