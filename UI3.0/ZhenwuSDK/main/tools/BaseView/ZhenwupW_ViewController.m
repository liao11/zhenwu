
#import "ZhenwupW_ViewController.h"
#import "ZhenwupOpenAPI.h"
#import <WebKit/WebKit.h>
#import "ZhenwupHelper_Utils.h"
#import "ZhenwupAccount_Server.h"
#import "MBProgressHUD+GrossExtension.h"
#import "AppDelegate.h"
@interface ZhenwupW_ViewController ()<WKNavigationDelegate,WKScriptMessageHandler,WKUIDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) ZhenwupAccount_Server *em11_AccountServer;
@end

@implementation ZhenwupW_ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (instancetype)initWithem_meetData:(NSString *)em_meetData em11_exp:(NSString *)em11_exp{
    self = [super init];
    if (self) {
        self.em_meetData = em_meetData;
        self.em11_exp = em11_exp;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    self.view.backgroundColor=[UIColor whiteColor];
    NSLog(@"哈哈哈");
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction:)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshAction:)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
    
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
    
    [self.view addSubview:self.webView];
    
    _webView.frame = self.view.bounds;
    
    
}



- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
        
    _webView.frame = self.view.bounds;
}

- (void)doneAction:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)refreshAction:(id)sender {
    [self.webView reload];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [ZhenwupOpenAPI zwp01_setShortCutHidden:NO];
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
        [dic setValue:self.em11_exp?:@"" forKey:@"exp"];
        [dic setValue:@"vn" forKey:@"lang"];
        [dic setValue:EMSDKAPI.gameInfo.gameID forKey:@"gameid"];
        [self sendFuncTo:@"getBaseInfo" sendTojsPrama:dic];
    }
    else if ([message.name isEqualToString:@"getBindList"]){
        [self em_obtainRoleInfo];
    }
    else if ([message.name isEqualToString:@"getPresent"]){
//        NSLog(@"%@",message.body);
        NSDictionary *dict = [ZhenwupW_ViewController dictionaryWithJsonString:message.body];
        [self em18_exchangePresentem14_GameId:dict[@"serve_id"] em14_roleId:dict[@"role_id"]];
    }
    else if ([message.name isEqualToString:@"clseV"]){
        [self dismissViewControllerAnimated:true completion:nil];
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
        _webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:cf];
        _webView.UIDelegate=self;
        _webView.backgroundColor=[UIColor clearColor];
        _webView.opaque = NO;
        _webView.navigationDelegate = self;

        
    }
    return _webView;
}


@end
