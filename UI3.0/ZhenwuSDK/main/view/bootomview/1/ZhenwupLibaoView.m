//
//  ZhenwupLibaoView.m
//  EmpriSDK
//
//  Created by Admin on 2023/1/17.
//  Copyright © 2023 Admin. All rights reserved.
//

#import "ZhenwupLibaoView.h"
#import "ZhenwupSegView.h"
#import "ZhenwupLibaoCell1.h"
#import "ZhenwupLibaoCell2.h"
#import "ZhenwupShowView.h"
@interface ZhenwupLibaoView ()<UICollectionViewDataSource, UICollectionViewDelegate,EmpriSegViewDelegate>

@property (nonatomic, strong) ZhenwupAccount_Server *em11_AccountServer;
@property (nonatomic, strong) ZhenwupSegView *em14_segment;
@property (nonatomic, strong) UIView *em18_bgV;

@property (nonatomic, strong) UICollectionView *em_all_collect;
@property (nonatomic)NSInteger type;
@property (nonatomic, strong) NSMutableArray *em11_all_Presents;
@property (nonatomic, strong) UIImageView *em11_NodataView;

@end
@implementation ZhenwupLibaoView

- (ZhenwupAccount_Server *)em11_AccountServer {
    if (!_em11_AccountServer) {
        _em11_AccountServer = [[ZhenwupAccount_Server alloc] init];
    }
    return _em11_AccountServer;
}
-(void)setupContent{
    //    self.backgroundColor=[UIColor clearColor];
    
    [self em14_ShowTopview:YES];
    self.type=1;
    self.title=@"Nhận lễ bao";
    _em11_all_Presents=[[NSMutableArray alloc]init];
    [self addSubview:self.em18_bgV];
    
    [self em11_GetAllPresentList];
    [self em14_segValeDidChange:0];
}
#pragma  mark lazy load

- (UIView *)em18_bgV{
    if (!_em18_bgV) {
        _em18_bgV = [[UIView alloc] initWithFrame:CGRectMake(0, 55, self.em_width, self.em_height - 55 - 25)];
        

        self.em14_segment = [[ZhenwupSegView alloc] initWithTitleArr:@[MUUQYLocalizedString(@"EMKey_AllPresent_Text"), MUUQYLocalizedString(@"EMKey_MyPresent_Text")] WithFrame:CGRectMake(80, 0, _em18_bgV.em_width-160, 30)];
        self.em14_segment.delegate=self;
        [_em18_bgV addSubview:self.em14_segment];
        
        
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        CGFloat itemWidth = (self.em_width - 40) / 2;
        layout.itemSize = CGSizeMake(itemWidth, 130);
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        self.em_all_collect = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.em14_segment.em_bottom+10, self.em18_bgV.em_width, self.em18_bgV.em_height - 10-self.em14_segment.em_bottom-35) collectionViewLayout:layout];
        [self.em_all_collect registerClass:[ZhenwupLibaoCell1 class] forCellWithReuseIdentifier:@"zhenwuimLibaoCell1"];
        [self.em_all_collect registerClass:[ZhenwupLibaoCell2 class] forCellWithReuseIdentifier:@"zhenwuimLibaoCell2"];
        self.em_all_collect.dataSource = self;
        self.em_all_collect.delegate = self;
        self.em_all_collect.backgroundColor = [UIColor clearColor];
//        self.em_all_collect.backgroundColor=[UIColor redColor];
        self.em_all_collect.alwaysBounceVertical = YES;
        [self.em18_bgV addSubview:self.em_all_collect];
        
        self.em11_NodataView.frame = CGRectMake(_em18_bgV.em_width/2-100, self.em14_segment.em_bottom+150, 200, 200);
        self.em11_NodataView.hidden=YES;
        

    }
    return _em18_bgV;
}


