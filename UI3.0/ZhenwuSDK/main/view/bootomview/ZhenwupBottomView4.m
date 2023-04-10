//
//  ZhenwupBottomView4.m
//  EmpriSDK
//
//  Created by Admin on 2023/1/17.
//  Copyright © 2023 Admin. All rights reserved.
//

#import "ZhenwupBottomView4.h"
#import "ZhenwupTheme_Utils.h"
#import "ZhenwupRelayoutBtn.h"
#import "ZhenwupInfoView.h"
#import "ZhenwupAccountEditView.h"
#import "ZhenwupRecordView.h"
#import "ZhenwupBangMobileView.h"
#import "ZhenwupBangEmailView.h"
#import "ZhenwupCustomerView.h"
#import "ZhenwupAccountUpView.h"
#import "GrossAlertCrlV.h"
#import "ZhenwupRelayoutBtn2.h"
#import "ZhenwupSDKMainView_Controller.h"
#define EM_RGBA(r,g,b,a)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]


#define ButtonbgColor  EM_RGBA(37, 38, 48, 1)

@interface ZhenwupBottomView4 ()

@property (nonatomic, strong) ZhenwupAccount_Server *em11_AccountServer;
@property (nonatomic, strong) UIView *em18_bgV;

@property (nonatomic, strong)UILabel *lab;


@end

@implementation ZhenwupBottomView4


