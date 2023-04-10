
#import "AppDelegate.h"
#import <ZhenwuSDK/ZhenwuSDK.h>
#import <MOPMAdSDK/MOPMAdSDK.h>
#import "JPBaoFu_ViewController.h"
#import "XZMCoreNewFeatureVC.h"
#import "UIDevice+GrossExtension.h"
#import <AppTrackingTransparency/AppTrackingTransparency.h>

@interface AppDelegate ()

@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    ZhenwupAdjustConfig_Entity *adjustConfig = [[ZhenwupAdjustConfig_Entity alloc] init];
#ifdef DEBUG
    adjustConfig.environment = ZW_EnvironmentSandbox;
    [ZhenwupOpenAPI zwp01_openDevLog:YES];
#else
    adjustConfig.environment = DiGEnvironmentProduction;
#endif
    adjustConfig.adjustAppToken = @"oslj29j3n6kg";
    adjustConfig.zwp01_eventTokenLogin = @"5nsnvh";
    adjustConfig.zwp01_eventTokenRegister = @"occ1xt";
    adjustConfig.zwp01_eventTokenAccRegister = @"s1dc5w";
    adjustConfig.zwp01_eventTokenFBRegister = @"nbug49";
    
    
    
    adjustConfig.zwp01_eventTokenCreateRoles = @"izc3em";
    
    adjustConfig.zwp01_eventTokenCompleteNoviceTask = @"c4n1ev";
    adjustConfig.zwp01_eventTokenPurchase = @"gpxl5p";
    
    adjustConfig.zwp01_eventTokenPurchaseARPU1 = @"bsye6b";
    adjustConfig.zwp01_eventTokenPurchaseARPU5 = @"al8h27";
    adjustConfig.zwp01_eventTokenPurchaseARPU10 = @"mv8eo0";
    adjustConfig.zwp01_eventTokenPurchaseARPU30 = @"hb40bu";
    adjustConfig.zwp01_eventTokenPurchaseARPU50 = @"6zyu5x";
    adjustConfig.zwp01_eventTokenPurchaseARPU100 = @"jxu510";
    
    adjustConfig.zwp01_eventTokenbegincdnTask = @"n42qn6";
    adjustConfig.zwp01_eventTokenfinishcdnTask = @"qr4cz6";
    
    
    adjustConfig.zwp01_eventTokenbeginNoviceTask = @"b6g2tv";
    
    
    
    ZhenwupSDKConfig_Entity *config = [[ZhenwupSDKConfig_Entity alloc] init];
    
    config.gameID = @"10";
    config.gameKey = @"ED9D91B21511F9A0AA7D43C165BB1F05";
    //    config.gameID = @"86";
    //    config.gameKey = @"34BB9BBA7966ED10B610486F73F2C626";
    config.facebookAppID = @"1912120749119216";
    
    
    config.adjustConfig = adjustConfig;
    config.sdkConnectServer = EM_SDKServerVi;
    [ZhenwupOpenAPI zwp01_launchSDKWithConfig:config
                                  application:application
                didFinishLaunchingWithOptions:launchOptions];
    
    [MOPMAdSDKAPI initSDKWithAppKey:[NSString stringWithFormat:@"%@%@%@%@",@"1pB8Ma",@"FrvRr",@"eX6vVfmHu4Gt9o",@"MjHrRol"]];
    
    return YES;
}

- (void)requestIDFA {
    if (@available(iOS 14, *)) {
        [ATTrackingManager requestTrackingAuthorizationWithCompletionHandler:^(ATTrackingManagerAuthorizationStatus status) {
            // Tracking authorization completed. Start loading ads here.
            //             [self loadAd];
        }];
    } else {
        // Fallback on earlier versions
    }
}



- (void)em14_initUI{
    
    JPBaoFu_ViewController *vc = [[JPBaoFu_ViewController alloc] init];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    
}
- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [self requestIDFA];
    [ZhenwupOpenAPI activateApp];
}
- (void)applicationWillTerminate:(UIApplication *)application {
    
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {

    return [ZhenwupOpenAPI application:application
                              openURL:url
                    sourceApplication:sourceApplication
                           annotation:annotation];
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options
{
    return [ZhenwupOpenAPI application:app openURL:url options:options];
}

@end
