
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (MYMGExtension)

- (NSString *)em14_jsonString;
+ (NSArray *)em14_arrayWithJsonString:(NSString *)json;

@end

NS_ASSUME_NONNULL_END
