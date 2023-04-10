//
//  ZhenwupRelayoutBtn.h
//  GiguoFrameWork
//
//  Created by Admin on 2021/8/17.
//  Copyright © 2021 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,RelayoutType) {
    /// 系统默认样式
    RelayoutTypeNone = 0,
    /// 上图下文
    RelayoutTypeUpDown = 1,
    /// 左文右图
    RelayoutTypeRightLeft = 2,
};

@interface ZhenwupRelayoutBtn : UIButton


/** 布局样式*/
@property (assign,nonatomic) IBInspectable NSInteger  layoutType;
@property (assign,nonatomic) IBInspectable CGFloat  margin;

@end

NS_ASSUME_NONNULL_END
