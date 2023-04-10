//
//  ZhenwupBottomView2.m
//  EmpriSDK
//
//  Created by Admin on 2023/1/17.
//  Copyright © 2023 Admin. All rights reserved.
//

#import "ZhenwupBottomView2.h"
#import "ZhenwupOpenAPI.h"
#import <WebKit/WebKit.h>
#import "ZhenwupHelper_Utils.h"
#import "ZhenwupAccount_Server.h"
#import "MBProgressHUD+GrossExtension.h"
#import "AppDelegate.h"
@interface ZhenwupBottomView2 ()<WKNavigationDelegate,WKScriptMessageHandler,WKUIDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) ZhenwupAccount_Server *em11_AccountServer;
@end
@implementation ZhenwupBottomView2

-(void)setupContent{
    [self em14_ShowTopview:NO];
    
//    [self em11_GetUserInfo];
    
    
    self.backgroundColor =[UIColor colorWithRed:29/255.9 green:36/255.0 blue:47/255.0 alpha:1.0];
    
    
    NSString *url = [NSString stringWithFormat:@"%@%@",MYMGUrlConfig.em14_httpsdomain.em14_baseUrl, MYMGUrlConfig.em14_rcppathconfig.em14_rcpMemberLk];
  
    self.alhm_uString = url;
  
    NSLog(@"哈哈哈");

    
    if (_alhm_uString && [_alhm_uString isKindOfClass:[NSString class]]) {
        NSURLRequest *qt = [NSURLRequest requestWithURL:[NSURL URLWithString:_alhm_uString]];
        NSLog(@"%@",_alhm_uString);
        [self.webView loadRequest:qt];
    }
    
    
    if (_em14_htstr && [_em14_htstr isKindOfClass:[NSURL class]]) {
        NSURLRequest *qt = [NSURLRequest requestWithURL:_em14_htstr];
        NSLog(@"%@",_em14_htstr);
        [self.webView loadRequest:qt];
    }
    
    [self addSubview:self.webView];
    
    _webView.frame = CGRectMake(0, 0, self.em_width, self.em_height-30);
    
   
}

- (void)em11_GetUserInfo {
    [MBProgressHUD em14_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.em11_AccountServer em11_GetUserInfo:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD em14_DismissLoadingHUD];
        [weakSelf em18_reloadUserInterface:result.em14_responeResult];
        if (result.em14_responseCode != EM_ResponseCodeSuccess) {
            [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
        }
    }];
}

- (void)em18_reloadUserInterface:(NSDictionary *)em14_dict{

    self.em11_exp = em14_dict[@"user_exp"];
    self.em_meetData = em14_dict[@"add_time"];
    self.menberArr=em14_dict[@"exp_info"];
    NSLog(@"em11_expem11_expem11_exp====%@",self.em11_exp);
    [self.webView reload];


}
- (void)doneAction:(id)sender {
   
}

- (void)refreshAction:(id)sender {
    [self.webView reload];
}



#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
  if(!message) {
    return;
  }
  
    NSLog(@"js调用的方法:%@",message.name);

  if(message.name) {
    if([message.name isEqualToString:@"BaseInfo"]) {
//        NSLog(@"%@",message.body);
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:5];
        NSLog(@"em11_expem11_expem11_exp===33333=%@",self.em11_exp);
        [dic setValue:self.em11_exp?:@"0" forKey:@"exp"];
        [dic setValue:@"vn" forKey:@"lang"];
        
        [dic setValue:self.menberArr?:@[] forKey:@"menberArr"];
        
//        self.menberArr=em14_dict[@"exp_info"];
        [dic setValue:EMSDKAPI.gameInfo.gameID forKey:@"gameid"];
        [self sendFuncTo:@"getBaseInfo" sendTojsPrama:dic];
    }
    else if ([message.name isEqualToString:@"getBindList"]){
        [self em_obtainRoleInfo];
    }
    else if ([message.name isEqualToString:@"getPresent"]){
//        NSLog(@"%@",message.body);
        NSDictionary *dict = [ZhenwupBottomView2 dictionaryWithJsonString:message.body];
        [self em18_exchangePresentem14_GameId:dict[@"serve_id"] em14_roleId:dict[@"role_id"]];
    }
    else if ([message.name isEqualToString:@"clseV"]){
//        [self dismissViewControllerAnimated:true completion:nil];
    }
    else if ([message.name isEqualToString:@"getMeetDate"]){
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:5];
        [dic setValue:self.em_meetData?:@"" forKey:@"meetdata"];
        [self sendFuncTo:@"getMeetDate" sendTojsPrama:dic];
    }
  }
}

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }

    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
