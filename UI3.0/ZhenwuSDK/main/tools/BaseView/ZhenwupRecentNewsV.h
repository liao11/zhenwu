//
//  ZhenwupRecentNewsV.h
//  GiguoFrameWork
//
//  Created by Admin on 2021/8/17.
//  Copyright © 2021 Admin. All rights reserved.
//

#import "ZhenwupBaseWindow_View.h"

NS_ASSUME_NONNULL_BEGIN

@class ZhenwupRecentNewsV;
@protocol EM_RecentNewsVDelegate <NSObject>

- (void)em11_handleCloseRecentNewsV:(ZhenwupRecentNewsV *)recentNewsV;

@end

@interface ZhenwupRecentNewsV : ZhenwupBaseWindow_View

@property (nonatomic, weak) id<EM_RecentNewsVDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