- (void)em11_GetAllPresentList {
    __weak typeof(self) weakSelf = self;
    [self.em11_AccountServer em11_GetAllPresent:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        if (result.em14_responseCode == EM_ResponseCodeSuccess) {
            [weakSelf.em11_all_Presents removeAllObjects];
            NSArray *arr= (NSArray *)result.em14_responeResult;
            
            [weakSelf.em11_all_Presents addObjectsFromArray:arr];
        } else {
            [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
        }
        [weakSelf.em_all_collect reloadData];
        weakSelf.em11_NodataView.hidden = weakSelf.em11_all_Presents.count > 0;
    }];
}

- (void)em11_GetMyPresentList {
    __weak typeof(self) weakSelf = self;
    [self.em11_AccountServer em11_GetMyPresents:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        if (result.em14_responseCode == EM_ResponseCodeSuccess) {
            [weakSelf.em11_all_Presents removeAllObjects];
            NSArray *arr= (NSArray *)result.em14_responeResult;
            
            [weakSelf.em11_all_Presents addObjectsFromArray:arr];
        } else {
            [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
        }
        [weakSelf.em_all_collect reloadData];
        weakSelf.em11_NodataView.hidden = weakSelf.em11_all_Presents.count > 0;
    }];
}

-(void)em14_segValeDidChange:(NSInteger)index{
    switch (index) {
        case 0:
        {
           
            self.type=1;
            [self em11_GetAllPresentList];
        }
            break;
        default:
        {
            self.type=2;
            [self em11_GetMyPresentList];
        }
            break;
    }
}
#pragma mark  collection
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
   return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.em11_all_Presents count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    if (self.type==1) {
        ZhenwupLibaoCell1 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"zhenwuimLibaoCell1" forIndexPath:indexPath];
      
       if (self.em11_all_Presents.count > 0) {

           NSDictionary*dic=self.em11_all_Presents[indexPath.row];
           cell.vdic=dic;
       }

       return cell;
    }else{
        ZhenwupLibaoCell2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"zhenwuimLibaoCell2" forIndexPath:indexPath];
      
       if (self.em11_all_Presents.count > 0) {

           NSDictionary*dic=self.em11_all_Presents[indexPath.row];
           cell.vdic=dic;
       }

       return cell;
    }
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.type==1) {
        ZhenwupShowView *xlAlertView = [[ZhenwupShowView alloc] initWithTitle:@"" message:@"Nhận Coupon hay không" sureBtn:@"Xác nhận" cancleBtn:@"Hủy bỏ"];
        xlAlertView.resultIndex = ^(NSInteger index){
        //回调---处理一系列动作
            NSDictionary*dic=self.em11_all_Presents[indexPath.row];
            NSInteger em11_present_id = [dic[[NSString stringWithFormat:@"%@%@%@%@",@"g",@"if",@"t_i",@"d"]] integerValue];
            [MBProgressHUD em14_ShowLoadingHUD];
            [self.em11_AccountServer em11_GetPresent:em11_present_id responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull result) {
                [MBProgressHUD em14_DismissLoadingHUD];
                if (result.em14_responseCode == EM_ResponseCodeSuccess) {
                    [self em11_GetAllPresentList];
                } else {
                   
                }
            }];
            
          
        };
        [xlAlertView showXLAlertView];
    }else{
        NSDictionary *params = @{[NSString stringWithFormat:@"%@",@"game_id"] : EMSDKGlobalInfo.gameInfo.gameID?:@"", [NSString stringWithFormat:@"%@",@"userid"]:[EMSDKGlobalInfo.userInfo.userID hash_md5]?:@"", [NSString stringWithFormat:@"%@",@"token"]: [EMSDKGlobalInfo.userInfo.token hash_base64Encode]?:@"",@"redirect_type":@"go_point_shop"};
        BOOL em11_GvCheck = EMSDKGlobalInfo.em11_GvCheck;
        NSString *url = [ZhenwupRemoteData_Server em14_BuildFinalUrl:em11_GvCheck?MYMGUrlConfig.em14_httpsdomain.em14_returnupsBaseUrl:MYMGUrlConfig.em14_httpsdomain.em14_backupsBaseUrl WithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpAutoLoginPath andParams:params];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }

   
  
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
