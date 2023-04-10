//
//  ZhenwupRecordView.m
//  EmpriSDK
//
//  Created by Admin on 2023/1/28.
//  Copyright © 2023 Admin. All rights reserved.
//

#import "ZhenwupRecordView.h"
#import "ZhenwupChongCell.h"
#import "ZhenwupAccount_Server.h"
#import "MBProgressHUD+GrossExtension.h"
#import "ZhenwupHelper_Utils.h"
#import "ZhenwupBiCell.h"
#import "ZhenwupSegView.h"
@interface ZhenwupRecordView ()<UITableViewDelegate,UITableViewDataSource,EmpriSegViewDelegate>

@property (nonatomic, strong) ZhenwupAccount_Server *em11_AccountServer;
@property (nonatomic, strong) UIView *em18_bgV;
@property (nonatomic, strong) UITableView *em14_recordTable;
@property (nonatomic, strong) UITableView *em11_biTable;
@property (nonatomic, strong) NSArray *em11_chongArr;
@property (nonatomic, strong) ZhenwupSegView *em14_segment;
@property (nonatomic, strong) NSArray *em14_biArr;
@property (nonatomic, strong) UIImageView *em11_NodataView;


@property (nonatomic, strong) UIView *em14_headView;
@property (nonatomic, strong) UIView *em14_headV1;
@property (nonatomic, strong) UIView *em14_headV2;


@end
@implementation ZhenwupRecordView
-(void)setupContent{
    //    self.backgroundColor=[UIColor clearColor];
    
    [self em14_ShowTopview:YES];
    
    self.title=MUUQYLocalizedString(@"EMKey_chongCord");
    
    [self addSubview:self.em18_bgV];
    
    [self em11_getChongListData];
    
//    [self em11_loadGetCouponListWithStr:2];
}
- (UIView *)em18_bgV{
    if (!_em18_bgV) {
        _em18_bgV = [[UIView alloc] initWithFrame:CGRectMake(0, 55, self.em_width, self.em_height - 55 - 25)];
        

        self.em14_segment = [[ZhenwupSegView alloc] initWithTitleArr:@[MUUQYLocalizedString(@"EMKey_chongCord"), @"Lịch sử coin"] WithFrame:CGRectMake(80, 15, _em18_bgV.em_width-160, 30)];
        self.em14_segment.delegate=self;
        [_em18_bgV addSubview:self.em14_segment];
        
        
//        self.em14_headView= self.em14_headV1;
        
        
        [_em18_bgV addSubview:self.em14_headV1];
        [_em18_bgV addSubview:self.em14_headV2];
        self.em14_headV1.hidden=NO;
        self.em14_headV2.hidden=YES;
        

        self.em14_recordTable = [[UITableView alloc] initWithFrame:CGRectMake(0,  self.em14_segment.em_bottom+55, _em18_bgV.em_width, _em18_bgV.em_height -  self.em14_segment.em_bottom-55) style:UITableViewStylePlain];
        self.em14_recordTable.backgroundColor = [UIColor clearColor];
        
        self.em14_recordTable.delegate = self;
        self.em14_recordTable.dataSource = self;
        self.em14_recordTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.em14_recordTable.tableFooterView = [UIView new];
        self.em14_recordTable.tableHeaderView = [UIView new];
        [self.em14_recordTable registerClass:[ZhenwupChongCell class] forCellReuseIdentifier:NSStringFromClass([ZhenwupChongCell class])];
        [_em18_bgV addSubview:self.em14_recordTable];
        
        self.em11_biTable = [[UITableView alloc] initWithFrame:self.em14_recordTable.frame style:UITableViewStylePlain];
        self.em11_biTable.backgroundColor = [UIColor clearColor];
        self.em11_biTable.hidden = YES;
        self.em11_biTable.delegate = self;
        self.em11_biTable.dataSource = self;
        self.em11_biTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.em11_biTable.tableFooterView = [UIView new];
        self.em11_biTable.tableHeaderView = [UIView new];
        [self.em11_biTable registerClass:[ZhenwupBiCell class] forCellReuseIdentifier:NSStringFromClass([ZhenwupBiCell class])];
        [_em18_bgV addSubview:self.em11_biTable];
        
        self.em11_NodataView.frame = CGRectMake(_em18_bgV.em_width/2-100, self.em14_segment.em_bottom+150, 200, 200);
        self.em11_NodataView.hidden=YES;
    }
    return _em18_bgV;
}

-(void)em14_segValeDidChange:(NSInteger)index{
    switch (index) {
        case 0:
        {
            

            self.em14_recordTable.hidden = NO;
            self.em11_biTable.hidden = YES;
            
            self.em14_headV1.hidden=NO;
            self.em14_headV2.hidden=YES;
            
            [self em11_getChongListData];
            [self setTitle:MUUQYLocalizedString(@"EMKey_chongCord")];
        }
            break;
        default:
        {

            self.em14_recordTable.hidden = YES;
            self.em11_biTable.hidden = NO;
            self.em14_headV1.hidden=YES;
            self.em14_headV2.hidden=NO;
            [self em11_getBiListData];
//            [self setTitle:MUUQYLocalizedString(@"EMKey_chongCord")];
        }
            break;
    }
}