//        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}



- (void)sendFuncTo:(NSString *)methodName sendTojsPrama:(id)prama {
  NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:2];
//  [dic setValue:methodName forKey:@"method"];
  [dic setValue:prama forKey:@"prama"];
  NSString *jsonStr = [[NSString alloc] initWithData:[self toJSONData:dic] encoding:NSUTF8StringEncoding];
  [self callbackToJS:jsonStr methodName:methodName];
}

- (NSData *)toJSONData:(id)theData {
  NSError *error = nil;
  NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                     options:0
                                                       error:&error];
  if ([jsonData length] > 0 && error == nil){
      return jsonData;
  } else {
      return nil;
  }
}

- (void)callbackToJS:(NSString*)jsonParam methodName:(NSString *)methodName{
//  NSString *js = [NSString stringWithFormat:@"fromIosCall('%@');", jsonParam];
    NSString * jsStr = [NSString stringWithFormat:@"%@('%@')",methodName,jsonParam];
    NSLog(@"%@",jsStr);
  [self.webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable response, NSError * _Nullable error) {
    if (response || error) {
      NSLog(@"value=======: %@ error: %@", response, error);
    }
  }];
}



- (void)em_obtainRoleInfo
{
    [MBProgressHUD em14_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.em11_AccountServer lhxy_getUserRoleRequest:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD em14_DismissLoadingHUD];
        
        if (result.em14_responseCode == EM_ResponseCodeSuccess) {
            [weakSelf sendFuncTo:@"getBindList" sendTojsPrama:result.em14_responeResult];
        } else {
            [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
        }
    }];
}

- (void)em18_exchangePresentem14_GameId:(NSString *)em14_GameId em14_roleId:(NSString *)em14_roleId
{
    [MBProgressHUD em14_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.em11_AccountServer lhxy_exchangePresentWithGameId:em14_GameId em14_roleId:em14_roleId Request:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD em14_DismissLoadingHUD];
        
//        [weakSelf sendFuncTo:@"getPresentMsg" sendTojsPrama:result.em14_responeMsg];
        
        if (result.em14_responseCode == EM_ResponseCodeSuccess) {
            [MBProgressHUD em14_showSuccess_Toast:MUUQYLocalizedString(@"EMKey_vipRoleObtainPresent")];
        } else {
            [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
        }
    }];
}

- (ZhenwupAccount_Server *)em11_AccountServer {
    if (!_em11_AccountServer) {
        _em11_AccountServer = [[ZhenwupAccount_Server alloc] init];
    }
    return _em11_AccountServer;
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return nil;
}
- (WKWebView*)webView {
    if(!_webView) {
        WKWebViewConfiguration *cf = [[WKWebViewConfiguration alloc] init];
        WKUserContentController *userContentController =[[WKUserContentController alloc]init];
     
       
    [userContentController addScriptMessageHandler:self name:@"BaseInfo"];
       
    [userContentController addScriptMessageHandler:self name:@"getBindList"];
   
     [userContentController addScriptMessageHandler:self name:@"getPresent"];

     [userContentController addScriptMessageHandler:self name:@"clseV"];
    [userContentController addScriptMessageHandler:self name:@"getMeetDate"];
        
        
        
        cf.userContentController = userContentController;
        _webView = [[WKWebView alloc] initWithFrame:self.bounds configuration:cf];
        _webView.UIDelegate=self;
        _webView.backgroundColor=[UIColor clearColor];
        _webView.opaque = NO;
        _webView.navigationDelegate = self;

        
    }
    return _webView;
}
// 加载完毕
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSString *injectionJSString = @"var script = document.createElement('meta');"
    "script.name = 'viewport';"
    "script.content=\"width=device-width, user-scalable=no\";"
    "document.getElementsByTagName('head')[0].appendChild(script);";
    [webView evaluateJavaScript:injectionJSString completionHandler:nil];
}

@end
