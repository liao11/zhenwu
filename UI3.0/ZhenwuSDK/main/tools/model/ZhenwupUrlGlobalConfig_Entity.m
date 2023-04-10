
#import "ZhenwupUrlGlobalConfig_Entity.h"
#import "ZhenwupHelper_Utils.h"

@interface ZhenwupUrlGlobalConfig_Entity ()

@property (nonatomic, strong, readwrite) ZhenwupUrlDomainConfig_Entity *em14_httpsdomain;
@property (nonatomic, strong, readwrite) ZhenwupUrlParamsKeyConfig_Entity *em14_paramsconfig;
@property (nonatomic, strong, readwrite) ZhenwupUrlRCPConfig_Entity *em14_rcppathconfig;
@property (nonatomic, strong, readwrite) ZhenwupAESKeyConfig_Entity *em14_datacodeconfig;
@end

@implementation ZhenwupUrlGlobalConfig_Entity

+ (instancetype)SharedInstance {
    static ZhenwupUrlGlobalConfig_Entity* shareGlobalConfig = nil;
    static dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        shareGlobalConfig = [[self alloc] init];
    });
    return shareGlobalConfig;
}

- (instancetype)init {
    if (self = [super init]) {
        [self em14_updateCofigData];
    }
    return self;
}

- (void)em14_updateCofigData {
//    NSDictionary *dict = [ZhenwupHelper_Utils em14_urlConifgsFromPlist];
    NSDictionary *dict = [ZhenwupHelper_Utils em14_getWordParam];
    self.em14_httpsdomain = [[ZhenwupUrlDomainConfig_Entity alloc] initWithDict:[dict objectForKey:[NSString stringWithFormat:@"%@",@"em14_domain_name"]]];
    self.em14_paramsconfig = [[ZhenwupUrlParamsKeyConfig_Entity alloc] initWithDict:[dict objectForKey:[NSString stringWithFormat:@"%@",@"em14_pathparams_key"]]];
    self.em14_rcppathconfig = [[ZhenwupUrlRCPConfig_Entity alloc] initWithDict:[dict objectForKey:[NSString stringWithFormat:@"%@",@"em14_url_path"]]];
    self.em14_datacodeconfig = [[ZhenwupAESKeyConfig_Entity alloc] initWithDict:[dict objectForKey:[NSString stringWithFormat:@"%@",@"em14_aes_key"]]];
}

@end
