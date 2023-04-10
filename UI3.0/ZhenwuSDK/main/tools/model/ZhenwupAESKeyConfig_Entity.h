
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZhenwupAESKeyConfig_Entity : NSObject

@property (nonatomic, copy) NSString *em14_AES128Key;
@property (nonatomic, copy) NSString *em14_AES128iv;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
