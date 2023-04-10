
#import "ZhenwupShortcut_View.h"
#import "ZhenwupSDKMainView_Controller.h"
#import "UIView+GrossExtension.h"
#import "ZhenwupTheme_Utils.h"
#import "ZhenwupHelper_Utils.h"
#import "NSString+GrossExtension.h"
#import "ZhenwupRemoteData_Server.h"
#import "UIViewController+CWLateralSlide.h"

#import "ZhenwupBottomView.h"
@interface ZhenwupShortcut_View ()

@property (nonatomic, strong) UIImageView *em14_ImageView;
@property (nonatomic, strong) UIView *em14_BtnsBgView;
@property (nonatomic, assign) CGFloat em14_BtnsBgViewWidth;
@property (nonatomic, strong) UILabel *em11_hintLab;
@property (nonatomic, strong) ZhenwupBottomView  *bview;

@end

@implementation ZhenwupShortcut_View

+ (instancetype)em14_SharedView {
    static ZhenwupShortcut_View *sharedShortcutView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedShortcutView = [[ZhenwupShortcut_View alloc] init];
    });
    return sharedShortcutView;
}

+ (void)em14_ShowShort {
   
    UIView *topView = [EMSDKGlobalInfo em14_CurrentVC].view.window;
   
    ZhenwupShortcut_View *shortcutView = [ZhenwupShortcut_View em14_SharedView];
    if ([topView.subviews containsObject:shortcutView] == NO) {
        [shortcutView removeFromSuperview];
        [topView addSubview:shortcutView];
    }
    [topView bringSubviewToFront:shortcutView];
    [shortcutView em14_u_ReLayoutSubViews];
    
    if (EMSDKGlobalInfo.em14_sdkFlag & EM_SDKFlagShortcut) {
        shortcutView.hidden = NO;
    } else {
        shortcutView.hidden = YES;
    }
}

+ (void)em14_DismissShort {
    [[ZhenwupShortcut_View em14_SharedView] removeFromSuperview];
}

+ (void)em14_ResetLocalizedString {
    [[ZhenwupShortcut_View em14_SharedView] em14_u_ResetLocalizedString];
}

- (void)dealloc {
    MYMGLog(@"%@ dealloc..", NSStringFromClass([self class]));
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self em14_SetupDefaultViews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    if (self.em_bottom >= self.superview.em_height) {
        self.em_bottom = self.superview.em_height;
    }
    if (self.em_right >= self.superview.em_width) {
        self.em_right = self.superview.em_width;
    }
}

- (void)em14_u_ResetLocalizedString {
    UIButton *accBtn = [_em14_BtnsBgView viewWithTag:101];
    [accBtn setTitle:MUUQYLocalizedString(@"EMKey_Account_Short_Text") forState:UIControlStateNormal];
    
    UIButton *cuservicBtn = [_em14_BtnsBgView viewWithTag:102];
    [cuservicBtn setTitle:MUUQYLocalizedString(@"EMKey_CustomerService_Text") forState:UIControlStateNormal];
    
    UIButton *ireBtn = [_em14_BtnsBgView viewWithTag:103];
    [ireBtn setTitle:MUUQYLocalizedString(@"EMKey_QuickCheckPurchase_Text") forState:UIControlStateNormal];
}

