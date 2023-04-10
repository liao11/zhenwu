//
//  ZhenwupChongCell.h
//  GiguoFrameWork
//
//  Created by Admin on 2021/8/17.
//  Copyright © 2021 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface TableViewCellBackgroundView : UIView
 
@end

@interface ZhenwupChongCell : UITableViewCell

@property (nonatomic, strong) UILabel *em11_chongTime;
@property (nonatomic, strong) UILabel *em18_orderNum;
@property (nonatomic, strong) UILabel *em11_orderMoney;
@property (nonatomic, strong) UIImageView *lhxy_statues;


@end

NS_ASSUME_NONNULL_END
