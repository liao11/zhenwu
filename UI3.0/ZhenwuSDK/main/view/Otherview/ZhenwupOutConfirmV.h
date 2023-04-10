//
//  ZhenwupOutConfirmV.h
//  GiguoFrameWork
//
//  Created by Admin on 2021/10/8.
//  Copyright © 2021 Admin. All rights reserved.
//

#import "ZhenwupBaseWindow_View.h"

NS_ASSUME_NONNULL_BEGIN

@class ZhenwupOutConfirmV;

@protocol EM1_OutConfirmVDelegate <NSObject>

- (void)em11_handleCloseOutConfirmV:(ZhenwupOutConfirmV *)confirmV;

@end

@interface ZhenwupOutConfirmV : ZhenwupBaseWindow_View

@property (nonatomic, weak) id<EM1_OutConfirmVDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
