
#import "ZhenwupAutoLogin_View.h"
#import "ZhenwupHelper_Utils.h"
#import "ZhenwupLogin_Server.h"
#import "NSString+GrossExtension.h"
#import "UIView+GrossExtension.h"
#import "MBProgressHUD+GrossExtension.h"
#import "ZhenwupLocalData_Server.h"
@interface ZhenwupAutoLogin_View ()

@property (strong, nonatomic) UIImageView *em14_AutoLoginHud;
@property (strong, nonatomic) ZhenwupLogin_Server *em14_LoginServer;
@end

@implementation ZhenwupAutoLogin_View

- (void)dealloc {
    [self em14_u_StopAutoLoginHudAnimation];
    MYMGLog(@"%@ dealloc..", NSStringFromClass([self class]));
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self em14_setupViews];
    }
    return self;
}


- (ZhenwupLogin_Server *)em14_LoginServer {
    if (!_em14_LoginServer) {
        _em14_LoginServer = [[ZhenwupLogin_Server alloc] init];
    }
    return _em14_LoginServer;
}


- (void)em14_setupViews {
    self.frame = CGRectMake(0, 0, 35, 35);
    
    self.em14_AutoLoginHud = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 35, 35)];
    self.em14_AutoLoginHud.center = self.center;
    self.em14_AutoLoginHud.image = [ZhenwupHelper_Utils imageName:@"zhenwuimloading"];
    [self addSubview:self.em14_AutoLoginHud];
    
    [self em14_u_StarAutoLoginHudAnimation];
}


- (void)em14_u_StarAutoLoginHudAnimation {
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:[NSString stringWithFormat:@"%@",@"transform.rotation.z"]];
    rotationAnimation.toValue = @(-M_PI * 2);
    rotationAnimation.repeatCount = HUGE;
    rotationAnimation.duration = 2.0;
    [self.em14_AutoLoginHud.layer addAnimation:rotationAnimation forKey:[NSString stringWithFormat:@"%@",@"KCBasicAnimation_Rotation_AutoLoginView"]];
}

- (void)em14_u_StopAutoLoginHudAnimation {
    [self.em14_AutoLoginHud.layer removeAllAnimations];
}


- (void)em11_AutoLoginWithLastLoginUser:(ZhenwupUserInfo_Entity *)lastLoginUser {
    __weak typeof(self) weakSelf = self;
    if (![lastLoginUser.userName isValidateMobile]) {
        [self.em14_LoginServer lhxy_DeviceActivate:lastLoginUser.userName md5Password:lastLoginUser.password responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull result) {
            if (result.em14_responseCode == EM_ResponseCodeSuccess) {
                if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(em18_FastAutLoginView:loginSucess:)]) {
                    [weakSelf.delegate em18_FastAutLoginView:weakSelf loginSucess:YES];
                } else {
                    [weakSelf removeFromSuperview];
                }
            } else {
                if (result.em14_responseCode == EM_ResponseCodePwdError) {
                     [ZhenwupLocalData_Server em14_removeLoginedUserInfoFormHistory:lastLoginUser];
                }
                
                [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
                if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(em18_FastAutLoginView:loginSucess:)]) {
                    [weakSelf.delegate em18_FastAutLoginView:weakSelf loginSucess:NO];
                }
            }
        }];
    }else{
        [self em_telLoginWithAccount:lastLoginUser.userName password:lastLoginUser.password em14_telDist:MUUQYLocalizedString(@"EMKey_nowDist") lastLoginUser:lastLoginUser];
    }
    
    
    
}

- (void)em_telLoginWithAccount:(NSString *)account password:(NSString *)password em14_telDist:(NSString *)em14_telDist lastLoginUser:(ZhenwupUserInfo_Entity *)lastLoginUser
{
    [MBProgressHUD em14_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.em14_LoginServer lhxy_telLogin:account md5Password:password em14_telDist:em14_telDist responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        
        [MBProgressHUD em14_DismissLoadingHUD];
        
        if (result.em14_responseCode == EM_ResponseCodeSuccess) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(em18_FastAutLoginView:loginSucess:)]) {
                [weakSelf.delegate em18_FastAutLoginView:weakSelf loginSucess:YES];
            } else {
                [weakSelf removeFromSuperview];
            }
        } else {
            if (result.em14_responseCode == EM_ResponseCodePwdError) {
                 [ZhenwupLocalData_Server em14_removeLoginedUserInfoFormHistory:lastLoginUser];
            }
            
            [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(em18_FastAutLoginView:loginSucess:)]) {
                [weakSelf.delegate em18_FastAutLoginView:weakSelf loginSucess:NO];
            }
        }
    }];
}

@end
