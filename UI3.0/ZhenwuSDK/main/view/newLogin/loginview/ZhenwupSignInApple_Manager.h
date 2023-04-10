
#import <Foundation/Foundation.h>
#import "ZhenwupResponseObject_Entity.h"

NS_ASSUME_NONNULL_BEGIN

@protocol EM1_SignInApple_ManagerDelegate <NSObject>

- (void)em11_DidSigninWithApple:(ZhenwupResponseObject_Entity *)response;
@end

@interface ZhenwupSignInApple_Manager : NSObject

+ (instancetype)em11_SharedManager;

- (void)em11_CheckCredentialState;

- (void)em11_HandleAuthorizationAppleIDButtonPress:(id <EM1_SignInApple_ManagerDelegate>)delegate;
- (void)em11_PerfomExistingAccountSetupFlows:(id <EM1_SignInApple_ManagerDelegate>)delegate;

@end

NS_ASSUME_NONNULL_END
