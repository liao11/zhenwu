//
//  ZhenwupRecentNewsV.m
//  GiguoFrameWork
//
//  Created by Admin on 2021/8/17.
//  Copyright © 2021 Admin. All rights reserved.
//

#import "ZhenwupRecentNews2V.h"
#import "TKCarouselView.h"
#import "ZhenwupAccount_Server.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD+GrossExtension.h"
#import "ZhenwupW_ViewController.h"
#import <WebKit/WebKit.h>
@interface ZhenwupRecentNews2V ()<WKNavigationDelegate,WKUIDelegate>

@property (nonatomic, strong) WKWebView *em11_carouselView;
@property (nonatomic, strong) ZhenwupAccount_Server *em11_AccountServer;
@property (nonatomic, strong) NSArray *em18_imgArr;
@end

@implementation ZhenwupRecentNews2V

- (instancetype)init {
    if (self = [super initWithCurType:@"4"]) {
        [self em14_setupViews];
    }
    return self;
}

- (void)em14_setupViews {
    
    [self em14_ShowCloseBtn:YES];
    
    [self setTitle:@"Thông báo"];
    
    self.bgview.image = [ZhenwupHelper_Utils imageName:@"zhenwuimbg4"];
    
    self.em14_CloseBtn.frame = CGRectMake(self.em_width-22-1, 0, 22, 22);
    self.em14_TitleLab.frame = CGRectMake(0, 20, self.em_width, 36);
    self.em14_TitleLab.textColor= [ZhenwupTheme_Utils khxl_SmalltitleColor];;
    
    
//    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"Thông báo" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];

//    self.em14_TitleLab.attributedText = string;
    
    
    
    
    self.center=CGPointMake(EMWIDTH/2, EMHEIGHT/2);
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];

    WKUserContentController *content = [[WKUserContentController alloc]init];

    NSString *jSString = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";

    WKUserScript *wkUserScript = [[WKUserScript alloc] initWithSource:jSString injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];

    // 添加自适应屏幕宽度js调用的方法

    [content addUserScript:wkUserScript];

    wkWebConfig.userContentController= content;

    self.em11_carouselView = [[WKWebView alloc]initWithFrame:CGRectMake(30, 100, self.em_width - 60, self.em_width/2 - 30) configuration:wkWebConfig];

    self.em11_carouselView.backgroundColor=[UIColor clearColor];
    self.em11_carouselView.opaque = NO;
//    self.em11_carouselView = [[WKWebView alloc] initWithFrame:CGRectMake(15, 50, self.em_width - 30, self.em_width/2 - 30)];
    [self addSubview:self.em11_carouselView];
    
    NSString *html_str = EMSDKGlobalInfo.notice;
    self.em11_carouselView.navigationDelegate = self;

        self.em11_carouselView.scrollView.delegate = self;

        self.em11_carouselView.UIDelegate = self;

   
    
    NSLog(@"富文本%@",html_str);
    [self.em11_carouselView loadHTMLString:html_str baseURL:nil];
   
}
- (void)webView:(WKWebView*)webView didFinishNavigation:(WKNavigation*)navigation {
//    [self.em11_carouselView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.background='#616465'"completionHandler:nil];
    // 改变网页内容文字颜色
    
//    [ webView evaluateJavaScript:@"document.getElementsByTagName('body')[0].style.webkitTextFillColor= '#ffffff'"completionHandler:nil];
    
    
    
    [webView evaluateJavaScript:@"document.body.scrollHeight" completionHandler:^(id result, NSError *_Nullable error) {

        //result 就是加载完成后 webView的实际高度

        //获取后返回重新布局

        NSLog(@"%@",result);

        self.em11_carouselView.frame = CGRectMake(30, 100, self.em_width - 60, [result integerValue]);

    }];

}




- (UIViewController *)em14_CurrentVC {
    if (EMSDKAPI.context) {
        return EMSDKAPI.context;
    }
    
    return [ZhenwupRecentNews2V em14_u_getCurrentVC];
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
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(em11_handleCloseRecentNews2V:)]) {
        [self.delegate em11_handleCloseRecentNews2V:self];
    }
}

- (ZhenwupAccount_Server *)em11_AccountServer {
    if (!_em11_AccountServer) {
        _em11_AccountServer = [[ZhenwupAccount_Server alloc] init];
    }
    return _em11_AccountServer;
}

@end