- (void)em14_SetupDefaultViews {
    self.frame = CGRectMake(0, [[UIApplication sharedApplication] statusBarFrame].size.height + 20, 40, 40);

  
    self.em14_BtnsBgViewWidth = 150;
    
    [self addSubview:self.em14_BtnsBgView];
    [self em14_u_HidenBtns:NO completion:nil];
    [self performSelector:@selector(em14_u_ResignActive) withObject:nil afterDelay:2.5];
    
    self.em14_ImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    self.em14_ImageView.image = [ZhenwupHelper_Utils imageName:@"zhenwuimfloat"];
    self.em14_ImageView.backgroundColor = [UIColor whiteColor];
    self.em14_ImageView.layer.cornerRadius = 20.0;
    self.em14_ImageView.layer.borderColor = [ZhenwupTheme_Utils em_colors_FBBlueColor].CGColor;
    self.em14_ImageView.layer.borderWidth = 0.5;
    self.em14_ImageView.layer.masksToBounds = YES;
    [self addSubview:self.em14_ImageView];
    
    self.em11_hintLab = [[UILabel alloc] initWithFrame:CGRectMake(self.em14_ImageView.em_right, 0, 120, 40)];
    self.em11_hintLab.textAlignment = NSTextAlignmentLeft;
    self.em11_hintLab.backgroundColor = [ZhenwupTheme_Utils em_colors_BackgroundColor];
    self.em11_hintLab.layer.cornerRadius = 20;
    self.em11_hintLab.clipsToBounds = true;
    self.em11_hintLab.textColor = [ZhenwupTheme_Utils em_colors_LightColor];
    self.em11_hintLab.text = [NSString stringWithFormat:@"  %@",EMSDKGlobalInfo.hint?:@""];
    if (EMSDKGlobalInfo.hint.length>0) {
        self.em11_hintLab.hidden=YES;
    }else{
        self.em11_hintLab.hidden=YES;
    }
    self.em11_hintLab.font = [ZhenwupTheme_Utils em_colors_LargeFont];
    [self addSubview:self.em11_hintLab];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(em14_HandleTapAction:)];
    [self addGestureRecognizer:tapGesture];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(em14_HandlePanAction:)];
    [self addGestureRecognizer:panGesture];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(em14_HandleLongPressAction:)];
    [self addGestureRecognizer:longPress];
}


- (UIView *)em14_BtnsBgView {
    if (!_em14_BtnsBgView) {
        _em14_BtnsBgView = [[UIView alloc] initWithFrame:CGRectMake(6, 1.5, self.em14_BtnsBgViewWidth, 37)];
        _em14_BtnsBgView.backgroundColor = [UIColor whiteColor];
        _em14_BtnsBgView.layer.borderColor = [ZhenwupTheme_Utils em_colors_FBBlueColor].CGColor;
        _em14_BtnsBgView.layer.borderWidth = 0.5;
        _em14_BtnsBgView.layer.cornerRadius = 16;
        _em14_BtnsBgView.layer.masksToBounds = YES;
        
        UIButton *accBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        accBtn.frame = CGRectMake(41.5, 6, 40, 25);
        accBtn.backgroundColor = [ZhenwupTheme_Utils em_colors_MainColor];
        accBtn.layer.cornerRadius = 5.0;
        accBtn.layer.masksToBounds = YES;
        accBtn.titleLabel.font = [ZhenwupTheme_Utils em_colors_NormalFont];
        accBtn.tag = 101;
        [accBtn setTitle:MUUQYLocalizedString(@"EMKey_Account_Short_Text") forState:UIControlStateNormal];
        [accBtn addTarget:self action:@selector(em14_HandleClickedAccBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_em14_BtnsBgView addSubview:accBtn];
        
        UIButton *cuservicBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cuservicBtn.frame = CGRectMake(accBtn.em_right + 10, 6, 40, 25);
        cuservicBtn.backgroundColor = [ZhenwupTheme_Utils em_colors_SecondaryColor];
        cuservicBtn.layer.cornerRadius = 5.0;
        cuservicBtn.layer.masksToBounds = YES;
        cuservicBtn.titleLabel.font = [ZhenwupTheme_Utils em_colors_NormalFont];
        cuservicBtn.tag = 102;
        [cuservicBtn setTitle:MUUQYLocalizedString(@"EMKey_CustomerService_Text") forState:UIControlStateNormal];
        [cuservicBtn addTarget:self action:@selector(em14_HandleClickedCustomorServiceBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_em14_BtnsBgView addSubview:cuservicBtn];
        
        UIButton *em18_checkBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        em18_checkBtn.frame = CGRectMake(cuservicBtn.em_right + 10, 6, 40, 25);
        em18_checkBtn.backgroundColor = [ZhenwupTheme_Utils em_colors_OthersColor];
        em18_checkBtn.layer.cornerRadius = 5.0;
        em18_checkBtn.layer.masksToBounds = YES;
        em18_checkBtn.titleLabel.font = [ZhenwupTheme_Utils em_colors_NormalFont];
        em18_checkBtn.tag = 103;
        [em18_checkBtn setTitle:MUUQYLocalizedString(@"EMKey_QuickCheckPurchase_Text") forState:UIControlStateNormal];
        [em18_checkBtn addTarget:self action:@selector(em14_HandleClickedCheckBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_em14_BtnsBgView addSubview:em18_checkBtn];
        em18_checkBtn.hidden = YES;
    }
    return _em14_BtnsBgView;
}

- (void)em14_u_BecameActiveCompletion:(void(^)(void))completion {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(em14_u_ResignActive) object:nil];
    [UIView animateWithDuration:0.15 animations:^{
        self.alpha = 1.0f;
        if (self.em_left <= self.superview.em_width/2) {
            self.em_left = 0;
        } else {
            self.em_right = self.superview.em_width;
        }
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
    }];
}

- (void)em14_u_ResignActive {
    [self em14_u_HidenBtns:YES completion:^{
        [UIView animateWithDuration:0.25 animations:^{
            self.alpha = 0.5f;
            
            UIEdgeInsets safeAreaInsets = UIEdgeInsetsZero;
            if (@available(iOS 11.0, *)) {
                UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
                safeAreaInsets = window.safeAreaInsets;
            }
            if (self.em_left <= self.superview.em_width/2) {
                self.em_centerX = MAX(0, safeAreaInsets.left - 20);
            } else {
                self.em_centerX = self.superview.em_width - MAX(0, safeAreaInsets.right - 20);
            }
        }];
    }];
}

- (void)em14_u_AdsorbToEdge:(CGPoint)center {
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets safeAreaInsets = UIEdgeInsetsZero;
        if (@available(iOS 11.0, *)) {
            UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
            safeAreaInsets = window.safeAreaInsets;
        }
        if (center.x < self.superview.em_width/2) {
            self.em_left = MAX(0, safeAreaInsets.left - 20);
        } else {
            self.em_right = self.superview.em_width - MAX(0, safeAreaInsets.right - 20);
        }
    } completion:^(BOOL finished) {
        [self performSelector:@selector(em14_u_ResignActive) withObject:nil afterDelay:2.5];
    }];
}

