
#import <Foundation/Foundation.h>
#import "ZhenwupUrlDomainConfig_Entity.h"
#import "ZhenwupUrlParamsKeyConfig_Entity.h"
#import "ZhenwupUrlRCPConfig_Entity.h"
#import "ZhenwupAESKeyConfig_Entity.h"

#define MYMGUrlConfig [ZhenwupUrlGlobalConfig_Entity SharedInstance]

NS_ASSUME_NONNULL_BEGIN

@interface ZhenwupUrlGlobalConfig_Entity : NSObject

@property (nonatomic, strong, readonly) ZhenwupUrlDomainConfig_Entity *em14_httpsdomain;
@property (nonatomic, strong, readonly) ZhenwupUrlParamsKeyConfig_Entity *em14_paramsconfig;
@property (nonatomic, strong, readonly) ZhenwupUrlRCPConfig_Entity *em14_rcppathconfig;
@property (nonatomic, strong, readonly) ZhenwupAESKeyConfig_Entity *em14_datacodeconfig;

+ (instancetype)SharedInstance;
- (void)em14_updateCofigData;
@end

NS_ASSUME_NONNULL_END