- (void)em11_getChongListData{
    [MBProgressHUD em14_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.em11_AccountServer em11_GetOrderListRequest:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD em14_DismissLoadingHUD];
        if (result.em14_responseCode == EM_ResponseCodeSuccess) {
            weakSelf.em11_chongArr = (NSArray *)result.em14_responeResult;
        } else {
            [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
        }
        [weakSelf.em14_recordTable reloadData];
        weakSelf.em11_NodataView.hidden = weakSelf.em11_chongArr.count > 0;
    }];
}

- (void)em11_getBiListData{
    [MBProgressHUD em14_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.em11_AccountServer zwp01_getKionDetailRequest:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD em14_DismissLoadingHUD];
        if (result.em14_responseCode == EM_ResponseCodeSuccess) {
            weakSelf.em14_biArr = (NSArray *)result.em14_responeResult;
        } else {
            [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
        }
        [weakSelf.em11_biTable reloadData];
        weakSelf.em11_NodataView.hidden = weakSelf.em14_biArr.count > 0;
    }];
}

#pragma mark table

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.em14_recordTable) {
        return self.em11_chongArr.count;
    }else{
        return self.em14_biArr.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.em14_recordTable) {
        ZhenwupChongCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZhenwupChongCell class]) forIndexPath:indexPath];
        if (self.em11_chongArr.count > 0) {
            NSDictionary *khxl_chongDict = self.em11_chongArr[indexPath.row];
            cell.em11_chongTime.text = [NSString stringWithFormat:@"%@",khxl_chongDict[@"add_time"]];
            cell.em18_orderNum.text = [NSString stringWithFormat:@"%@",khxl_chongDict[@"order_no"]];

            cell.em11_orderMoney.text = [NSString stringWithFormat:@"%@",khxl_chongDict[@"order_amt"]];
   
            //0待付款 1 已付款 2 已发货 3 发货失败
            NSString *klxl_chongStatues = khxl_chongDict[@"pay_status"];
            if ([klxl_chongStatues isEqualToString:@"0"]) {
                cell.lhxy_statues.image = [ZhenwupHelper_Utils imageName:@"zhenwuimunChong"];
            }else if ([klxl_chongStatues isEqualToString:@"1"]) {
                cell.lhxy_statues.image = [ZhenwupHelper_Utils imageName:@"zhenwuimhasChong"];
            }else if ([klxl_chongStatues isEqualToString:@"2"]) {
                cell.lhxy_statues.image = [ZhenwupHelper_Utils imageName:@"zhenwuimsend"];
            }else if ([klxl_chongStatues isEqualToString:@"3"]) {
                cell.lhxy_statues.image = [ZhenwupHelper_Utils imageName:@"zhenwuimsendFail"];
            }
        }
        return cell;
    } else {
        ZhenwupBiCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZhenwupBiCell class]) forIndexPath:indexPath];
        if (self.em14_biArr.count > 0) {
            NSDictionary *khxl_biDict = self.em14_biArr[indexPath.row];
            cell.em11_date.text = [NSString stringWithFormat:@"%@",khxl_biDict[@"add_time"]];
            cell.em18_cost.text = [NSString stringWithFormat:@"%@",khxl_biDict[@"coin"]];
            cell.em11_channel.text = [NSString stringWithFormat:@"%@",khxl_biDict[@"type"]];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.em14_recordTable) {
        return 55;
    }else{
        return 42;
    }
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 42;
}

