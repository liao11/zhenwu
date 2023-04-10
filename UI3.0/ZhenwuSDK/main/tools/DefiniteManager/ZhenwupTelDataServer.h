//
//  ZhenwupTelDataServer.h
//  GiguoFrameWork
//
//  Created by Admin on 2021/11/29.
//  Copyright © 2021 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZhenwupUserInfo_Entity;

NS_ASSUME_NONNULL_BEGIN

@interface ZhenwupTelDataServer : NSObject

+ (void)em14_saveLoginedUserInfo:(ZhenwupUserInfo_Entity *)userInfo;

+ (NSArray *)em14_loadAllSavedLoginedUser;

+ (BOOL)em14_removeAllLoginedUserHistory;

+ (void)em14_removeLoginedUserInfoFormHistory:(ZhenwupUserInfo_Entity *)userInfo;

@end

NS_ASSUME_NONNULL_END