- (void)em14_u_ShowBtns:(BOOL)animated completion:(void(^)(void))completion {
    
    
    
    if(_bview){
        [_bview removeFromSuperview];
        _bview =[[ZhenwupBottomView alloc]init];
        _bview.tag=1888;
        [_bview showInView:[self em14_CurrentVC].view];
      
    }else{
        [_bview removeFromSuperview];
        _bview =[[ZhenwupBottomView alloc]init];
        _bview.tag=1888;
        [_bview showInView:[self em14_CurrentVC].view];
        
    }
    


}
+(void)entterYouhuiView{
   
    ZhenwupBottomView *view=[[ZhenwupShortcut_View em14_u_getCurrentVC].view viewWithTag:1888];
    if(view){
        [view removeFromSuperview];
    }
    
      
        ZhenwupBottomView* _bview =[[ZhenwupBottomView alloc]init];
        _bview.tag=1888;
        [_bview showInView:[ZhenwupShortcut_View em14_u_getCurrentVC].view];
        [_bview entterYouhuiView];
      
    
}

- (UIViewController *)em14_CurrentVC {
    if (EMSDKAPI.context) {
        return EMSDKAPI.context;
    }
    
    return [ZhenwupShortcut_View em14_u_getCurrentVC];
}


+ (UIViewController *)em14_u_getCurrentVC
{
    id<UIApplicationDelegate> delegate = [UIApplication sharedApplication].delegate;
    if ([delegate respondsToSelector:@selector(window)]) {
        return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].delegate.window.rootViewController];
    }
    return [self topViewControllerWithRootViewController:[[UIApplication sharedApplication].windows lastObject].rootViewController];

}

+ (UIViewController *)topViewControllerWithRootViewController:(UIViewController*)rootViewController
{
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    }
    else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    }
    else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
        
    }
    else {
        return rootViewController;
    }
}

- (void)em14_u_HidenBtns:(BOOL)animated completion:(void(^)(void))completion {
    if (animated) {
        [UIView animateWithDuration:0.25 animations:^{
            self.em14_BtnsBgView.em_width = 0;
            self.em_width = self.em14_ImageView.em_width;
            self.em11_hintLab.hidden = true;
        } completion:^(BOOL finished) {
            self.em14_BtnsBgView.hidden = YES;
            if (completion) {
                completion();
            }
        }];
    } else {
        self.em14_BtnsBgView.em_width = 0;
        self.em14_BtnsBgView.hidden = YES;
        if (completion) {
            completion();
        }
    }
}

- (void)em14_u_ReLayoutSubViews {
    
    UIButton *ireBtn = [_em14_BtnsBgView viewWithTag:103];
    if ((EMSDKGlobalInfo.lightState << 2) == 0) {
        self.em14_BtnsBgViewWidth = 150;
        ireBtn.hidden = YES;
    } else {
        self.em14_BtnsBgViewWidth = 150 + 50;
        ireBtn.hidden = NO;
    }
}

