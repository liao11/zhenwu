//
//  ZhenwupYouhuiView.m
//  EmpriSDK
//
//  Created by Admin on 2023/1/17.
//  Copyright © 2023 Admin. All rights reserved.
//

#import "ZhenwupYouhuiView.h"
#import "ZhenwupSegView.h"
#import "ZhenwupcanGetCell.h"
#import "ZhenwupcanUseCell.h"
#import "ZhenwupShowView.h"
@interface ZhenwupYouhuiView ()<UITableViewDelegate,UITableViewDataSource,EmpriSegViewDelegate>

@property (nonatomic, strong) ZhenwupAccount_Server *em11_AccountServer;
@property (nonatomic, strong) ZhenwupSegView *em14_segment;
@property (nonatomic, strong) UIView *em18_bgV;
@property (nonatomic, strong) UITableView *em14_getTable;
@property (nonatomic, strong) UITableView *em14_useTable;
@property (nonatomic, strong) NSArray *em11_getArr;
@property (nonatomic, strong) NSArray *em11_userArr;
@property (nonatomic, strong) UIImageView *em11_NodataView;

@end
@implementation ZhenwupYouhuiView
-(void)setupContent{
    //    self.backgroundColor=[UIColor clearColor];
    
    [self em14_ShowTopview:YES];
    
    self.title=@"Phiếu Ưu Đãi";
    
    [self addSubview:self.em18_bgV];
    
    [self em11_loadGetCouponListWithStr:2];
}
-(void)em14_segValeDidChange:(NSInteger)index{
    switch (index) {
        case 0:
        {
            
           
            self.em14_getTable.hidden = NO;
            self.em14_useTable.hidden = YES;
            [self em11_loadGetCouponListWithStr:2];
        }
            break;
        default:
        {
            
            self.em14_getTable.hidden = YES;
            self.em14_useTable.hidden = NO;
            [self em11_loadGetCouponListWithStr:3];
        }
            break;
    }
}

- (void)em11_loadGetCouponListWithStr:(NSInteger)em14_type{
    [MBProgressHUD em14_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.em11_AccountServer khxl_obtainCouponLsitWithzwp01_lt:em14_type responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD em14_DismissLoadingHUD];
        if (result.em14_responseCode == EM_ResponseCodeSuccess) {
            if (em14_type == 2) {
                weakSelf.em11_getArr = (NSArray *)result.em14_responeResult;
                [weakSelf.em14_getTable reloadData];
            }else if (em14_type == 3) {
                weakSelf.em11_userArr = (NSArray *)result.em14_responeResult;
                [weakSelf.em14_useTable reloadData];
            }
            
        } else {
            [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
        }
        
        if (em14_type == 2) {
            weakSelf.em11_NodataView.hidden = weakSelf.em11_getArr.count > 0;
        }else if (em14_type == 3) {
            weakSelf.em11_NodataView.hidden = weakSelf.em11_userArr.count > 0;
        }
    }];
}

