
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZhenwupKeychain_Manager : NSObject
+ (BOOL)em14_keychainSaveObject:(id)value forService:(NSString *)service andAccount:(NSString *)account;

+ (id)em14_keychainObjectForService:(NSString *)service andAccount:(NSString *)account;

+ (BOOL)em14_keyChainUpdateObject:(id)data forService:(NSString *)service andAccount:(NSString *)account;

+ (BOOL)em14_keychainRemoveObjectForService:(NSString *)service andAccount:(NSString *)account;

+ (BOOL)em14_keychainSaveObject:(id)objectData forKey:(NSString *)key;

+ (id)em14_keychainObjectForKey:(NSString *)key;

+ (BOOL)em14_keychainRemoveObjectForKey:(NSString *)key;

+ (BOOL)em14_keyChainUpdateObject:(id)objectData forKey:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
