//
//  EmpriCouponV.m
//  GiguoFrameWork
//
//  Created by Admin on 2021/9/29.
//  Copyright © 2021 Admin. All rights reserved.
//

#import "ZhenwupCouponV2.h"
#import "ZhenwupcanGetCell.h"
#import "ZhenwupAccount_Server.h"
#import "MBProgressHUD+GrossExtension.h"
#import "ZhenwupHelper_Utils.h"
#import "ZhenwupcancoupCell.h"
#import "ZhenwupShortcut_View.h"
@interface ZhenwupCouponV2 ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) ZhenwupAccount_Server *em11_AccountServer;
@property (nonatomic, strong) UIView *em18_bgV;
@property (nonatomic, strong) UITableView *em14_getTable;

@property (nonatomic, strong) NSArray *em11_getArr;
@property (nonatomic, strong) NSArray *em11_userArr;
@property (nonatomic, strong) UIImageView *em11_NodataView;
@property (strong, nonatomic) UIButton *khxl_protocolBtn;
@property (strong, nonatomic) UIButton *em11_verifyProtoclBtn;
@property (strong, nonatomic) UIButton *em18_bindTelBtn;
@end

@implementation ZhenwupCouponV2


+ (instancetype)em14_SharedView {
    static ZhenwupCouponV2 *sharedShortcutView = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedShortcutView = [[ZhenwupCouponV2 alloc] init];
    });
    return sharedShortcutView;
}

+ (void)em14_ShowShort {
    UIView *topView = [EMSDKGlobalInfo em14_CurrentVC].view.window;
    
    ZhenwupCouponV2 *shortcutView = [ZhenwupCouponV2 em14_SharedView];
    if ([topView.subviews containsObject:shortcutView] == NO) {
        [shortcutView removeFromSuperview];
        [topView addSubview:shortcutView];
        
        
        
    }
    shortcutView.center=topView.center;
    [topView bringSubviewToFront:shortcutView];

}



- (instancetype)init {
    if (self = [super initWithCurType:@"0"]) {
        [self em14_setupViews];
    }
    return self;
}

- (void)em14_setupViews {
    
    [self em14_ShowCloseBtn:YES];
    
//    [self setTitle:MUUQYLocalizedString(@"EMKey_chongCord")];
    [self setTitle:MUUQYLocalizedString(@"EMKey_OffCount")];
    
    [self addSubview:self.em18_bgV];
    
    [self em11_loadGetCouponListWithStr:1];

}

- (void)em14_HandleClickedCloseBtn:(id)sender{
    
    
    [self removeFromSuperview];
    
    
    
//    if (self.delegate && [self.delegate respondsToSelector:@selector(em11_handleCloseChongCouponV:)]) {
//        [self.delegate em11_handleCloseChongCouponV:self];
//    }
}



- (void)em11_loadGetCouponListWithStr:(NSInteger)em14_type{
    [MBProgressHUD em14_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.em11_AccountServer khxl_obtainCouponLsitWithzwp01_lt:em14_type responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD em14_DismissLoadingHUD];
        if (result.em14_responseCode == EM_ResponseCodeSuccess) {
           
                weakSelf.em11_getArr = (NSArray *)result.em14_responeResult;
                [weakSelf.em14_getTable reloadData];
            
            if( [weakSelf.em11_getArr count]==0){
                [self removeFromSuperview];
            }
            
            
        } else {
            [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
        }
        
        
    }];
}

- (void)em14_getCouponAskWithem14_couponId:(NSInteger)em14_couponId {
    [MBProgressHUD em14_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.em11_AccountServer zwp01_saveCouponLsitWithem_couponId:em14_couponId responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD em14_DismissLoadingHUD];
        if (result.em14_responseCode == EM_ResponseCodeSuccess) {
            [weakSelf em11_loadGetCouponListWithStr:1];
        } else {
            [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
        }
    }];
}


#pragma mark table

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
        return self.em11_getArr.count;
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   
    ZhenwupcancoupCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZhenwupcancoupCell class]) forIndexPath:indexPath];
        
        if (self.em11_getArr.count > 0) {
            NSDictionary *khxl_getDict = self.em11_getArr[indexPath.row];
            NSString *type=[NSString stringWithFormat:@"%@",khxl_getDict[@"type"]];
            NSString *give_coin=[NSString stringWithFormat:@"%@",khxl_getDict[@"give_coin"]];
            NSString *reduce_amt=[NSString stringWithFormat:@"%@",khxl_getDict[@"reduce_amt"]];
            cell.em11_name.text = [NSString stringWithFormat:@"%@",khxl_getDict[@"title"]];
            
            cell.em18_info.text=[NSString stringWithFormat:@"Vé ưu đãi X%@",khxl_getDict[@"usage_num"]];
            
            cell.em18_info1.text = [NSString stringWithFormat:@"Đầy%@",khxl_getDict[@"order_coin"]];
            if([type isEqualToString:@"1"]){
              
                cell.em18_info2.text = [NSString stringWithFormat:@"Tặng%@",give_coin];
            }else if ([type isEqualToString:@"3"]){
                cell.em18_info2.text = [NSString stringWithFormat:@"Giảm%@",reduce_amt];
            }
           
            cell.limitTime.text = [NSString stringWithFormat:@"%@",khxl_getDict[@"limit_time"]];
           
 
        }
        
        return cell;
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

