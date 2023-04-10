//
//  ZhenwupBottomView1.m
//  EmpriSDK
//
//  Created by Admin on 2023/1/17.
//  Copyright © 2023 Admin. All rights reserved.
//

#import "ZhenwupBottomView1.h"
#import "TKCarouselView.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD+GrossExtension.h"
#import "ZhenwupW_ViewController.h"
#import "ZhenwupRelayoutBtn.h"
#import "ZhenwupTheme_Utils.h"
#import "ZhenwupSDKGlobalInfo_Entity.h"
#import "UIButton+Badge.h"
#import "ZhenwupTaskCell.h"
#import "ZhenwupYouhuiView.h"
#import "ZhenwupLibaoView.h"
#import "ZhenwupRelayoutBtn2.h"
#import "ZhenwupSDKMainView_Controller.h"
#define EM_RGBA(r,g,b,a)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
 
#define ButtonbgColor  EM_RGBA(37, 38, 48, 1)
@interface ZhenwupBottomView1 ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) TKCarouselView *em11_carouselView;
@property (nonatomic, strong) NSDictionary *em18_dict;
@property (nonatomic, strong) UIView *em11_mIddleView;
@property (nonatomic, strong) ZhenwupAccount_Server *em11_AccountServer;
@property (nonatomic, strong) NSArray *em18_imgArr;
@property (nonatomic, strong)UILabel *lab;
@property (nonatomic)  UILabel *comboLabel;
@property (nonatomic, strong) UITableView *em14_table;
@property (nonatomic, strong) NSArray *em11_secArr;
@property (nonatomic) NSString *user_points;
@end



@implementation ZhenwupBottomView1
- (ZhenwupAccount_Server *)em11_AccountServer {
    if (!_em11_AccountServer) {
        _em11_AccountServer = [[ZhenwupAccount_Server alloc] init];
    }
    return _em11_AccountServer;
}


-(void)setupContent{
//    self.backgroundColor=[UIColor clearColor];
    
    [self em14_ShowTopview:NO];
    
    
    self.em11_carouselView = [[TKCarouselView alloc] initWithFrame:CGRectMake(45, 30, self.em_width - 90, 105+20)];
    self.em11_carouselView.backgroundColor=[UIColor clearColor];
    [self addSubview:self.em11_carouselView];
    
    [self em11_getBannerListData];
    
    [self em11_GetUserInfo];
    
    _em11_mIddleView=[[UIView alloc]initWithFrame:CGRectMake(0, self.em11_carouselView.em_bottom+10, self.em_width, 80)];
    _em11_mIddleView.backgroundColor=[UIColor clearColor];
    [self addSubview:_em11_mIddleView];
    
    
    NSArray *em18_btnIconArr = @[@"zhenwuimqian",@"zhenwuimchong",@"zhenwuimdisc",@"zhenwuimpresent",@"zhenwuimout"];
    NSArray *em18_btnNameArr = @[MUUQYLocalizedString(@"EMKey_qiandao_Text"),MUUQYLocalizedString(@"EMKey_QuickCheckPurchase_Text"),
                                 MUUQYLocalizedString(@"EMKey_OffCount"),
                                 MUUQYLocalizedString(@"EMKey_PresentName_Text"),
                                 MUUQYLocalizedString(@"EMKey_Logout_Text")];
    
    
    CGFloat w=(_em11_mIddleView.em_width-20)/5;
    for (NSInteger i = 0; i<em18_btnIconArr.count; i++) {        
        ZhenwupRelayoutBtn2 *btn=[[ZhenwupRelayoutBtn2 alloc]initWithFrame:CGRectMake(10 + w * i ,5, w-1, 85)];
        btn.backgroundColor=[UIColor clearColor];
        btn.imagestr=em18_btnIconArr[i];
        btn.titlestr=em18_btnNameArr[i];
        btn.backgroundColor=ButtonbgColor;
        
        if(i==0){
            [btn addSubview: self.comboLabel];
            self.comboLabel.frame=CGRectMake(10 + w * i ,20, w-1, 45);
            self.comboLabel.hidden=YES;
        }
        
        
        btn.tag = 100+i;
        [btn addTarget:self action:@selector(em14_btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_em11_mIddleView addSubview:btn];
    }
    
    
    
    
    _lab = [[UILabel alloc] initWithFrame:CGRectMake(60, _em11_mIddleView.em_bottom+20, self.em_width-120, 36)];
    
    _lab.font = [ZhenwupTheme_Utils em_colors_LargestFont];
    _lab.text=@"Trung Tâm Nhiệm Vụ";
    _lab.textColor = [ZhenwupTheme_Utils khxl_SmallGrayColor];
    _lab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_lab];
    
    
    
    [self addSubview:self.em14_table];

    [self em11_getTaskCenterData];
    
    
}


