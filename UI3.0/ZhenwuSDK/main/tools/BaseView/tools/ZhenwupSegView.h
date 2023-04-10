//
//  ZhenwupSegView.h
//  EmpriSDK
//
//  Created by Admin on 2023/1/13.
//  Copyright © 2023 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZhenwupTheme_Utils.h"
NS_ASSUME_NONNULL_BEGIN
@class ZhenwupSegView;
@protocol EmpriSegViewDelegate <NSObject>
@optional


- (void)em14_segValeDidChange:(NSInteger )index;
@end
@interface ZhenwupSegView : UIView
- (instancetype)initWithTitleArr:(NSArray *)titleArr WithFrame:(CGRect)frame;
@property (nullable, nonatomic, weak) id<EmpriSegViewDelegate> delegate;
@property(nonatomic)NSInteger num;
@end

NS_ASSUME_NONNULL_END
