//
//  ZhenwupOneClickLoginV.h
//  GiguoFrameWork
//
//  Created by Admin on 2022/5/25.
//  Copyright © 2022 Admin. All rights reserved.
//

#import "ZhenwupBaseWindow_View.h"
NS_ASSUME_NONNULL_BEGIN

@class ZhenwupOneClickLoginV;

@protocol EM1_OneClickLoginVDelegate <NSObject>

- (void)em11_HandlePopToLastV:(ZhenwupOneClickLoginV *)registerView;
- (void)em11_HandleDidOneClickEmailSuccess:(ZhenwupOneClickLoginV *)registerView;
- (void)em18_PresentFromOneClickToLogin:(ZhenwupOneClickLoginV *)registerView;
- (void)em11_HandEmailwithEmial:(NSString *)email withView:(ZhenwupOneClickLoginV *)registerView;
@end

@interface ZhenwupOneClickLoginV : ZhenwupBaseWindow_View

@property (nonatomic, weak) id<EM1_OneClickLoginVDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
