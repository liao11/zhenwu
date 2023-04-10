//
//  ZhenwupRecentNewsV.m
//  GiguoFrameWork
//
//  Created by Admin on 2021/8/17.
//  Copyright © 2021 Admin. All rights reserved.
//

#import "ZhenwupRecentNewsV.h"
#import "TKCarouselView.h"
#import "ZhenwupAccount_Server.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD+GrossExtension.h"
#import "ZhenwupW_ViewController.h"

@interface ZhenwupRecentNewsV ()

@property (nonatomic, strong) TKCarouselView *em11_carouselView;
@property (nonatomic, strong) ZhenwupAccount_Server *em11_AccountServer;
@property (nonatomic, strong) NSArray *em18_imgArr;
@end

@implementation ZhenwupRecentNewsV

- (instancetype)init {
    if (self = [super initWithCurType:@"0"]) {
        [self em14_setupViews];
    }
    return self;
}

- (void)em14_setupViews {
    
    [self em14_ShowCloseBtn:YES];
    
    [self setTitle:MUUQYLocalizedString(@"EMKey_lastNew")];
    
    self.em11_carouselView = [[TKCarouselView alloc] initWithFrame:CGRectMake(15, 50, self.em_width - 30, self.em_width/2 - 30)];
    [self addSubview:self.em11_carouselView];
    
    [self em11_getBannerListData];
}

- (void)em11_getBannerListData{
    [MBProgressHUD em14_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.em11_AccountServer em11_GetNewsListRequest:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD em14_DismissLoadingHUD];
        if (result.em14_responseCode == EM_ResponseCodeSuccess) {
            weakSelf.em18_imgArr = (NSArray *)result.em14_responeResult;
        } else {
            [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
        }
        
        [weakSelf.em11_carouselView reloadImageCount:weakSelf.em18_imgArr.count itemAtIndexBlock:^(UIImageView *imageView, NSInteger index) {
            NSDictionary *em18_Dict = weakSelf.em18_imgArr[index];
            [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",em18_Dict[@"img"]]] placeholderImage:[ZhenwupHelper_Utils imageName:@""]]; //ImageNationfeedFb
        } imageClickedBlock:^(NSInteger index) {
            NSDictionary *em18_Dict = weakSelf.em18_imgArr[index];
            //1 富文本 2 外联 3 没效果
            if ([em18_Dict[@"type"] isEqualToString:@"1"]) {
                ZhenwupW_ViewController *vc = [[ZhenwupW_ViewController alloc]init];
                
                //加载本地 html js 文件
                NSBundle *bundle = [ZhenwupHelper_Utils em14_resBundle:[ZhenwupHelper_Utils class]];
                NSString *pathStr = [bundle pathForResource:@"www" ofType:@"html"];
                NSURL *url = [NSURL fileURLWithPath:pathStr];
                NSString *html = [[NSString alloc] initWithContentsOfFile:pathStr encoding:NSUTF8StringEncoding error:nil];
                vc.em14_htstr = url;
                vc.em18_base = html;
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                [[weakSelf em14_CurrentVC] presentViewController:nav animated:YES completion:nil];
            }else if ([em18_Dict[@"type"] isEqualToString:@"2"]) {
                __weak typeof(self) weakSelf = self;
                ZhenwupW_ViewController *vc = [[ZhenwupW_ViewController alloc]init];
                vc.alhm_uString = em18_Dict[@"url"];
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                [[weakSelf em14_CurrentVC] presentViewController:nav animated:YES completion:nil];
            }
        }];
    }];
}

- (UIViewController *)em14_CurrentVC {
    if (EMSDKAPI.context) {
        return EMSDKAPI.context;
    }
    
    return [ZhenwupRecentNewsV em14_u_getCurrentVC];
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




- (void)em14_HandleClickedCloseBtn:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(em11_handleCloseRecentNewsV:)]) {
        [self.delegate em11_handleCloseRecentNewsV:self];
    }
}

- (ZhenwupAccount_Server *)em11_AccountServer {
    if (!_em11_AccountServer) {
        _em11_AccountServer = [[ZhenwupAccount_Server alloc] init];
    }
    return _em11_AccountServer;
}

@end
