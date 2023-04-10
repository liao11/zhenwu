
#import <Foundation/Foundation.h>
#import "ZhenwupOpenAPI.h"
#import "ZhenwupSDKGlobalInfo_Entity.h"
#import "ZhenwupResponseObject_Entity.h"
#import "EM_Define.h"
#import "ZhenwupHelper_Utils.h"
#import "ZhenwupUrlGlobalConfig_Entity.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZhenwupRemoteData_Server : NSObject

+ (NSString *)em14_BuildFinalUrl:(NSString *)url WithPath:(NSString *)path andParams:(NSDictionary *)params;

- (NSString *)em14_BuildFinalUrlWithPath:(NSString *)urlPath;

- (NSString *)em14_ParseParamKey:(NSString *)key;

- (void)em14_SetDeviceInfosIntoParams:(NSMutableDictionary *)params;

- (void)em14_PostRequestURL:(NSString *)URL parameters:(NSMutableDictionary *)parameters responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;

- (void)em14_RefreshToken:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;

- (void)em14_RequestPath:(NSString *)path parameters:(NSDictionary *)parameters responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;
@end

NS_ASSUME_NONNULL_END
