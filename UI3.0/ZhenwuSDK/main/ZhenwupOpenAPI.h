
#import <UIKit/UIKit.h>

#import "ZhenwupSDKConfig_Entity.h"
#import "ZhenwupResponseObject_Entity.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ZhenwupOpenAPIDelegate <NSObject>
@optional

- (void)zwp01_initialSDKFinished:(ZhenwupResponseObject_Entity *)response;
- (void)zwp01_loginFinished:(ZhenwupResponseObject_Entity *)response;
- (void)zwp01_enterGameFinished:(ZhenwupResponseObject_Entity *)response;
- (void)zwp01_logoutFinished:(ZhenwupResponseObject_Entity *)response;
- (void)zwp01_deleteFinished:(ZhenwupResponseObject_Entity *)response;

- (void)zwp01_registerServerInfoFinished:(ZhenwupResponseObject_Entity *)response;
- (void)zwp01_commitGameRoleLevelFinished:(ZhenwupResponseObject_Entity *)response;
- (void)zwp01_getPurchaseProducesFinished:(ZhenwupResponseObject_Entity *)response;

- (void)zwp01_startPurchaseProduceOrderFinished:(ZhenwupResponseObject_Entity *)response;
- (void)zwp01_checkOrderAppleReceiptFinished:(ZhenwupResponseObject_Entity *)response;
- (void)zwp01_checkPresentFinish:(ZhenwupResponseObject_Entity *)response;

@end

#define EMSDKAPI [ZhenwupOpenAPI SharedInstance]

@class ZhenwupUserInfo_Entity, ZhenwupGameInfo_Entity, ZhenwupCPPurchaseOrder_Entity;
@interface ZhenwupOpenAPI : NSObject
@property (nonatomic, weak) id<ZhenwupOpenAPIDelegate> delegate;
@property (nonatomic, strong, nullable) UIViewController *context;
@property (nonatomic, assign) EM_Language zwp01_localizedLanguage;
@property (nonatomic, assign) BOOL em_tiePresent;
@property (nonatomic, strong, nullable, readonly) ZhenwupUserInfo_Entity *userInfo;
@property (nonatomic, strong, nullable, readonly) ZhenwupGameInfo_Entity *gameInfo;
@property (nonatomic, readonly) NSString *zwp01_SDKVersion;
+ (instancetype)SharedInstance;
+ (void)zwp01_openDevLog:(BOOL)isOpen;
+ (void)zwp01_launchSDKWithConfig:(ZhenwupSDKConfig_Entity *)config application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation;
+ (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options;
+ (void)zwp01_initialSDK;
+ (void)activateApp;
+ (void)zwp01_completeNoviceTask;
//
// cdn 开始
+ (void)zwp01_begincdnTask;
// cdn 结束
+ (void)zwp01_finishcdnTask;
// 新手引导开始
+ (void)zwp01_beginNoviceTask;
+ (void)zwp01_showSuspension;
+(void)zwp01_u_pay;
+ (void)zwp01_setShortCutHidden:(BOOL)hidden;
+ (void)em_obtainPresentWithGameId:(NSString *)em11_gameId em14_roleId:(NSString *)em14_roleId;
+ (void)zwp01_firebaseEventWithName:(NSString *)name parameters:(nullable NSDictionary<NSString *, id> *)parameters;
+ (void)zwp01_adjustEventWithEventToken:(NSString *)eventToken parameters:(nullable NSDictionary<NSString *, id> *)parameters;
#pragma mark - 游戏 API
+ (void)showLoginView;
+ (void)logout:(BOOL)showAlertView;
+ (void)zwp01_enterGameIntoServerId:(NSString *)serverId
                   serverName:(NSString *)serverName
                   withRoleId:(NSString *)roleId
                     roleName:(NSString *)roleName
                 andRoleLevel:(NSUInteger)roleLevel;
+ (void)zwp01_updateAndCommitGameRoleLevel:(NSUInteger)level;
+ (BOOL)zwp01_clearAllHistoryAccounts;
+ (void)zwp01_delete:(BOOL)showAlertView;
#pragma mark - Purchase API
+ (void)zwp01_getPurchaseProduces;
+ (void)zwp01_startPurchaseProduceOrder:(ZhenwupCPPurchaseOrder_Entity *)purchaseOrder;

#pragma mark - Req SDK
+ (void)zwp01_sdkRequestPath:(NSString *)path parameters:(NSDictionary *)parameters responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;
@end

NS_ASSUME_NONNULL_END
