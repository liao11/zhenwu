//
//  ZhenwupBiCell.h
//  GiguoFrameWork
//
//  Created by Admin on 2021/9/29.
//  Copyright © 2021 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BiTableViewCellBackgroundView : UIView
 
@end

@interface ZhenwupBiCell : UITableViewCell

@property (nonatomic, strong) UILabel *em11_date;
@property (nonatomic, strong) UILabel *em18_cost;
@property (nonatomic, strong) UILabel *em11_channel;

@end

NS_ASSUME_NONNULL_END