- (void)em14_getCouponAskWithem14_couponId:(NSInteger)em14_couponId {
    [MBProgressHUD em14_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.em11_AccountServer zwp01_saveCouponLsitWithem_couponId:em14_couponId responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD em14_DismissLoadingHUD];
        if (result.em14_responseCode == EM_ResponseCodeSuccess) {
            [weakSelf em11_loadGetCouponListWithStr:2];
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
    if (tableView == self.em14_getTable) {
        return self.em11_getArr.count;
    }else{
        return self.em11_userArr.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.em14_getTable) {
        ZhenwupcanGetCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZhenwupcanGetCell class]) forIndexPath:indexPath];
        
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
    } else {
        ZhenwupcanUseCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZhenwupcanUseCell class]) forIndexPath:indexPath];
        if (self.em11_userArr.count > 0) {
            NSDictionary *khxl_getDict = self.em11_userArr[indexPath.row];
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
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.em14_getTable) {
        
        ZhenwupShowView *xlAlertView = [[ZhenwupShowView alloc] initWithTitle:@"" message:@"Nhận Coupon hay không" sureBtn:@"Xác nhận" cancleBtn:@"Hủy bỏ"];
        xlAlertView.resultIndex = ^(NSInteger index){
        //回调---处理一系列动作
            NSDictionary *khxl_getDict = self.em11_getArr[indexPath.row];
            [self em14_getCouponAskWithem14_couponId:[khxl_getDict[@"coupon_id"] integerValue]];
        };
        [xlAlertView showXLAlertView];
        
        
    }else{
        
        ZhenwupShowView *xlAlertView = [[ZhenwupShowView alloc] initWithTitle:@"" message:@"Sử dụng Coupon" sureBtn:@"Xác nhận" cancleBtn:@"Hủy bỏ"];
        xlAlertView.resultIndex = ^(NSInteger index){
        //回调---处理一系列动作
            NSDictionary *params = @{[NSString stringWithFormat:@"%@",@"game_id"] : EMSDKGlobalInfo.gameInfo.gameID?:@"", [NSString stringWithFormat:@"%@",@"userid"]:[EMSDKGlobalInfo.userInfo.userID hash_md5]?:@"", [NSString stringWithFormat:@"%@",@"token"]: [EMSDKGlobalInfo.userInfo.token hash_base64Encode]?:@""};
            NSString *url = [ZhenwupRemoteData_Server em14_BuildFinalUrl:MYMGUrlConfig.em14_httpsdomain.em14_backupsBaseUrl WithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpAutoLoginPath andParams:params];
            [EMSDKGlobalInfo em14_PresendWithUrlString:url];
        };
        
        
        [xlAlertView showXLAlertView];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

#pragma  mark lazy load

- (UIView *)em18_bgV{
    if (!_em18_bgV) {
        _em18_bgV = [[UIView alloc] initWithFrame:CGRectMake(0, 55, self.em_width, self.em_height - 55 - 25)];
        
        
        self.em14_segment = [[ZhenwupSegView alloc] initWithTitleArr:@[MUUQYLocalizedString(@"EMKey_canObtain"), MUUQYLocalizedString(@"EMKey_canUse")] WithFrame:CGRectMake(80, 0, _em18_bgV.em_width-160, 30)];
        self.em14_segment.delegate=self;
        [_em18_bgV addSubview:self.em14_segment];
        
        
//
        
        self.em14_getTable = [[UITableView alloc] initWithFrame:CGRectMake(20, self.em14_segment.em_bottom, _em18_bgV.em_width-40, _em18_bgV.em_height - self.em14_segment.em_bottom) style:UITableViewStylePlain];
        self.em14_getTable.backgroundColor = [UIColor clearColor];
        
        self.em14_getTable.delegate = self;
        self.em14_getTable.dataSource = self;
        self.em14_getTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.em14_getTable.tableFooterView = [UIView new];
        [self.em14_getTable registerClass:[ZhenwupcanGetCell class] forCellReuseIdentifier:NSStringFromClass([ZhenwupcanGetCell class])];
        [_em18_bgV addSubview:self.em14_getTable];
        
        self.em14_useTable = [[UITableView alloc] initWithFrame:self.em14_getTable.frame style:UITableViewStylePlain];
        self.em14_useTable.backgroundColor = [UIColor clearColor];
        self.em14_useTable.hidden = YES;
        self.em14_useTable.delegate = self;
        self.em14_useTable.dataSource = self;
        self.em14_useTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.em14_useTable.tableFooterView = [UIView new];
        [self.em14_useTable registerClass:[ZhenwupcanUseCell class] forCellReuseIdentifier:NSStringFromClass([ZhenwupcanUseCell class])];
        [_em18_bgV addSubview:self.em14_useTable];
        
        self.em11_NodataView.frame = CGRectMake(_em18_bgV.em_width/2-100, self.em14_segment.em_bottom+150, 200, 200);
        
        
        
        self.em11_NodataView.hidden=YES;
    }
    return _em18_bgV;
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
        _em11_NodataView.image=[ZhenwupHelper_Utils imageName:@"zhenwuimwarn1"];
        [_em18_bgV addSubview:_em11_NodataView];
    }
    return _em11_NodataView;
}

@end
