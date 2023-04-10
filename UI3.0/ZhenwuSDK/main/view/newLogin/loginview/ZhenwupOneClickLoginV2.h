//
//  ZhenwupOneClickLoginV2.h
//  EmpriSDK
//
//  Created by Admin on 2023/1/12.
//  Copyright © 2023 Admin. All rights reserved.
//

#import "ZhenwupBaseWindow_View.h"

NS_ASSUME_NONNULL_BEGIN

@class ZhenwupOneClickLoginV2;
@protocol EmpireOneClickLoginV2Delegate <NSObject>

- (void)em11_2HandlePopToLastV:(ZhenwupOneClickLoginV2 *)registerView;
- (void)em11_2HandleDidOneClickEmailSuccess:(ZhenwupOneClickLoginV2 *)registerView;
- (void)em18_2PresentFromOneClickToLogin:(ZhenwupOneClickLoginV2 *)registerView;

@end
@interface ZhenwupOneClickLoginV2 : ZhenwupBaseWindow_View


-(void)setEmailwith:(NSString *)email;
@property (nonatomic, strong) NSString *email;

@property (nonatomic, weak) id<EmpireOneClickLoginV2Delegate> delegate;
@end

NS_ASSUME_NONNULL_END