-(void)setupContent{
    
    [self em14_ShowTopview:NO];

    NSString * em11_account = [NSString stringWithFormat:@"M%@",EMSDKGlobalInfo.userInfo.userID];

    
    _lab = [[UILabel alloc] initWithFrame:CGRectMake(60, 65, self.em_width-120, 36)];
    
    _lab.font = [ZhenwupTheme_Utils em_colors_LargestFont];
    _lab.text=em11_account;
    _lab.textColor = [ZhenwupTheme_Utils khxl_SmallGrayColor];
    _lab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_lab];
    
    
    [self addSubview:self.em18_bgV];
    
    
 
    
    ZhenwupRelayoutBtn2 *em14_personInfoBtn=[[ZhenwupRelayoutBtn2 alloc]initWithFrame: CGRectMake( (self.em18_bgV.em_width - 4)/3 * (double)(0 % 3) ,20 + ((self.em18_bgV.em_width - 4)/3+2)* (0/3), (self.em18_bgV.em_width - 4)/3, (self.em18_bgV.em_width - 4)/3)];
    em14_personInfoBtn.backgroundColor=ButtonbgColor;
    em14_personInfoBtn.imagestr=@"zhenwuimUserInfo";
    em14_personInfoBtn.titlestr=MUUQYLocalizedString(@"EMKey_userDt");
    em14_personInfoBtn.tag = 100;
    em14_personInfoBtn.num=2;
    [em14_personInfoBtn addTarget:self action:@selector(em14_btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.em18_bgV addSubview:em14_personInfoBtn];
    
    
    ZhenwupRelayoutBtn2 *em_pwdBtn=[[ZhenwupRelayoutBtn2 alloc]initWithFrame: CGRectMake( 2+(self.em18_bgV.em_width - 4)/3 * (double)(1 % 3) ,20 + ((self.em18_bgV.em_width - 4)/3+2)* (1/3), (self.em18_bgV.em_width - 4)/3, (self.em18_bgV.em_width - 4)/3)];
    em_pwdBtn.backgroundColor=ButtonbgColor;
    em_pwdBtn.imagestr=@"zhenwuimrevisePwd";
    em_pwdBtn.titlestr=MUUQYLocalizedString(@"EMKey_revisePsd");
    em_pwdBtn.tag = 101;
    em_pwdBtn.num=2;
    
    
 
    [em_pwdBtn addTarget:self action:@selector(em14_btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.em18_bgV addSubview:em_pwdBtn];
    if ((EMSDKGlobalInfo.userInfo.accountType == 1 || EMSDKGlobalInfo.userInfo.accountType == 6)) {
        em_pwdBtn.enabled = true;
        em_pwdBtn.num1=0;
    }else{
        em_pwdBtn.enabled = false;
        em_pwdBtn.num1=1;
    }
    
    
    // 充值记录

    
    
    ZhenwupRelayoutBtn2 *em18_userBtn=[[ZhenwupRelayoutBtn2 alloc]initWithFrame:CGRectMake(4+ (self.em18_bgV.em_width - 4)/3 * (double)(2 % 3) ,20 + ((self.em18_bgV.em_width - 4)/3+2)* (2/3), (self.em18_bgV.em_width - 4)/3, (self.em18_bgV.em_width - 4)/3)];
    em18_userBtn.backgroundColor=ButtonbgColor;
    em18_userBtn.imagestr=@"zhenwuimjilu";
    em18_userBtn.titlestr=@"Lịch sử nạp";
    em18_userBtn.tag = 102;
    em18_userBtn.num=2;
    
    [em18_userBtn addTarget:self action:@selector(em14_btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.em18_bgV addSubview:em18_userBtn];
   
    
   
    
    
    
    
    ZhenwupRelayoutBtn2 *em11_mailBtn=[[ZhenwupRelayoutBtn2 alloc]initWithFrame:  CGRectMake( 0+(self.em18_bgV.em_width - 4)/3 * (double)(3 % 3) ,20 + ((self.em18_bgV.em_width - 4)/3+2)* (3/3), (self.em18_bgV.em_width - 4)/3, (self.em18_bgV.em_width - 4)/3)];
    em11_mailBtn.backgroundColor=ButtonbgColor;
    em11_mailBtn.imagestr=@"zhenwuimmail";
    em11_mailBtn.titlestr=MUUQYLocalizedString(@"EMKey_tiMail");
    em11_mailBtn.tag = 103;
    em11_mailBtn.num=2;
    
    
    
   
    [em11_mailBtn addTarget:self action:@selector(em14_btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.em18_bgV addSubview:em11_mailBtn];

    if (((EMSDKGlobalInfo.userInfo.accountType == 2) ||(EMSDKGlobalInfo.userInfo.accountType == 3) || ((EMSDKGlobalInfo.userInfo.accountType == 6) && !EMSDKGlobalInfo.userInfo.isBindEmail))) {
        em11_mailBtn.enabled = true;
        em11_mailBtn.num1=0;
    }else{
        em11_mailBtn.num1=1;
        em11_mailBtn.enabled = false;
    }
    
    ZhenwupRelayoutBtn2 *zwp01_telBtn=[[ZhenwupRelayoutBtn2 alloc]initWithFrame: CGRectMake(2+ (self.em18_bgV.em_width - 4)/3 * (double)(4 % 3) ,20 + ((self.em18_bgV.em_width - 4)/3+2)* (4/3), (self.em18_bgV.em_width - 4)/3, (self.em18_bgV.em_width - 4)/3)];
    zwp01_telBtn.backgroundColor=ButtonbgColor;
    zwp01_telBtn.imagestr=@"zhenwuimtieTel";
    zwp01_telBtn.titlestr=MUUQYLocalizedString(@"EMKey_tiTel");
    zwp01_telBtn.tag = 104;
    zwp01_telBtn.num=2;
   
    [zwp01_telBtn addTarget:self action:@selector(em14_btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.em18_bgV addSubview:zwp01_telBtn];
    if (!EMSDKGlobalInfo.userInfo.isBindMobile) {
        zwp01_telBtn.enabled = true;
        zwp01_telBtn.num1=0;
    }else{
        zwp01_telBtn.num1=1;
        zwp01_telBtn.enabled = false;
    }
    
    ZhenwupRelayoutBtn2 *khxl_cusBtn=[[ZhenwupRelayoutBtn2 alloc]initWithFrame:  CGRectMake( 4+(self.em18_bgV.em_width - 4)/3 * (double)(5 % 3) ,20 + ((self.em18_bgV.em_width - 4)/3+2)* (5/3), (self.em18_bgV.em_width - 4)/3, (self.em18_bgV.em_width - 4)/3)];
    khxl_cusBtn.backgroundColor=ButtonbgColor;
    khxl_cusBtn.imagestr=@"zhenwuimcustomerSer";
    khxl_cusBtn.titlestr=MUUQYLocalizedString(@"EMKey_CustomerService_Text");
    khxl_cusBtn.tag = 105;
    khxl_cusBtn.num=2;
    
    
    [khxl_cusBtn addTarget:self action:@selector(em14_btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.em18_bgV addSubview:khxl_cusBtn];
    
    
    ZhenwupRelayoutBtn2 *shenji_Btn=[[ZhenwupRelayoutBtn2 alloc]initWithFrame:CGRectMake( (self.em18_bgV.em_width - 4)/3 * (double)(6 % 3) ,20 + ((self.em18_bgV.em_width - 4)/3+2)* (6/3), (self.em18_bgV.em_width - 4)/3, (self.em18_bgV.em_width - 4)/3)];
    shenji_Btn.backgroundColor=ButtonbgColor;
    shenji_Btn.imagestr=@"zhenwuimshenji";
    shenji_Btn.titlestr=@"Thăng cấp tài khoản";
    shenji_Btn.tag = 106;
    shenji_Btn.num=2;
    
    
   
    [shenji_Btn addTarget:self action:@selector(em14_btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.em18_bgV addSubview:shenji_Btn];
    
    if ((EMSDKGlobalInfo.userInfo.accountType == 2)) {
        shenji_Btn.enabled = true;
        shenji_Btn.num1=0;
    }else{
        shenji_Btn.num1=1;
        shenji_Btn.enabled = false;
    }
    
    
    
    ZhenwupRelayoutBtn2 *em_destoryBtn=[[ZhenwupRelayoutBtn2 alloc]initWithFrame: CGRectMake(2+ (self.em18_bgV.em_width - 4)/3 * (double)(7 % 3) ,20 + ((self.em18_bgV.em_width - 4)/3+2)* (7/3), (self.em18_bgV.em_width - 4)/3, (self.em18_bgV.em_width - 4)/3)];
    em_destoryBtn.backgroundColor=ButtonbgColor;
    em_destoryBtn.imagestr=@"zhenwuimAccDel";
    em_destoryBtn.titlestr=MUUQYLocalizedString(@"EMKey_AccDel");
    em_destoryBtn.tag = 107;
    em_destoryBtn.num=2;
    
   
    [em_destoryBtn addTarget:self action:@selector(em14_btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.em18_bgV addSubview:em_destoryBtn];
    
    
    
    
    
    
    
    
}
- (void)em14_btnClick:(UIButton *)btn
{
    WeakSelf;
    if (btn.tag == 100) {

        
        
        ZhenwupInfoView*view=[[ZhenwupInfoView alloc]initWithFrame:CGRectMake(0, 0, self.em_width, self.em_height)];
        
        
        [self addSubview:view];

    }else if (btn.tag == 101) {
        ZhenwupAccountEditView*view=[[ZhenwupAccountEditView alloc]initWithFrame:CGRectMake(0, 0, self.em_width, self.em_height)];
        
        
        [self addSubview:view];
        
        
      
    }else if (btn.tag == 102) {
        
        ZhenwupRecordView*view=[[ZhenwupRecordView alloc]initWithFrame:CGRectMake(0, 0, self.em_width, self.em_height)];
        
        
        [self addSubview:view];
        
    }else if (btn.tag == 103) {
        ZhenwupBangEmailView*view=[[ZhenwupBangEmailView alloc]initWithFrame:CGRectMake(0, 0, self.em_width, self.em_height)];
        
        
        [self addSubview:view];
        
        
       
    }else if (btn.tag == 104) {
        ZhenwupBangMobileView*view=[[ZhenwupBangMobileView alloc]initWithFrame:CGRectMake(0, 0, self.em_width, self.em_height)];
        
        
        [self addSubview:view];
       
    }else if (btn.tag == 105) {
        ZhenwupCustomerView*view=[[ZhenwupCustomerView alloc]initWithFrame:CGRectMake(0, 0, self.em_width, self.em_height)];
        
        
        [self addSubview:view];
        
       
    }else if (btn.tag == 106) {
        
        
        ZhenwupAccountUpView*view=[[ZhenwupAccountUpView alloc]initWithFrame:CGRectMake(0, 0, self.em_width, self.em_height)];
        
        
        [self addSubview:view];
    }else if (btn.tag == 107) {
        

        WeakSelf;
        [GrossAlertCrlV showAlertTitle:MUUQYLocalizedString(@"EMKey_AccDel") message:MUUQYLocalizedString(@"EMKey_isAccDel") actionBlock:^(NSString * _Nonnull btnTitle, NSInteger btnIndex) {
            if (btnIndex == 1) {
                NSLog(@"-------确定--------");
                [MBProgressHUD em14_ShowLoadingHUD];
                [weakSelf em_delAccAction];
            }
        } cancelButtonTitle:MUUQYLocalizedString(@"EMKey_CancelButton_Text") otherButtonTitles:@[MUUQYLocalizedString(@"EMKey_ConfirmButton_Text")]];
    }
    
    
}
- (void)em_delAccAction{
    [self.em11_AccountServer em14_delAccResponseBlock:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD em14_DismissLoadingHUD];
        if (result.em14_responseCode == EM_ResponseCodeSuccess) {
            [MBProgressHUD em14_showSuccess_Toast:MUUQYLocalizedString(@"EMKey_successAccDel")];
            [ZhenwupSDKMainView_Controller em11_logoutAction];
            if (self.closedViewCompleted) {
                self.closedViewCompleted();
            }
            
        } else {
            [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
        }
    }];
}

- (UIView *)em18_bgV{
    if (!_em18_bgV) {
        _em18_bgV = [[UIView alloc] initWithFrame:CGRectMake(30, _lab.em_bottom+15, self.em_width-60, self.em_height - _lab.em_bottom - 50)];
    }
    return _em18_bgV;
}

- (ZhenwupAccount_Server *)em11_AccountServer {
    if (!_em11_AccountServer) {
        _em11_AccountServer = [[ZhenwupAccount_Server alloc] init];
    }
    return _em11_AccountServer;
}
@end
