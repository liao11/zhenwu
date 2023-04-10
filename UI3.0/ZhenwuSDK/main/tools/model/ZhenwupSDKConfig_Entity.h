
#import <Foundation/Foundation.h>
#import "ZhenwupAdjustConfig_Entity.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, EM_Language) {
    EM_LanguageVi,
    EM_LanguageTh,
    EM_LanguageCh,
};

typedef NS_ENUM(NSInteger, EM_SDKServer) {
    EM_SDKServerVi,
    EM_SDKServerTh,
};

@interface ZhenwupSDKConfig_Entity : NSObject

@property (nonatomic, copy) NSString *gameID;
@property (nonatomic, copy) NSString *gameKey;

@property (nonatomic, copy) NSString *facebookAppID;
@property (nonatomic, strong) ZhenwupAdjustConfig_Entity *adjustConfig;

@property (nonatomic, assign) EM_SDKServer sdkConnectServer;
@end

NS_ASSUME_NONNULL_END
