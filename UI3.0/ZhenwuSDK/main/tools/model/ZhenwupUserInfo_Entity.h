
#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, EM_AccountType) {
    EM_AccountTypeMuu = 1, //邮箱
    EM_AccountTypeGuest = 2,
    EM_AccountTypeFB = 3,
    EM_AccountTypeApple = 4,
    EM_AccountTypeTel = 6,
};

NS_ASSUME_NONNULL_BEGIN

@interface ZhenwupUserInfo_Entity : NSObject

@property (nonatomic, copy) NSString *userID;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *autoToken;
@property (nonatomic, copy) NSString *expireTime;
@property (nonatomic, assign) BOOL isBindEmail;
@property (nonatomic, assign) BOOL isBindMobile;
@property (nonatomic, assign) BOOL isBind;
@property (nonatomic, assign) BOOL isReg;

@property (nonatomic, copy) NSString *fbUserName;

@property (nonatomic, assign) NSInteger loginCount;
@property (nonatomic, assign) EM_AccountType accountType;

@end

NS_ASSUME_NONNULL_END
