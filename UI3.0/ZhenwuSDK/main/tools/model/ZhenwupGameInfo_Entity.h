
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZhenwupGameInfo_Entity : NSObject
@property (nonatomic, copy) NSString *gameID;
@property (nonatomic, copy) NSString *gameKey;
@property (nonatomic, copy) NSString *cpRoleID;
@property (nonatomic, copy) NSString *cpRoleName;
@property (nonatomic, copy) NSString *cpServerID;
@property (nonatomic, copy) NSString *cpServerName;
@property (nonatomic, assign) NSUInteger cpRoleLevel;
@property (nonatomic, copy) NSString *chRoleID;
@property (nonatomic, copy) NSString *chServerID;
@property (nonatomic, copy) NSString *sessionID;

@end

NS_ASSUME_NONNULL_END
