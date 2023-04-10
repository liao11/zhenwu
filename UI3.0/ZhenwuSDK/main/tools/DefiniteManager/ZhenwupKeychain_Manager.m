
#import "ZhenwupKeychain_Manager.h"
#import <Security/Security.h>

@implementation ZhenwupKeychain_Manager

+ (NSMutableDictionary *)em14_u_getKeychainQuery:(NSString *)service andAccount:(NSString *)account {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (id)kSecClassGenericPassword,(id)kSecClass,
            service, (id)kSecAttrService,
            account, (id)kSecAttrAccount,
            (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,
            nil];
}

+ (BOOL)em14_keychainSaveObject:(id)objectData forService:(NSString *)service andAccount:(NSString *)account {
    if (!account || account.length <= 0) {
        return NO;
    }
    NSMutableDictionary *keychainQuery = [self em14_u_getKeychainQuery:service andAccount:account];
    SecItemDelete((CFDictionaryRef)keychainQuery);
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:objectData] forKey:(id)kSecValueData];
    OSStatus saveState = SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
    return (saveState == errSecSuccess);
}

+ (id)em14_keychainObjectForService:(NSString *)service andAccount:(NSString *)account {
    if (!account || account.length <= 0) {
        return nil;
    }
    NSMutableDictionary *keychainQuery = [self em14_u_getKeychainQuery:service andAccount:account];
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
    [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    id ret = nil;
    if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == errSecSuccess) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

+ (BOOL)em14_keyChainUpdateObject:(id)objectData forService:(NSString *)service andAccount:(NSString *)account {
    if (!account || account.length <= 0) {
        return NO;
    }
    NSMutableDictionary *keychainQuery = [self em14_u_getKeychainQuery:service andAccount:account];
    
    NSMutableDictionary *updataMutableDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
    [updataMutableDictionary setObject:[NSKeyedArchiver archivedDataWithRootObject:objectData] forKey:(id)kSecValueData];
    OSStatus updataStatus = SecItemUpdate((CFDictionaryRef)keychainQuery, (CFDictionaryRef)updataMutableDictionary);
    
    return (updataStatus == errSecSuccess);
}

+ (BOOL)em14_keychainRemoveObjectForService:(NSString *)service andAccount:(NSString *)account {
    if (!account || account.length <= 0) {
        return NO;
    }
    NSMutableDictionary *keychainQuery = [self em14_u_getKeychainQuery:service andAccount:account];
    OSStatus deleteState = SecItemDelete((CFDictionaryRef)keychainQuery);
    return (deleteState == errSecSuccess);
}

+ (BOOL)em14_keychainSaveObject:(id)objectData forKey:(NSString *)key {
    return [self em14_keychainSaveObject:objectData forService:key andAccount:key];
}

+ (id)em14_keychainObjectForKey:(NSString *)key {
    return [self em14_keychainObjectForService:key andAccount:key];
}

+ (BOOL)em14_keyChainUpdateObject:(id)objectData forKey:(NSString *)key {
    return [self em14_keyChainUpdateObject:objectData forService:key andAccount:key];
}

+ (BOOL)em14_keychainRemoveObjectForKey:(NSString *)key {
    return [self em14_keychainRemoveObjectForService:key andAccount:key];
}

@end
