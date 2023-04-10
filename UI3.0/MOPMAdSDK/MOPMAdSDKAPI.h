
#import <Foundation/Foundation.h>
#import <ZhenwuSDK/ZhenwuSDK.h>
#import <UIKit/UIKit.h>
#import "MOPM_AdScene_Entity.h"
#import "ZhenwupOpenAPI.h"


NS_ASSUME_NONNULL_BEGIN

@protocol MOPMAdSDKRewardDelegate <NSObject>

- (void)rewardVideoChangedAvailability:(BOOL)available;

- (void)rewardVideoDidOpen:(MOPM_AdScene_Entity*)scene;

- (void)rewardVideoPlayStart:(MOPM_AdScene_Entity*)scene;

- (void)rewardVideoPlayEnd:(MOPM_AdScene_Entity*)scene;

- (void)rewardVideoDidClick:(MOPM_AdScene_Entity*)scene;

- (void)rewardVideoDidReceiveReward:(MOPM_AdScene_Entity*)scene;

- (void)rewardVideoDidClose:(MOPM_AdScene_Entity*)scene;

- (void)rewardVideoDidFailToShow:(MOPM_AdScene_Entity*)scene withError:(NSError *)error;
@end

@interface MOPMAdSDKAPI : NSObject

+ (instancetype)SharedInstance;
@property (nonatomic, weak) id<MOPMAdSDKRewardDelegate> rewardDelegate;
+ (void)initSDKWithAppKey:(NSString *)appKey;

#pragma mark - 广告视频 API
+ (void)showRewardVideoAd:(NSString*)adId inViewController:(UIViewController *)viewController;

@end

NS_ASSUME_NONNULL_END
