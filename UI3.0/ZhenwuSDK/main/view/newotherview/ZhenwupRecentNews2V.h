//
//  ZhenwupRecentNews2V.h
//  GiguoFrameWork
//
//  Created by Admin on 2022/11/14.
//  Copyright © 2022 Admin. All rights reserved.
//

#import "ZhenwupBaseWindow_View.h"


NS_ASSUME_NONNULL_BEGIN



@class ZhenwupRecentNews2V;
@protocol EM_RecentNews2VDelegate <NSObject>

- (void)em11_handleCloseRecentNews2V:(ZhenwupRecentNews2V *)recentNewsV;

@end

@interface ZhenwupRecentNews2V : ZhenwupBaseWindow_View

@property (nonatomic, weak) id<EM_RecentNews2VDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
