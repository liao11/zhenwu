
#import <UIKit/UIKit.h>
#import "ZhenwupGameInfo_Entity.h"
#import "ZhenwupUserInfo_Entity.h"
#import "ZhenwupSDKConfig_Entity.h"
#import "ZhenwupResponseObject_Entity.h"
#import "ZhenwupTelDataServer.h"
#define EMSDKGlobalInfo [ZhenwupSDKGlobalInfo_Entity SharedInstance]

typedef NS_OPTIONS(NSUInteger, EM_SDKFlagOptions) {
    EM_SDKFlagNone         = 0,
    EM_SDKFlagFB           = 1 << 0, 
    EM_SDKFlagApple        = 1 << 1, 
    EM_SDKFlagShortcut     = 1 << 2, 
    EM_SDKFlagBindemail    = 1 << 3, 
    EM_SDKFlagHeart        = 1 << 4,
    EM_SDKFlagCoup         = 1 << 5,
    EM_SDKFlagData         = 1 << 6,
};

NS_ASSUME_NONNULL_BEGIN

@interface ZhenwupSDKGlobalInfo_Entity : NSObject

@property (nonatomic, strong) ZhenwupGameInfo_Entity *gameInfo;
@property (nonatomic, strong) ZhenwupUserInfo_Entity *userInfo;
@property (nonatomic, strong) NSSet<NSString *> * productIdentifiers;
@property (nonatomic, strong) NSString *customorSeviceMail;
@property (nonatomic, strong) NSArray *purchaseProduces;
@property (nonatomic, strong) ZhenwupAdjustConfig_Entity *adjustConfig;
@property (nonatomic, assign) EM_SDKServer sdkConnectServer;

@property (nonatomic, assign) BOOL sdkIsLogin;
@property (nonatomic, assign) BOOL lastWayLogin;
@property (nonatomic, assign) BOOL iszwp01_openDevLog;
@property (nonatomic, assign) BOOL isEnterGame;
@property (nonatomic, assign) BOOL isShowedLoginView;

@property (nonatomic, assign) BOOL em11_GvCheck;
@property (nonatomic, assign) EM_SDKFlagOptions em14_sdkFlag;
@property (nonatomic, assign) NSInteger lightState;

@property (nonatomic, copy) NSString *login_agree;
@property (nonatomic, copy) NSString *reg_agree;
@property (nonatomic, copy) NSString *hint;
@property (nonatomic, copy) NSString *notice;

- (UIViewController *)em14_CurrentVC;

+ (instancetype)SharedInstance;
- (void)em14_parserUserInfoFromResponseResult:(NSDictionary *)result;
- (void)em_parserTelInfoFromResponseResult:(NSDictionary *)result;
- (void)clearUselessInfo;

- (void)em14_PresendWithUrlString:(NSString *)URLString;
- (void)em14_SendEmail:(NSString *)email;
@end

NS_ASSUME_NONNULL_END