#pragma  mark lazy load

- (UIView *)em18_bgV{
    if (!_em18_bgV) {
        _em18_bgV = [[UIView alloc] initWithFrame:CGRectMake(0, 40, self.em_width, self.em_height - 40 - 25)];
        
        self.em14_CloseBtn.frame = CGRectMake(self.em_width-22-5, 5, 22, 22);
        _em18_bgV.userInteractionEnabled=YES;
        
        self.em14_getTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, _em18_bgV.em_width, _em18_bgV.em_height -60) style:UITableViewStylePlain];
        self.em14_getTable.backgroundColor = [UIColor clearColor];
        
        self.em14_getTable.delegate = self;
        self.em14_getTable.dataSource = self;
        self.em14_getTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.em14_getTable.tableFooterView = [UIView new];
        [self.em14_getTable registerClass:[ZhenwupcancoupCell class] forCellReuseIdentifier:NSStringFromClass([ZhenwupcancoupCell class])];
        [_em18_bgV addSubview:self.em14_getTable];
        
      
        
        self.em11_NodataView.frame = self.em14_getTable.frame;
        
        
        
        self.em11_NodataView.frame = self.em14_getTable.frame;
        
        self.em18_bindTelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.em18_bindTelBtn.frame = CGRectMake(_em18_bgV.em_width/2-60, self.em14_getTable.em_bottom + 10, 120, 35);
        self.em18_bindTelBtn.titleLabel.font = [ZhenwupTheme_Utils em_colors_NormalFont];
        [self.em18_bindTelBtn setBackgroundImage:[ZhenwupHelper_Utils imageName:@"zhenwuimb5"] forState:0];
        

        self.em18_bindTelBtn.layer.cornerRadius = 17.0;
        self.em18_bindTelBtn.layer.masksToBounds = YES;
        [self.em18_bindTelBtn setTitle:MUUQYLocalizedString(@"EMKey_ConfirmButton_Text") forState:UIControlStateNormal];
        [self.em18_bindTelBtn addTarget:self action:@selector(em_onClickBindTelBtn) forControlEvents:UIControlEventTouchUpInside];
        
        [_em18_bgV addSubview:self.em18_bindTelBtn];
        
        
        self.em11_verifyProtoclBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.em11_verifyProtoclBtn.frame = CGRectMake(28, self.em18_bindTelBtn.em_bottom, 35, 35);
        self.em11_verifyProtoclBtn.contentEdgeInsets = UIEdgeInsetsMake(11.5, 11.5, 11.5, 11.5);
        
        [self.em11_verifyProtoclBtn setImage:[ZhenwupHelper_Utils imageName:@"zhenwuimunPick"] forState:UIControlStateNormal];
        [self.em11_verifyProtoclBtn setImage:[ZhenwupHelper_Utils imageName:@"zhenwuimpick"] forState:UIControlStateSelected];
//        self.em11_verifyProtoclBtn.selected = true;
        [self.em11_verifyProtoclBtn addTarget:self action:@selector(onClickRegisterCheckProtoclBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_em18_bgV addSubview:self.em11_verifyProtoclBtn];
        
        
        
        self.khxl_protocolBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.khxl_protocolBtn.frame = CGRectMake(self.em11_verifyProtoclBtn.em_right+5,self.em18_bindTelBtn.em_bottom + 5,  _em18_bgV.em_width, 25);
        self.khxl_protocolBtn.titleLabel.font = [ZhenwupTheme_Utils em_colors_SmallFont];
        self.khxl_protocolBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        self.khxl_protocolBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -11.5, 0, 0);
        [self.khxl_protocolBtn setTitle:@"Hôm nay không nhắc nữa" forState:UIControlStateNormal];
        [self.khxl_protocolBtn setTitleColor:[ZhenwupTheme_Utils em_colors_GrayColor] forState:UIControlStateNormal];
//        [self.khxl_protocolBtn addTarget:self action:@selector(onClickRegisterProtoclBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_em18_bgV addSubview:self.khxl_protocolBtn];
        
        
    }
    return _em18_bgV;
}
-(void)em_onClickBindTelBtn{
    
    [ZhenwupShortcut_View entterYouhuiView];
    [self removeFromSuperview];
    
}
- (void)onClickRegisterCheckProtoclBtn:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *str = [formatter stringFromDate:date];
    if(sender.selected==YES){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:str];
    }else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:str];
    }
    
    
    
   

}

- (ZhenwupAccount_Server *)em11_AccountServer {
    if (!_em11_AccountServer) {
        _em11_AccountServer = [[ZhenwupAccount_Server alloc] init];
    }
    return _em11_AccountServer;
}

- (UIImageView *)em11_NodataView {
    if (!_em11_NodataView) {
        _em11_NodataView = [[UIImageView alloc] init];
        _em11_NodataView.contentMode = UIViewContentModeScaleAspectFit;
        [_em18_bgV addSubview:_em11_NodataView];
    }
    return _em11_NodataView;
}

@end
