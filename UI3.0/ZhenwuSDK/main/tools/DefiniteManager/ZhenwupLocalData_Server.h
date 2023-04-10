
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class ZhenwupUserInfo_Entity;

@interface ZhenwupLocalData_Server : NSObject

+ (void)em14_saveLoginedUserInfo:(ZhenwupUserInfo_Entity *)userInfo;

+ (NSArray *)em14_loadAllSavedLoginedUser;
+ (void)em14_UpdataUserWithusername:(NSString *)username andpsw:(NSString *)psd;
+ (BOOL)em14_removeAllLoginedUserHistory;

+ (void)em14_removeLoginedUserInfoFormHistory:(ZhenwupUserInfo_Entity *)userInfo;

@end

NS_ASSUME_NONNULL_END
