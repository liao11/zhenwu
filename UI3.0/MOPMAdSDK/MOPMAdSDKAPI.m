
#import "MOPMAdSDKAPI.h"
#import <AdTimingSDK/AdTimingSDK.h>
#import "MOPM_AdConstant_Define.h"

@interface MOPMAdSDKAPI () <AdTimingRewardedVideoDelegate>

@property (nonatomic, copy) NSString *em11_ShowAdId;
@end

@implementation MOPMAdSDKAPI

- (instancetype)init {
    self = [super init];
    if (self) {
        [[AdTimingRewardedVideo sharedInstance] addDelegate:self];
    }
    return self;
}


- (void)adtimingRewardedVideoChangedAvailability:(BOOL)available {
    if (_rewardDelegate) {
        [_rewardDelegate rewardVideoChangedAvailability:available];
    }
}

- (void)adtimingRewardedVideoDidOpen:(AdTimingScene*)scene {
    [ZhenwupOpenAPI zwp01_setShortCutHidden:YES];
    if (_rewardDelegate) {
        [_rewardDelegate rewardVideoDidOpen:[self em14_u_AdSceneWithAdTimingScene:scene]];
    }
}

- (void)adtimingRewardedVideoPlayStart:(AdTimingScene*)scene {
    if (_rewardDelegate) {
        [_rewardDelegate rewardVideoPlayStart:[self em14_u_AdSceneWithAdTimingScene:scene]];
    }
}

- (void)adtimingRewardedVideoPlayEnd:(AdTimingScene*)scene {
    if (_rewardDelegate) {
        [_rewardDelegate rewardVideoPlayEnd:[self em14_u_AdSceneWithAdTimingScene:scene]];
    }
}

- (void)adtimingRewardedVideoDidClick:(AdTimingScene*)scene {
    if (_rewardDelegate) {
        [_rewardDelegate rewardVideoDidClick:[self em14_u_AdSceneWithAdTimingScene:scene]];
    }
}

- (void)adtimingRewardedVideoDidReceiveReward:(AdTimingScene*)scene {
//    if (self.em11_ShowAdId && self.em11_ShowAdId.length > 0) {
//        [ZhenwupOpenAPI zwp01_sdkRequestPath:em14_rcpUprewordAdPath parameters:@{em14_ckeyUpRewardAdId : self.em11_ShowAdId?:@""} responseBlock:^(DiGResponseObject_Entity * _Nonnull result) {
//        }];
//    }
//    
    if (_rewardDelegate) {
        [_rewardDelegate rewardVideoDidReceiveReward:[self em14_u_AdSceneWithAdTimingScene:scene]];
    }
}

- (void)adtimingRewardedVideoDidClose:(AdTimingScene*)scene {
    [ZhenwupOpenAPI zwp01_setShortCutHidden:NO];
    if (_rewardDelegate) {
        [_rewardDelegate rewardVideoDidClose:[self em14_u_AdSceneWithAdTimingScene:scene]];
    }
}

- (void)adtimingRewardedVideoDidFailToShow:(AdTimingScene*)scene withError:(NSError *)error {
    if (_rewardDelegate) {
        [_rewardDelegate rewardVideoDidFailToShow:[self em14_u_AdSceneWithAdTimingScene:scene] withError:error];
    }
}

- (MOPM_AdScene_Entity *)em14_u_AdSceneWithAdTimingScene:(AdTimingScene *)scene {
    if (scene) {
        MOPM_AdScene_Entity *em11_scene = [[MOPM_AdScene_Entity alloc] init];
        em11_scene.adId = scene.sceneName;
        em11_scene.originData = scene.originData;
        return em11_scene;
    }
    return nil;
}
+ (instancetype)SharedInstance {
    static MOPMAdSDKAPI* shareApi = nil;
    static dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        shareApi = [[self alloc] init];
    });
    return shareApi;
}

+ (void)initSDKWithAppKey:(NSString *)appKey {
    [AdTiming initWithAppKey:appKey];
}


+ (void)showRewardVideoAd:(NSString*)adId inViewController:(UIViewController *)viewController {
    if ([[AdTimingRewardedVideo sharedInstance] isReady]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MOPMAdSDKAPI SharedInstance].em11_ShowAdId = adId;
            [[AdTimingRewardedVideo sharedInstance] showWithViewController:viewController scene:adId];
        });
    } else {
        
    }
}

@end