#pragma mark ban部分
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
    
    return [ZhenwupBottomView1 em14_u_getCurrentVC];
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
#pragma mark 中间按钮部分

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
    self.em18_dict = em14_dict;
    
    BOOL em14_sign = [self.em18_dict[@"is_sign"] boolValue];
    ZhenwupRelayoutBtn2 *btn8 = (ZhenwupRelayoutBtn2 *)[_em11_mIddleView viewWithTag:100];
    if (em14_sign) {
        btn8.badgeValue = @"77";
        btn8.num1=1;
        btn8.enabled = false;
    }else{
        btn8.badgeValue = @"";
        btn8.num1=0;
        btn8.enabled = true;
    }
    
    if ([[self.em18_dict[@"is_get_coupon"] stringValue] isEqualToString:@"1"]) {
        UIButton *btn = (UIButton *)[self viewWithTag:102];
        btn.badgeValue = @"";
    }
    
    if ([[self.em18_dict[@"is_get_gift"] stringValue] isEqualToString:@"1"]) {
        UIButton *btn = (UIButton *)[self viewWithTag:103];
        btn.badgeValue = @"";
    }
    
    UIButton *btn = (UIButton *)[self viewWithTag:101];
    btn.badgeValue = @"Ưu đãi";
}

-(void)em14_btnClick:(UIButton *)btn{
    if (btn.tag == 100) {

        [self em11_SignAction:btn];

            

    }else if (btn.tag == 101) {
        NSDictionary *params = @{[NSString stringWithFormat:@"%@",@"game_id"] : EMSDKGlobalInfo.gameInfo.gameID?:@"", [NSString stringWithFormat:@"%@",@"userid"]:[EMSDKGlobalInfo.userInfo.userID hash_md5]?:@"", [NSString stringWithFormat:@"%@",@"token"]: [EMSDKGlobalInfo.userInfo.token hash_base64Encode]?:@""};
        BOOL em11_GvCheck = EMSDKGlobalInfo.em11_GvCheck;
        
        NSString *url = [ZhenwupRemoteData_Server em14_BuildFinalUrl:em11_GvCheck?MYMGUrlConfig.em14_httpsdomain.em14_returnupsBaseUrl:MYMGUrlConfig.em14_httpsdomain.em14_backupsBaseUrl WithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpAutoLoginPath andParams:params];

        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
      
    }else if (btn.tag == 102) {
        
        
        ZhenwupYouhuiView*view=[[ZhenwupYouhuiView alloc]initWithFrame:CGRectMake(0, 0, self.em_width, self.em_height)];
        
        
        [self addSubview:view];
        
    }else if (btn.tag == 103) {
        ZhenwupLibaoView*view=[[ZhenwupLibaoView alloc]initWithFrame:CGRectMake(0, 0, self.em_width, self.em_height)];
        
        
        [self addSubview:view];
        
       
    }else if (btn.tag == 104) {
        if (self.closedViewCompleted) {
            self.closedViewCompleted();
        }
        [ZhenwupSDKMainView_Controller em14_showConfirmV];
//        [self dismissViewControllerAnimated:true completion:^{
//
//        }];
        
    }
}

- (void)em11_SignAction:(UIButton *)btn{
    [MBProgressHUD em14_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.em11_AccountServer lhxy_userSignRequest:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD em14_DismissLoadingHUD];
        NSDictionary *dic= result.em14_responeResult;
        
        if (result.em14_responseCode == EM_ResponseCodeSuccess) {
            self.user_points=[NSString stringWithFormat:@"%@",dic[@"point"]];
            [self showdeletecomboLabel];
            [MBProgressHUD em14_showSuccess_Toast:@"Hôm nay đã ký"];
            [self em11_GetUserInfo];
            
        }else if(result.em14_responseCode == EM_ResponseCodeApplePayCancel){
            btn.enabled = false;
            [MBProgressHUD em14_showSuccess_Toast:result.em14_responeMsg];
        }else {
            [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
        }
    }];
}


#pragma mark 任务栏

