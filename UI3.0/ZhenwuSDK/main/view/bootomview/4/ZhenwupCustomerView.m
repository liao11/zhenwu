//
//  ZhenwupCustomerView.m
//  EmpriSDK
//
//  Created by Admin on 2023/1/28.
//  Copyright © 2023 Admin. All rights reserved.
//

#import "ZhenwupCustomerView.h"
#define EM_RGBA(r,g,b,a)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
@interface ZhenwupCustomerView ()

@property (nonatomic, strong) ZhenwupAccount_Server *em11_AccountServer;
@property (nonatomic, strong) NSString *em11_Facebook_url;
@property (nonatomic, strong) NSString *em11_Service_email;
@property (nonatomic, strong) UIButton *feedbackBtn;
@property (nonatomic, strong) UIButton *facebookBtn;
@property (nonatomic, strong) UILabel *em11_CSKH_email;
@property (nonatomic, strong) UIButton *em18_bindTelBtn;
@end
@implementation ZhenwupCustomerView

- (ZhenwupAccount_Server *)em11_AccountServer {
    if (!_em11_AccountServer) {
        _em11_AccountServer = [[ZhenwupAccount_Server alloc] init];
    }
    return _em11_AccountServer;
}

-(void)setupContent{
    //    self.backgroundColor=[UIColor clearColor];
    
    [self em14_ShowTopview:YES];
    
    
    
    self.title=MUUQYLocalizedString(@"EMKey_CustomerServiceContact_Text");
    
    
    UIImageView *fbim=[[UIImageView alloc]initWithFrame:CGRectMake(35, 125,40, 40)];
    fbim.image=[ZhenwupHelper_Utils imageName:@"zhenwuimfb1"];
    [self addSubview:fbim];
    
    
    self.feedbackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.feedbackBtn.frame = CGRectMake(95, 125, self.em_width - 120, 40);
//    self.feedbackBtn.em_centerX = self.em_width/2;
    self.feedbackBtn.titleLabel.font = [ZhenwupTheme_Utils khxl_FontSize35];
    self.feedbackBtn.backgroundColor = [ZhenwupTheme_Utils em_colors_MainColor];
    self.feedbackBtn.layer.cornerRadius = 12.0;
    self.feedbackBtn.layer.masksToBounds = YES;
    [self.feedbackBtn setTitle:@"Bấm vào" forState:UIControlStateNormal];
    [self.feedbackBtn addTarget:self action:@selector(em11_HandleFacebookBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.feedbackBtn];
    
    
   
   
    
    
    self.facebookBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.facebookBtn.frame = CGRectMake(35, self.feedbackBtn.em_bottom + 30, self.em_width -70, 40);
   
    self.facebookBtn.layer.cornerRadius = 12.0;

    
    self.facebookBtn.backgroundColor=EM_RGBA(18, 19, 29, 1);
    [self.facebookBtn addTarget:self action:@selector(em11_HandleFeedbackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.facebookBtn];
    
    
    
    UIImageView *fbim1=[[UIImageView alloc]initWithFrame:CGRectMake(20, 8,34, 24)];
    fbim1.image=[ZhenwupHelper_Utils imageName:@"zhenwuimem"];
    [self.facebookBtn addSubview:fbim1];
    
    
    
    self.em11_CSKH_email = [[UILabel alloc] initWithFrame:CGRectMake(65, 8, self.facebookBtn.em_width - 70, 24)];
    self.em11_CSKH_email.font = [ZhenwupTheme_Utils em_colors_LargeFont];
    self.em11_CSKH_email.textColor = [ZhenwupTheme_Utils em_colors_GrayColor];
  
    [self.facebookBtn addSubview:self.em11_CSKH_email];
    
    
    self.em18_bindTelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.em18_bindTelBtn.frame = CGRectMake(0, self.facebookBtn.em_bottom + 30, 100, 35);
    self.em18_bindTelBtn.titleLabel.font = [ZhenwupTheme_Utils em_colors_NormalFont];
    self.em18_bindTelBtn.backgroundColor = [ZhenwupTheme_Utils khxl_SmalltitleColor];
    self.em18_bindTelBtn.em_centerX=self.em_width/2;

    self.em18_bindTelBtn.layer.cornerRadius = 17.0;
    self.em18_bindTelBtn.layer.masksToBounds = YES;
    [self.em18_bindTelBtn setTitle:@"Copy" forState:UIControlStateNormal];
    [self.em18_bindTelBtn addTarget:self action:@selector(em_onClickBindTCopy:) forControlEvents:UIControlEventTouchUpInside];
   
    
    [self addSubview:self.em18_bindTelBtn];
    
    
    
  
  
    
//    self.em_height = self.em11_CSKH_email.em_bottom + 15;
    
    [self em11_GetCustomerSeviceInfo];
    
    
    
}
-(void)em_onClickBindTCopy:(id)sender {
    NSString *str=EMSDKGlobalInfo.customorSeviceMail?:@"";
    if(str.length>0){
        UIPasteboard *pb = [UIPasteboard generalPasteboard];
        [pb setString:str];
        [MBProgressHUD em14_showSuccess_Toast:@"Hộp thư đã sao chép"];
        ;
    }
  
    
}
- (void)em11_showCSKHEmail:(NSString *)email  {
    if (email && email.length > 0) {
        self.em11_CSKH_email.text = [NSString stringWithFormat:@"%@", email];
    } else {
        self.em11_CSKH_email.text = [NSString stringWithFormat:@"%@", EMSDKGlobalInfo.customorSeviceMail?:@""];
    }
}

- (void)em11_HandleFeedbackBtn:(id)sender {
//    [self em14_HandleClickedCloseBtn:sender];
    
    if (!self.em11_Service_email || [self.em11_Service_email isEmpty]) {
        [MBProgressHUD em14_ShowLoadingHUD];
        __weak typeof(self) weakSelf = self;
        [self.em11_AccountServer em11_GetCustomerService:^(ZhenwupResponseObject_Entity * _Nonnull result) {
            [MBProgressHUD em14_DismissLoadingHUD];
            if (result.em14_responseCode == EM_ResponseCodeSuccess) {
                NSString *url = [result.em14_responeResult objectForKey:[NSString stringWithFormat:@"%@",@"facebook_url"]];
                NSString *email = [result.em14_responeResult objectForKey:[NSString stringWithFormat:@"%@",@"service_email"]];
                
                weakSelf.em11_Facebook_url = url;
                weakSelf.em11_Service_email = email;
                [weakSelf em11_showCSKHEmail:email];
                
                [EMSDKGlobalInfo em14_SendEmail:email];
            } else {
                [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
            }
        }];
    } else {
        [EMSDKGlobalInfo em14_SendEmail:self.em11_Service_email];
    }
}

- (void)em11_HandleFacebookBtn:(id)sender {
//    [self em14_HandleClickedCloseBtn:sender];
    
    if (!self.em11_Facebook_url || [self.em11_Facebook_url isEmpty]) {
        [MBProgressHUD em14_ShowLoadingHUD];
        __weak typeof(self) weakSelf = self;
        [self.em11_AccountServer em11_GetCustomerService:^(ZhenwupResponseObject_Entity * _Nonnull result) {
            [MBProgressHUD em14_DismissLoadingHUD];
            if (result.em14_responseCode == EM_ResponseCodeSuccess) {
                NSString *url = [result.em14_responeResult objectForKey:[NSString stringWithFormat:@"%@",@"facebook_url"]];
                NSString *email = [result.em14_responeResult objectForKey:[NSString stringWithFormat:@"%@",@"service_email"]];
                
                weakSelf.em11_Facebook_url = url;
                weakSelf.em11_Service_email = email;
                
                [weakSelf em11_showCSKHEmail:email];
                
                [EMSDKGlobalInfo em14_PresendWithUrlString:url];
            } else {
                [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
            }
        }];
    } else {
        [EMSDKGlobalInfo em14_PresendWithUrlString:self.em11_Facebook_url];
    }
}

- (void)em11_GetCustomerSeviceInfo {
    __weak typeof(self) weakSelf = self;
    [self.em11_AccountServer em11_GetCustomerService:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        if (result.em14_responseCode == EM_ResponseCodeSuccess) {
            weakSelf.em11_Facebook_url = [result.em14_responeResult objectForKey:[NSString stringWithFormat:@"%@",@"facebook_url"]];
            NSString *cskh_email = [result.em14_responeResult objectForKey:[NSString stringWithFormat:@"%@",@"service_email"]];
            weakSelf.em11_Service_email = cskh_email;
            [weakSelf em11_showCSKHEmail:cskh_email];
        } else{
            [weakSelf em11_showCSKHEmail:nil];
            [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
        }
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