- (UIView *)em14_headV1 {
    if (!_em14_headV1) {
        _em14_headV1 = [[UIView alloc]initWithFrame:CGRectMake(0, self.em14_segment.em_bottom+13, self.em_width, 42)];
        _em14_headV1.backgroundColor = [UIColor clearColor];
        UIFont *contFont = [ZhenwupTheme_Utils em_colors_SmallFont];
        
//        [_em18_bgV addSubview: _em14_headV1]
        UIView *lineview=[[UIView alloc]init];
        
        lineview.frame=CGRectMake(20, 0, self.em_width-40, 0.6);
        lineview.backgroundColor=[ZhenwupTheme_Utils em_colors_DarkGrayColor];
        
        [_em14_headV1 addSubview:lineview];
        
        
        UILabel *em11_chongTime = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.em_width/4, _em14_headV1.em_height)];
        em11_chongTime.font = contFont;
        em11_chongTime.textColor = [ZhenwupTheme_Utils em_colors_DarkGrayColor];
        em11_chongTime.text = MUUQYLocalizedString(@"EMKey_chongTime");
        em11_chongTime.textAlignment = NSTextAlignmentCenter;
        em11_chongTime.adjustsFontSizeToFitWidth = true;
        em11_chongTime.numberOfLines = 0;
        [_em14_headV1 addSubview:em11_chongTime];
        
        UILabel *em18_orderNum = [[UILabel alloc] initWithFrame:CGRectMake(em11_chongTime.em_right, 0, self.em_width/4, _em14_headV1.em_height)];
        em18_orderNum.font = contFont;
        em18_orderNum.textColor = [ZhenwupTheme_Utils em_colors_DarkGrayColor];
        em18_orderNum.text = MUUQYLocalizedString(@"EMKey_chongNum");
        em18_orderNum.textAlignment = NSTextAlignmentCenter;
        em18_orderNum.adjustsFontSizeToFitWidth = true;
        [_em14_headV1 addSubview:em18_orderNum];
        
        UILabel *em11_orderMoney = [[UILabel alloc] initWithFrame:CGRectMake(em18_orderNum.em_right, 0, self.em_width/4, _em14_headV1.em_height)];
        em11_orderMoney.font = contFont;
        em11_orderMoney.textColor = [ZhenwupTheme_Utils em_colors_DarkGrayColor];
        em11_orderMoney.text = MUUQYLocalizedString(@"EMKey_chongMon");
        em11_orderMoney.textAlignment = NSTextAlignmentCenter;
        [_em14_headV1 addSubview:em11_orderMoney];
        
        UILabel *em14_statues = [[UILabel alloc] initWithFrame:CGRectMake(em11_orderMoney.em_right, 0, self.em_width/4, _em14_headV1.em_height)];
        em14_statues.font = contFont;
        em14_statues.textColor = [ZhenwupTheme_Utils em_colors_DarkGrayColor];
        em14_statues.text = MUUQYLocalizedString(@"EMKey_chongStatus");
        em14_statues.textAlignment = NSTextAlignmentCenter;
        [_em14_headV1 addSubview:em14_statues];
        
        
        
        UIView *lineview2=[[UIView alloc]init];
        
        lineview2.frame=CGRectMake(20, _em14_headV1.em_height-1, self.em_width-40, 0.6);
        lineview2.backgroundColor=[ZhenwupTheme_Utils em_colors_DarkGrayColor];
        
        [_em14_headV1 addSubview:lineview2];
    }
    return _em14_headV1;
}


- (UIView *)em14_headV2 {
    if (!_em14_headV2) {
        _em14_headV2 = [[UIView alloc]initWithFrame:CGRectMake(0, self.em14_segment.em_bottom+13, self.em_width, 42)];
        _em14_headV2.backgroundColor = [UIColor clearColor];
        
        
        UIView *lineview=[[UIView alloc]init];
        
        lineview.frame=CGRectMake(20, 0, self.em_width-40, 0.6);
        lineview.backgroundColor=[ZhenwupTheme_Utils em_colors_DarkGrayColor];
        
        [_em14_headV2 addSubview:lineview];
                UIFont *contFont = [ZhenwupTheme_Utils em_colors_SmallFont];
                UILabel *em11_data = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.em_width/3, _em14_headV2.em_height)];
                em11_data.font = contFont;
                em11_data.textColor = [ZhenwupTheme_Utils em_colors_DarkGrayColor];
                em11_data.text = MUUQYLocalizedString(@"EMKey_nowData");
                em11_data.textAlignment = NSTextAlignmentCenter;
                em11_data.adjustsFontSizeToFitWidth = true;
                em11_data.numberOfLines = 0;
                [_em14_headV2 addSubview:em11_data];
        
                UILabel *em18_cost = [[UILabel alloc] initWithFrame:CGRectMake(em11_data.em_right, 0, self.em_width/3, _em14_headV2.em_height)];
                em18_cost.font = contFont;
                em18_cost.textColor = [ZhenwupTheme_Utils em_colors_DarkGrayColor];
                em18_cost.text = MUUQYLocalizedString(@"EMKey_nowMuch");
                em18_cost.textAlignment = NSTextAlignmentCenter;
                em18_cost.adjustsFontSizeToFitWidth = true;
                [_em14_headV2 addSubview:em18_cost];
        
                UILabel *em11_channel = [[UILabel alloc] initWithFrame:CGRectMake(em18_cost.em_right, 0, self.em_width/3, _em14_headV2.em_height)];
                em11_channel.font = contFont;
                em11_channel.textColor = [ZhenwupTheme_Utils em_colors_DarkGrayColor];
                em11_channel.text = MUUQYLocalizedString(@"EMKey_nowChan");
                em11_channel.textAlignment = NSTextAlignmentCenter;
                [_em14_headV2 addSubview:em11_channel];
        
        
        
        
        UIView *lineview2=[[UIView alloc]init];
        
        lineview2.frame=CGRectMake(20, _em14_headV2.em_height-1, self.em_width-40, 0.6);
        lineview2.backgroundColor=[ZhenwupTheme_Utils em_colors_DarkGrayColor];
        
        [_em14_headV2 addSubview:lineview2];
    }
    return _em14_headV2;
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
