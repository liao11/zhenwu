
#import "ZhenwupRemoteData_Server.h"

NS_ASSUME_NONNULL_BEGIN

#define MYMGSDKHeart [ZhenwupSDKHeart_Server sharedInstance]

@interface ZhenwupSDKHeart_Server : ZhenwupRemoteData_Server

+ (instancetype)sharedInstance;

- (void)em14_startRefreshTokenTimer;
- (void)em14_stopRefreshTokenTimer;
- (void)em14_startSDKHeartBeat;
- (void)em14_stopSDKHeartBeat;

@end

NS_ASSUME_NONNULL_END