- (void)em11_getTaskCenterData{
    [MBProgressHUD em14_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.em11_AccountServer lhxy_getTaskLsitRequest:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD em14_DismissLoadingHUD];
        if (result.em14_responseCode == EM_ResponseCodeSuccess) {
            weakSelf.em11_secArr = (NSArray *)result.em14_responeResult;
        } else {
            [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
        }
        [weakSelf.em14_table reloadData];
    }];
}

#pragma mark table

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.em11_secArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier= @"EM1_TaskCellId";
    ZhenwupTaskCell *cell;
    cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(!cell){
        cell=[[ZhenwupTaskCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    
    if (self.em11_secArr.count > 0) {
        NSDictionary *khxl_taskDict = self.em11_secArr[indexPath.row];
        cell.em11_taskName.text = [NSString stringWithFormat:@"%@",khxl_taskDict[@"title"]];
        
        if ([[NSString stringWithFormat:@"%@",khxl_taskDict[@"coupon_info"][@"type"] ] isEqualToString:@"1"]) {// 送
            cell.em18_taskDetail.text = [NSString stringWithFormat:@"Hoàn tối đa %@",khxl_taskDict[@"coupon_info"][@"give_coin"]];
        }else if ([[NSString stringWithFormat:@"%@",khxl_taskDict[@"coupon_info"][@"type"] ] isEqualToString:@"3"]){// 减
            cell.em18_taskDetail.text = [NSString stringWithFormat:@"Ưu đãi tối đa %@",khxl_taskDict[@"coupon_info"][@"reduce_amt"]];
        }else{
            cell.em18_taskDetail.text = [NSString stringWithFormat:@"%@",khxl_taskDict[@"describe"]];
        }
       
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}



#pragma  mark lazy load

- (UITableView *)em14_table{
    if (!_em14_table) {
        _em14_table = [[UITableView alloc] initWithFrame:CGRectMake(20, _lab.em_bottom+10, self.em_width-40, self.em_height - _lab.em_bottom-20) style:UITableViewStylePlain];
        _em14_table.delegate = self;
        _em14_table.dataSource = self;
        _em14_table.separatorStyle = UITableViewCellSeparatorStyleNone;
        _em14_table.backgroundColor = [UIColor clearColor];
        UIView *view = [UIView new];
        _em14_table.tableFooterView = view;
    }
    return _em14_table;
}

-(void)entterYouhuiView{
    
    
    ZhenwupYouhuiView*view=[[ZhenwupYouhuiView alloc]initWithFrame:CGRectMake(0, 0, self.em_width, self.em_height)];
    
    [self addSubview:view];
}
- (UILabel *)comboLabel{
    if (!_comboLabel) {
        _comboLabel = [[UILabel alloc] init];
        _comboLabel.textAlignment = NSTextAlignmentCenter;
        _comboLabel.textColor = [UIColor redColor];
        
        _comboLabel.font = [UIFont fontWithName:@"AvenirNext-BoldItalic" size:25];
//        _comboLabel.font = [ZhenwupTheme_Utils em_colors_LargeFont];
    }
    return _comboLabel;
}


// 数字跳动动画
- (void)labelDanceAnimation:(NSTimeInterval)duration {
 //透明度
 CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
 opacityAnimation.duration = 0.4 * duration;
 opacityAnimation.fromValue = @0.f;
 opacityAnimation.toValue = @1.f;
 
 //缩放
 CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
 scaleAnimation.duration = duration;
 scaleAnimation.values = @[@3.f, @1.f, @1.2f, @1.f];
 scaleAnimation.keyTimes = @[@0.f, @0.16f, @0.28f, @0.4f];
 scaleAnimation.removedOnCompletion = YES;
 scaleAnimation.fillMode = kCAFillModeForwards;
 
 CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
 animationGroup.animations = @[opacityAnimation, scaleAnimation];
 animationGroup.duration = duration;
 animationGroup.removedOnCompletion = YES;
 animationGroup.fillMode = kCAFillModeForwards;
 
 [self.comboLabel.layer addAnimation:animationGroup forKey:@"kComboAnimationKey"];
}

-(void)showdeletecomboLabel{
    self.comboLabel.hidden=NO;
    [self labelDanceAnimation:0.4];
     self.comboLabel.text = [NSString stringWithFormat:@"+ %@",self.user_points];
    [self performSelector:@selector(deletecomboLabel) withObject:nil afterDelay:0.5f];
}

-(void)deletecomboLabel{
    self.comboLabel.hidden=YES;
}

@end
