//
//  ZhenwupBindTelView.h
//  GiguoFrameWork
//
//  Created by Admin on 2021/11/29.
//  Copyright © 2021 Admin. All rights reserved.
//

#import "ZhenwupBaseWindow_View.h"

@class ZhenwupBindTelView;

NS_ASSUME_NONNULL_BEGIN

@protocol EM1_BindTelViewDelegate <NSObject>

- (void)em11_handleClosedBindTelView_Delegate:(ZhenwupBindTelView *)bindTelView;
- (void)em11_handleBindTelSuccess_Delegate:(ZhenwupBindTelView *)bindTelView;

@end

@interface ZhenwupBindTelView : ZhenwupBaseWindow_View

@property (nonatomic, weak) id<EM1_BindTelViewDelegate> delegate;
@property (nonatomic, assign) NSInteger em11_fromFlags;
@property (nonatomic, assign) BOOL em_needTiePresent;
@property (nonatomic, copy) NSString *em11_gameId;
@property (nonatomic, copy) NSString *em14_roleId;
@property (nonatomic, copy, nullable) void(^em11_HandleBeforeClosedView)(void);

@end

NS_ASSUME_NONNULL_END
