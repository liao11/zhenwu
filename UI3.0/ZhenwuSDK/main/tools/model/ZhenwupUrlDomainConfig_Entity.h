
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZhenwupUrlDomainConfig_Entity : NSObject

@property (nonatomic, copy) NSString *em14_baseUrl;
@property (nonatomic, copy) NSString *em14_backupsBaseUrl;
@property (nonatomic, copy) NSString *em14_returnupsBaseUrl;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
