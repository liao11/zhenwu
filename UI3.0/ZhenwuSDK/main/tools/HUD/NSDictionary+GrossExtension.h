
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (MYMGExtension)

- (NSString *)em14_jsonString;
+ (NSDictionary *)em14_dictWithJsonString:(NSString *)json;

@end

@interface NSDictionary(MYMGSafe)

- (id)em14_safeObjectForKey:(id)key;
- (int)em14_intValueForKey:(id)key;
- (double)em14_doubleValueForKey:(id)key;
- (NSString *)em14_stringValueForKey:(id)key;

@end

@interface NSMutableDictionary(MYMGSafe)

- (void)em14_safeSetObject:(id)anObject forKey:(id)aKey;
- (void)em14_setIntValue:(int)value forKey:(id)aKey;
- (void)em14_setDoubleValue:(double)value forKey:(id)aKey;
- (void)em14_setStringValueForKey:(NSString *)string forKey:(id)aKey;

@end

NS_ASSUME_NONNULL_END
