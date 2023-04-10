//
//  ZhenwupChooseLoginView.h
//  GiguoFrameWork
//
//  Created by Admin on 2022/5/25.
//  Copyright © 2022 Admin. All rights reserved.
//

#import "ZhenwupBaseWindow_View.h"

NS_ASSUME_NONNULL_BEGIN

@class ZhenwupChooseLoginView;

@protocol EM1_ChooseLoginViewDelegate <NSObject>

- (void)em18_CloseChooseLoginView:(ZhenwupChooseLoginView *)loginView loginSucess:(BOOL)success;
- (void)em18_PresentAccountLoginAndRegisterView:(ZhenwupChooseLoginView *)loginView;

@end

@interface ZhenwupChooseLoginView : ZhenwupBaseWindow_View

@property (nonatomic, weak) id<EM1_ChooseLoginViewDelegate> delegate;
@property(nonatomic,strong)NSString *enter;
@end

NS_ASSUME_NONNULL_END