- (void)em14_HandleTapAction1 {
    [self em14_u_BecameActiveCompletion:^{
        [self em14_u_ShowBtns:YES completion:nil];
        [self performSelector:@selector(em14_u_ResignActive) withObject:nil afterDelay:3.0];
    }];
}

- (void)em14_HandleTapAction:(UITapGestureRecognizer *)recognizer {
    [self em14_u_BecameActiveCompletion:^{
        [self em14_u_ShowBtns:YES completion:nil];
        [self performSelector:@selector(em14_u_ResignActive) withObject:nil afterDelay:3.0];
    }];
}

- (void)em14_HandlePanAction:(UIPanGestureRecognizer *)recognizer {
    UIView *topView = [[UIApplication sharedApplication].windows lastObject];
    
    CGFloat KWidth = topView.bounds.size.width;
    CGFloat KHeight = topView.bounds.size.height;
    
    
    CGPoint point = [recognizer translationInView:topView];
    
    CGFloat centerX = recognizer.view.center.x + point.x;
    CGFloat centerY = recognizer.view.center.y + point.y;
    
    CGFloat viewHalfH = recognizer.view.frame.size.height/2;
    CGFloat viewhalfW = recognizer.view.frame.size.width/2;
    
    UIEdgeInsets safeAreaInsets = UIEdgeInsetsMake(20, 0, 0, 0);
    if (@available(iOS 11.0, *)) {
        UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
        safeAreaInsets = UIEdgeInsetsMake(window.safeAreaInsets.top, window.safeAreaInsets.left, window.safeAreaInsets.bottom, window.safeAreaInsets.right);
    }
    if (centerY - viewHalfH < MAX(20, safeAreaInsets.top - 15)) {
        centerY = viewHalfH + MAX(20, safeAreaInsets.top - 15);
    }
    if (centerY + viewHalfH > KHeight - safeAreaInsets.bottom) {
        centerY = KHeight - viewHalfH - safeAreaInsets.bottom;
    }
    if (centerX - viewhalfW < MAX(0, safeAreaInsets.left - 20)){
        centerX = viewhalfW + MAX(0, safeAreaInsets.left - 20);
    }
    if (centerX + viewhalfW > KWidth - MAX(0, safeAreaInsets.right - 20)){
        centerX = KWidth - viewhalfW - MAX(0, safeAreaInsets.right - 20);
    }
    
    [UIView animateWithDuration:0.1 animations:^{
        recognizer.view.center = CGPointMake(centerX, centerY);
        [recognizer setTranslation:CGPointZero inView:topView];
    }];
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.alpha = 1.0f;
    }
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        [self em14_u_AdsorbToEdge:CGPointMake(centerX, centerY)];
    }
}

- (void)em14_HandleLongPressAction:(UILongPressGestureRecognizer *)recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        [self performSelector:@selector(em14_u_ResignActive) withObject:nil afterDelay:2.5];
    }
}

- (void)em14_HandleClickedAccBtn:(id)sender {
    [ZhenwupSDKMainView_Controller em11_showAccountView];
}

- (void)em14_HandleClickedCustomorServiceBtn:(id)sender {
    [ZhenwupSDKMainView_Controller em11_showCustomerServiceView];
}

- (void)em14_HandleClickedCheckBtn:(id)sender {
    NSDictionary *params = @{[NSString stringWithFormat:@"%@",@"game_id"] : EMSDKGlobalInfo.gameInfo.gameID?:@"", [NSString stringWithFormat:@"%@",@"userid"]:[EMSDKGlobalInfo.userInfo.userID hash_md5]?:@"", [NSString stringWithFormat:@"%@",@"token"]: [EMSDKGlobalInfo.userInfo.token hash_base64Encode]?:@""};
    BOOL em11_GvCheck = EMSDKGlobalInfo.em11_GvCheck;
    NSString *url = [ZhenwupRemoteData_Server em14_BuildFinalUrl:em11_GvCheck?MYMGUrlConfig.em14_httpsdomain.em14_returnupsBaseUrl:MYMGUrlConfig.em14_httpsdomain.em14_backupsBaseUrl WithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpAutoLoginPath andParams:params];
    
    [EMSDKGlobalInfo em14_PresendWithUrlString:url];
}

@end
