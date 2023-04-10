
#import "ZhenwupSignInApple_Manager.h"
#import <AuthenticationServices/AuthenticationServices.h>
#import "ZhenwupKeychain_Manager.h"
#import "EM_Define.h"
#import "ZhenwupLogin_Server.h"
NSString *const cKeychainServiceForAppleCurrentUserIdentifier = @"www.xmmy.com.AppleCurrentUserIdentifier";

@interface ZhenwupSignInApple_Manager () <ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding>

@property (nonatomic, weak) id<EM1_SignInApple_ManagerDelegate> delegate;
@end

@implementation ZhenwupSignInApple_Manager

+ (instancetype)em11_SharedManager {
    static ZhenwupSignInApple_Manager *signInAppleManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        signInAppleManager = [[ZhenwupSignInApple_Manager alloc] init];
    });
    return signInAppleManager;
}

- (instancetype)init {
    if (self = [super init]) {
        [self em11_observeAppleSignInState];
    }
    return self;
}

- (void)em11_observeAppleSignInState {
    if (@available(iOS 13.0, *)) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(em11_handleSignInWithAppleStateChanged:)
                                                     name:ASAuthorizationAppleIDProviderCredentialRevokedNotification
                                                   object:nil];
    }
}

- (void)em11_handleSignInWithAppleStateChanged:(NSNotification *)notification {
    
    MYMGLog(@"苹果登录状态监听:name = %@, userinfo = %@", notification.name, notification.userInfo);
}

- (NSString *)em11_currentAppleUserIdentifier {
    return [ZhenwupKeychain_Manager em14_keychainObjectForKey:cKeychainServiceForAppleCurrentUserIdentifier];
}

- (void)em11_CheckCredentialState {
    if (@available(iOS 13.0, *)) {
        NSString *userIdentifier = [[ZhenwupSignInApple_Manager em11_SharedManager] em11_currentAppleUserIdentifier];
        MYMGLog(@"苹果登录 userIdentifier=%@", userIdentifier);
        if (userIdentifier) {
            ASAuthorizationAppleIDProvider *appleIDProvider = [ASAuthorizationAppleIDProvider new];
            [appleIDProvider getCredentialStateForUserID:userIdentifier
                                              completion:^(ASAuthorizationAppleIDProviderCredentialState credentialState, NSError * _Nullable error)
            {
                switch (credentialState) {
                    case ASAuthorizationAppleIDProviderCredentialAuthorized:
                        MYMGLog(@"苹果登录----授权状态有效");
                        break;
                    case ASAuthorizationAppleIDProviderCredentialRevoked:
                        MYMGLog(@"苹果登录----上次使用苹果账号登录的凭据已被移除，需解除绑定并重新引导用户使用苹果登录");
                        break;
                    case ASAuthorizationAppleIDProviderCredentialNotFound:
                        MYMGLog(@"苹果登录----未登录授权，直接弹出登录页面，引导用户登录");
                        break;
                    case ASAuthorizationAppleIDProviderCredentialTransferred:
                        MYMGLog(@"苹果登录----ASAuthorizationAppleIDProviderCredentialTransferred凭证已转移");
                        break;
                }
            }];
        }
    }
}

- (void)em11_HandleAuthorizationAppleIDButtonPress:(id <EM1_SignInApple_ManagerDelegate>)delegate {
    if (@available(iOS 13.0, *)) {
        _delegate = delegate;
        
        ASAuthorizationAppleIDProvider *provider = [[ASAuthorizationAppleIDProvider alloc] init];
        ASAuthorizationAppleIDRequest *request = [provider createRequest];
        request.requestedScopes = @[ASAuthorizationScopeFullName, ASAuthorizationScopeEmail];
        ASAuthorizationController *authorizationController = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[request]];
        
        authorizationController.delegate = self;
        authorizationController.presentationContextProvider = self;
        [authorizationController performRequests];
    }
}

- (void)em11_PerfomExistingAccountSetupFlows:(id <EM1_SignInApple_ManagerDelegate>)delegate {
    if (@available(iOS 13.0, *)) {
        _delegate = delegate;
        
        ASAuthorizationAppleIDProvider *appleIDProvider = [[ASAuthorizationAppleIDProvider alloc] init];
        ASAuthorizationAppleIDRequest *appleIDRequest = [appleIDProvider createRequest];
        
        ASAuthorizationPasswordProvider *passwordProvider = [[ASAuthorizationPasswordProvider alloc] init];
        ASAuthorizationPasswordRequest *passwordRequest = [passwordProvider createRequest];
        
        ASAuthorizationController *authorizationController = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[appleIDRequest, passwordRequest]];
        authorizationController.delegate = self;
        authorizationController.presentationContextProvider = self;
        [authorizationController performRequests];
    }
}


- (ASPresentationAnchor)presentationAnchorForAuthorizationController:(ASAuthorizationController *)controller API_AVAILABLE(ios(13.0)) {
    return [UIApplication sharedApplication].windows.lastObject;
}


- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithAuthorization:(ASAuthorization *)authorization API_AVAILABLE(ios(13.0)) {
    if ([authorization.credential isKindOfClass:[ASAuthorizationAppleIDCredential class]]) {
        
        ASAuthorizationAppleIDCredential * credential = authorization.credential;
        NSString * userID = credential.user;
        
        
        NSPersonNameComponents *fullName = credential.fullName;
        NSString * email = credential.email;
        
        
        
        NSString * authorizationCode = [[NSString alloc] initWithData:credential.authorizationCode encoding:NSUTF8StringEncoding];
        
        NSString * identityToken = [[NSString alloc] initWithData:credential.identityToken encoding:NSUTF8StringEncoding];
        
        ASUserDetectionStatus realUserStatus = credential.realUserStatus;
        
        MYMGLog(@"\n苹果登录授权完成\n userID: %@\n fullName: %@\n email: %@\n authorizationCode: %@\n identityToken: %@\n realUserStatus: %@\n ", userID, fullName, email , authorizationCode, identityToken, @(realUserStatus));

        [ZhenwupKeychain_Manager em14_keychainSaveObject:userID forKey:cKeychainServiceForAppleCurrentUserIdentifier];
        
        [[ZhenwupLogin_Server new] lhxy_VerifySignInWithApple:userID email:email authorizationCode:authorizationCode identityToken:identityToken responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull result) {
            if (self->_delegate && [self->_delegate respondsToSelector:@selector(em11_DidSigninWithApple:)]) {
                [self->_delegate em11_DidSigninWithApple:result];
            }
        }];
    } else if ([authorization.credential isKindOfClass:[ASPasswordCredential class]]){
        
        
        
        ASPasswordCredential *passwordCredential = authorization.credential;
        
        NSString *user = passwordCredential.user;
        
        NSString *password = passwordCredential.password;
            
        MYMGLog(@"\n用户登录使用现有的密码凭证\n user: %@\n password: %@\n authorization.credential: %@\n", user, password, authorization.credential);
        
        [[ZhenwupLogin_Server new] lhxy_VerifySignInWithApple:user email:@"" authorizationCode:@"" identityToken:@"" responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull result) {
            if (self->_delegate && [self->_delegate respondsToSelector:@selector(em11_DidSigninWithApple:)]) {
                [self->_delegate em11_DidSigninWithApple:result];
            }
        }];
    } else {
        MYMGLog(@"授权信息均不符");
        ZhenwupResponseObject_Entity *response = [[ZhenwupResponseObject_Entity alloc] init];
        response.em14_responseType = EM_ResponseTypeAppleLogin;
        response.em14_responeMsg = MUUQYLocalizedString(@"EMKey_AuthorizeUnknownError_Alert_Text");
        response.em14_responseCode = EM_ResponseCodeVerifyError;
        EM_RunInMainQueue(^{
            if (self->_delegate && [self->_delegate respondsToSelector:@selector(em11_DidSigninWithApple:)]) {
                [self->_delegate em11_DidSigninWithApple:response];
            }
            
            if (EMSDKAPI.delegate && [EMSDKAPI.delegate respondsToSelector:@selector(zwp01_loginFinished:)]) {
                [EMSDKAPI.delegate zwp01_loginFinished:response];
            }
        });
    }
}

- (void)authorizationController:(ASAuthorizationController *)controller didCompleteWithError:(NSError *)error API_AVAILABLE(ios(13.0)) {
    NSString *errorMsg = nil;
    switch (error.code) {
        case ASAuthorizationErrorCanceled:
            errorMsg = MUUQYLocalizedString(@"EMKey_AuthorizeCanceled_Alert_Text");
            break;
        case ASAuthorizationErrorFailed:
            errorMsg = MUUQYLocalizedString(@"EMKey_AuthorizeFailed_Alert_Text");
            break;
        case ASAuthorizationErrorInvalidResponse:
            errorMsg = MUUQYLocalizedString(@"EMKey_AuthorizInvalidResponse_Alert_Text");
            break;
        case ASAuthorizationErrorNotHandled:
            errorMsg = MUUQYLocalizedString(@"EMKey_AuthorizeNotHandled_Alert_Text");
            break;
        case ASAuthorizationErrorUnknown:
            errorMsg = MUUQYLocalizedString(@"EMKey_AuthorizeUnknownError_Alert_Text");
            break;
        default:
            break;
    }
    MYMGLog(@"苹果登录授权失败 controller=%@ \n error：%@ \n errorMsg = %@", controller, error, errorMsg);
    ZhenwupResponseObject_Entity *response = [[ZhenwupResponseObject_Entity alloc] init];
    response.em14_responseType = EM_ResponseTypeAppleLogin;
    response.em14_responeMsg = errorMsg;
    response.em14_responseCode = EM_ResponseCodeVerifyError;
    EM_RunInMainQueue(^{
        if (self->_delegate && [self->_delegate respondsToSelector:@selector(em11_DidSigninWithApple:)]) {
            [self->_delegate em11_DidSigninWithApple:response];
        }
        
        if (EMSDKAPI.delegate && [EMSDKAPI.delegate respondsToSelector:@selector(zwp01_loginFinished:)]) {
            [EMSDKAPI.delegate zwp01_loginFinished:response];
        }
    });
}

@end
