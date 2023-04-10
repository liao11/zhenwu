//
//  ZhenwupBottomView3.m
//  EmpriSDK
//
//  Created by Admin on 2023/1/17.
//  Copyright © 2023 Admin. All rights reserved.
//

#import "ZhenwupBottomView3.h"
#import "ZhenwupAccount_Server.h"
#import "ZhenwupHelper_Utils.h"
#import "ZhenwupIntergralShopCell.h"
#import "UIImageView+WebCache.h"
#import "ZhenwupSDKGlobalInfo_Entity.h"
#import "NSString+GrossExtension.h"
#import "ZhenwupSegView.h"
@interface ZhenwupBottomView3 ()<UICollectionViewDataSource, UICollectionViewDelegate,EmpriSegViewDelegate>

@property (nonatomic, strong) ZhenwupAccount_Server *em11_AccountServer;
@property (nonatomic, strong) ZhenwupSegView *em14_segment;
@property (nonatomic, strong) UIView *em18_bgV;
@property (nonatomic, strong) UICollectionView *em_collect;

@property (nonatomic, strong) NSArray *em11_typeArr;
@property (nonatomic, strong) NSMutableArray *zwp01_itemArr;
@property (nonatomic, strong) UIImageView *em11_NodataView;

@end
@implementation ZhenwupBottomView3

-(void)setupContent{
    [self em14_ShowTopview:NO];
   
    
    [self addSubview:self.em18_bgV];
    
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemWidth = (self.em18_bgV.em_width - 60) / 2;
    layout.itemSize = CGSizeMake(itemWidth, itemWidth+45);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 20, 10);
    
    self.em_collect = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 35, self.em18_bgV.em_width-20, self.em18_bgV.em_height - 20) collectionViewLayout:layout];
    [self.em_collect registerClass:[ZhenwupIntergralShopCell class] forCellWithReuseIdentifier:@"EM_IntergralShopCellID"];
    self.em_collect.dataSource = self;
    self.em_collect.delegate = self;
    self.em_collect.backgroundColor = [UIColor clearColor];
    
    

    
    [self.em18_bgV addSubview:self.em_collect];
    
    self.em11_NodataView.frame = CGRectMake(_em18_bgV.em_width/2-90, 150, 180, 180);
    self.em11_NodataView.hidden=YES;
//    [self em14_getGoodType];
    
  
        
}

- (void)em14_getGoodType{
    [MBProgressHUD em14_ShowLoadingHUD];
    __weak typeof(self) weakSelf = self;
    [self.em11_AccountServer em11_getGoodTypeRequest:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD em14_DismissLoadingHUD];
        if (result.em14_responseCode == EM_ResponseCodeSuccess) {
            weakSelf.em11_typeArr = (NSArray *)result.em14_responeResult;
            if (weakSelf.em11_typeArr.count > 0) {
                [weakSelf em11_buildSegmentWithzwp01_arr:(NSArray *)result.em14_responeResult];
            }
        } else {
            [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
        }
    }];
}

- (void)em14_getGoodWithem_goodType:(NSString *)em_goodType{
    [MBProgressHUD em14_ShowLoadingHUD];
    self.zwp01_itemArr = [NSMutableArray array];
    __weak typeof(self) weakSelf = self;
    [self.em11_AccountServer em11_getGoodListWithem_goodType:em_goodType responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        [MBProgressHUD em14_DismissLoadingHUD];
        if (result.em14_responseCode == EM_ResponseCodeSuccess) {
            weakSelf.zwp01_itemArr = [NSMutableArray arrayWithArray:(NSArray *)result.em14_responeResult];
            [weakSelf.em_collect reloadData];
            weakSelf.em11_NodataView.hidden = weakSelf.zwp01_itemArr.count > 0;
        } else {
            [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
        }
    }];
}

- (void)em11_buildSegmentWithzwp01_arr:(NSArray *)zwp01_arr{
    
    NSMutableArray *em14_namesArr = [NSMutableArray array];
    for (NSDictionary *dict in zwp01_arr) {
        [em14_namesArr addObject:dict[@"name"]];
    }
    
    
    
    self.em14_segment = [[ZhenwupSegView alloc] initWithTitleArr:em14_namesArr WithFrame:CGRectMake(10, 0, self.em18_bgV.em_width-20, 30)];
    self.em14_segment.num=1;
    self.em14_segment.delegate=self;
    [self.em18_bgV addSubview:self.em14_segment];
    
    
    [self em14_getGoodWithem_goodType:zwp01_arr[0][@"type"]];
}
-(void)em14_segValeDidChange:(NSInteger)index{
    self.em11_NodataView.hidden = YES;
    [self em14_getGoodWithem_goodType:self.em11_typeArr[index][@"type"]];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.zwp01_itemArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZhenwupIntergralShopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EM_IntergralShopCellID" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    if (self.zwp01_itemArr.count > 0) {
        
        NSDictionary*dic=self.zwp01_itemArr[indexPath.row];
        [cell.em_icon sd_setImageWithURL:[NSURL URLWithString:self.zwp01_itemArr[indexPath.row][@"img"]] placeholderImage:nil];
        cell.em11_name.text = [NSString stringWithFormat:@"%@",self.zwp01_itemArr[indexPath.row][@"name"]];
        
        if ([[NSString stringWithFormat:@"%@",dic[@"pay_type"]] isEqualToString:@"2"]) {
            cell.em18_accInter.text = [NSString stringWithFormat:@"%@ Điểm +  %@ VND",self.zwp01_itemArr[indexPath.row][@"point"],self.zwp01_itemArr[indexPath.row][@"amount"]];
        }else{
            cell.em18_accInter.text = [NSString stringWithFormat:@"%@ Điểm ",self.zwp01_itemArr[indexPath.row][@"point"]];
        }
        
        
       
        
        
        
        
        cell.em14_lastNum.text = [NSString stringWithFormat:@"Còn dư %@/%@",self.zwp01_itemArr[indexPath.row][@"used"],self.zwp01_itemArr[indexPath.row][@"total"]];
    }
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *params = @{[NSString stringWithFormat:@"%@",@"game_id"] : EMSDKGlobalInfo.gameInfo.gameID?:@"", [NSString stringWithFormat:@"%@",@"userid"]:[EMSDKGlobalInfo.userInfo.userID hash_md5]?:@"", [NSString stringWithFormat:@"%@",@"token"]: [EMSDKGlobalInfo.userInfo.token hash_base64Encode]?:@"",@"redirect_type":@"go_point_shop"};
    BOOL em11_GvCheck = EMSDKGlobalInfo.em11_GvCheck;
    NSString *url = [ZhenwupRemoteData_Server em14_BuildFinalUrl:em11_GvCheck?MYMGUrlConfig.em14_httpsdomain.em14_returnupsBaseUrl:MYMGUrlConfig.em14_httpsdomain.em14_backupsBaseUrl WithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpAutoLoginPath andParams:params];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}




- (UIView *)em18_bgV{
    if (!_em18_bgV) {
        
//        NSLog(@"%f",self.em_width);
//        CGFloat x=30;
//        
//        if(self.em_width <=375.0){
//            x=0;
//        }
        
        _em18_bgV = [[UIView alloc] initWithFrame:CGRectMake(0, 30, self.em_width-0, self.em_height - 50)];
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
