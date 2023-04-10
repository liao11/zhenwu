//
//  ZhenwupTelDataServer.m
//  GiguoFrameWork
//
//  Created by Admin on 2021/11/29.
//  Copyright © 2021 Admin. All rights reserved.
//

#import "ZhenwupTelDataServer.h"
#import "ZhenwupKeychain_Manager.h"
#import "ZhenwupUserInfo_Entity.h"
#import "NSString+GrossExtension.h"
#import "EM_Define.h"

@implementation ZhenwupTelDataServer

+ (NSString *)em14_u_KeychainServiceKeyOfLoginedAccounts {
    return [NSString stringWithFormat:@"muugame.sdk2.telAccounts.%@", NSStringFromClass([ZhenwupUserInfo_Entity class])];
}

+ (void)em14_saveLoginedUserInfo:(ZhenwupUserInfo_Entity *)userInfo {
    
    if (userInfo.userID && ![userInfo.userID isEmpty]) {
        NSString *em14_KeychainServiceKey = [self em14_u_KeychainServiceKeyOfLoginedAccounts];
        NSArray *savedUsers = [ZhenwupKeychain_Manager em14_keychainObjectForKey:em14_KeychainServiceKey];
        
        if (![savedUsers isKindOfClass:[NSArray class]]) {
            [self em14_removeAllLoginedUserHistory];
            savedUsers = nil;
        }
        
        NSMutableArray *newList;
        if (savedUsers && savedUsers.count > 0) {
            newList = [savedUsers mutableCopy];
            for (ZhenwupUserInfo_Entity *user in savedUsers) {
                if ([user.userID isEqualToString:userInfo.userID]) {
                    userInfo.loginCount = user.loginCount;
                    [newList removeObject:user];
                    break;
                }
            }
        } else {
            newList = [[NSMutableArray alloc] init];
        }
        
        userInfo.loginCount += 1;
        [newList addObject:userInfo];
        
        [ZhenwupKeychain_Manager em14_keychainSaveObject:newList forKey:em14_KeychainServiceKey];
    }
}

+ (NSArray *)em14_loadAllSavedLoginedUser {
    return [ZhenwupKeychain_Manager em14_keychainObjectForKey:[self em14_u_KeychainServiceKeyOfLoginedAccounts]];
}




+ (BOOL)em14_removeAllLoginedUserHistory {
    return [ZhenwupKeychain_Manager em14_keychainRemoveObjectForKey:[self em14_u_KeychainServiceKeyOfLoginedAccounts]];
}

+ (void)em14_removeLoginedUserInfoFormHistory:(ZhenwupUserInfo_Entity *)userInfo {
    if (userInfo.userID && ![userInfo.userID isEmpty]) {
        NSString *em14_KeychainServiceKey = [self em14_u_KeychainServiceKeyOfLoginedAccounts];
        NSArray *savedUsers = [ZhenwupKeychain_Manager em14_keychainObjectForKey:em14_KeychainServiceKey];
        if (savedUsers && savedUsers.count > 0) {
            NSMutableArray *newList = [savedUsers mutableCopy];
            
            for (ZhenwupUserInfo_Entity *user in savedUsers) {
                if ([user.userID isEqualToString:userInfo.userID]) {
                    [newList removeObject:user];
                }
            }
            
            [ZhenwupKeychain_Manager em14_keychainSaveObject:newList forKey:em14_KeychainServiceKey];
        }
    }
}

@end
