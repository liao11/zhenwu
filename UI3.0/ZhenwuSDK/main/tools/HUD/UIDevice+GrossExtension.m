
#import "UIDevice+GrossExtension.h"
#import "EM_Define.h"
#import "ZhenwupKeychain_Manager.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#include <sys/stat.h>
#include "dlfcn.h"
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AdSupport/AdSupport.h>

#include <ifaddrs.h>
#include <arpa/inet.h>
#include <net/if.h>
#include <net/if_dl.h>
#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"
@implementation UIDevice (MYMGExtension)

+ (NSString *)em14_deviceNO {
    NSString *uuid = [ZhenwupKeychain_Manager em14_keychainObjectForKey:[NSString stringWithFormat:@"%@",@"com.timing.api.dn.uid"]];;
    if (!uuid || [uuid isEqualToString:@""]) {
        CFUUIDRef uuid_ref = CFUUIDCreate(NULL);
        CFStringRef uuid_string_ref = CFUUIDCreateString(NULL, uuid_ref);
        uuid = [NSString stringWithString:(__bridge NSString *)uuid_string_ref];
        [ZhenwupKeychain_Manager em14_keychainSaveObject:uuid?:@"" forKey:[NSString stringWithFormat:@"%@",@"com.timing.api.dn.uid"]];
        CFRelease(uuid_ref);
        CFRelease(uuid_string_ref);
    }
    return uuid;
}

//获取设备id
+(NSString *)em_getDeviceNo
{
    NSString *bundleID = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
    NSString *deviceIdKey = [NSString stringWithFormat:@"%@_QingApiDeveceMix",bundleID];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString * currentDeviceUUIDStr = [userDefaults objectForKey:deviceIdKey];
    if(currentDeviceUUIDStr == nil || [currentDeviceUUIDStr isEqualToString:@""])
    {
        NSUUID * currentDeviceUUID = [UIDevice currentDevice].identifierForVendor;
        currentDeviceUUIDStr = currentDeviceUUID.UUIDString;
        currentDeviceUUIDStr = [currentDeviceUUIDStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
        currentDeviceUUIDStr = [currentDeviceUUIDStr lowercaseString];
        [userDefaults setObject:currentDeviceUUIDStr forKey:deviceIdKey];
    }
    [userDefaults synchronize];
    return currentDeviceUUIDStr;
}
+(NSString *)em_getDeviceNo2
{
    NSString *em_iNor = [UIDevice gainIDFA]?:@"";
    if ([em_iNor hasPrefix:@"00000000"]) {
        em_iNor = [[UIDevice currentDevice].identifierForVendor UUIDString]?:@"";
       
    }else{
        em_iNor = [UIDevice gainIDFA];
      
    }
    return em_iNor;
}


+ (NSString *)em14_getCurrentDeviceModel
{
    int mib[2];
    size_t len;
    char *machine;
    
    mib[0] = CTL_HW;
    mib[1] = HW_MACHINE;
    sysctl(mib, 2, NULL, &len, NULL, 0);
    machine = malloc(len);
    sysctl(mib, 2, machine, &len, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:machine encoding:NSASCIIStringEncoding];
    free(machine);
    
    
    if ([platform isEqualToString:@"iPhone1,1"])    return [NSString stringWithFormat:@"%@",@"iPhone 1G"];
    if ([platform isEqualToString:@"iPhone1,2"])    return [NSString stringWithFormat:@"%@",@"iPhone 3G"];
    if ([platform isEqualToString:@"iPhone2,1"])    return [NSString stringWithFormat:@"%@",@"iPhone 3GS"];
    if ([platform isEqualToString:@"iPhone3,1"])    return [NSString stringWithFormat:@"%@",@"iPhone 4"];
    if ([platform isEqualToString:@"iPhone3,2"])    return [NSString stringWithFormat:@"%@",@"iPhone 4"];
    if ([platform isEqualToString:@"iPhone4,1"])    return [NSString stringWithFormat:@"%@",@"iPhone 4S"];
    if ([platform isEqualToString:@"iPhone5,1"])    return [NSString stringWithFormat:@"%@",@"iPhone 5"];
    if ([platform isEqualToString:@"iPhone5,2"])    return [NSString stringWithFormat:@"%@",@"iPhone 5"];
    if ([platform isEqualToString:@"iPhone5,3"])    return [NSString stringWithFormat:@"%@",@"iPhone 5C"];
    if ([platform isEqualToString:@"iPhone5,4"])    return [NSString stringWithFormat:@"%@",@"iPhone 5C"];
    if ([platform isEqualToString:@"iPhone6,1"])    return [NSString stringWithFormat:@"%@",@"iPhone 5S"];
    if ([platform isEqualToString:@"iPhone6,2"])    return [NSString stringWithFormat:@"%@",@"iPhone 5S"];
    if ([platform isEqualToString:@"iPhone7,1"])    return [NSString stringWithFormat:@"%@",@"iPhone 6 Plus"];
    if ([platform isEqualToString:@"iPhone7,2"])    return [NSString stringWithFormat:@"%@",@"iPhone 6"];
    if ([platform isEqualToString:@"iPhone8,1"])    return [NSString stringWithFormat:@"%@",@"iPhone 6s"];
    if ([platform isEqualToString:@"iPhone8,2"])    return [NSString stringWithFormat:@"%@",@"iPhone 6s Plus"];
    if ([platform isEqualToString:@"iPhone8,4"])    return [NSString stringWithFormat:@"%@",@"iPhone SE"];
    if ([platform isEqualToString:@"iPhone9,1"])    return [NSString stringWithFormat:@"%@",@"iPhone 7"];
    if ([platform isEqualToString:@"iPhone9,2"])    return [NSString stringWithFormat:@"%@",@"iPhone 7 Plus"];
    
    
    if ([platform isEqualToString:@"iPod1,1"]) return [NSString stringWithFormat:@"%@",@"iPod Touch 1G"];
    if ([platform isEqualToString:@"iPod2,1"]) return [NSString stringWithFormat:@"%@",@"iPod Touch 2G"];
    if ([platform isEqualToString:@"iPod3,1"]) return [NSString stringWithFormat:@"%@",@"iPod Touch 3G"];
    if ([platform isEqualToString:@"iPod4,1"]) return [NSString stringWithFormat:@"%@",@"iPod Touch 4G"];
    if ([platform isEqualToString:@"iPod5,1"]) return [NSString stringWithFormat:@"%@",@"iPod Touch 5G"];
    
    
    if ([platform isEqualToString:@"iPad1,1"])      return [NSString stringWithFormat:@"%@",@"iPad"];
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2 (32nm)";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad mini (GSM)";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad mini (CDMA)";
    
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3(WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3(CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3(4G)";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4 (4G)";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (CDMA)";
    
    if ([platform isEqualToString:@"iPad4,1"])      return [NSString stringWithFormat:@"%@",@"iPad Air"];
    if ([platform isEqualToString:@"iPad4,2"])      return [NSString stringWithFormat:@"%@",@"iPad Air"];
    if ([platform isEqualToString:@"iPad4,3"])      return [NSString stringWithFormat:@"%@",@"iPad Air"];
    if ([platform isEqualToString:@"iPad5,3"])      return [NSString stringWithFormat:@"%@",@"iPad Air 2"];
    if ([platform isEqualToString:@"iPad5,4"])      return [NSString stringWithFormat:@"%@",@"iPad Air 2"];
    if ([platform isEqualToString:@"i386"])         return [NSString stringWithFormat:@"%@",@"Simulator"];
    if ([platform isEqualToString:@"x86_64"])       return [NSString stringWithFormat:@"%@",@"Simulator"];
    
    if ([platform isEqualToString:@"iPad4,4"]||[platform isEqualToString:@"iPad4,5"]||[platform isEqualToString:@"iPad4,6"]) return [NSString stringWithFormat:@"%@",@"iPad mini 2"];
    
    if ([platform isEqualToString:@"iPad4,7"]||[platform isEqualToString:@"iPad4,8"]||[platform isEqualToString:@"iPad4,9"])  return [NSString stringWithFormat:@"%@",@"iPad mini 3"];
    return platform;
}

+ (NSString *)em14_getCurrentDeviceUUID{
    
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

+ (NSString *)em14_getCurrentDeviceModelProvider{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    
    CTCarrier *carrier = [info subscriberCellularProvider];
    NSString *net = [NSString stringWithFormat:@"%@",[carrier carrierName]];
    if ([net isEqualToString:@"(null)"]) {
        net = @"0";
    }else if ([net isEqualToString:@"中国移动"]) {
        net = @"1";
    }else if ([net isEqualToString:@"中国联通"]) {
        net = @"2";
    }else if ([net isEqualToString:@"中国电信"]) {
        net = @"3";
    }
    return net;
}

+ (NSString *)em14_getCurrentDeviceNetworkingStates {
    
    UIApplication *app = [UIApplication sharedApplication];
        
    id statusBar = nil;
    NSString *network = @"";
    
    if (@available(iOS 13.0, *)) {
        UIStatusBarManager *statusBarManager = [UIApplication sharedApplication].keyWindow.windowScene.statusBarManager;
            
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        if ([statusBarManager respondsToSelector:@selector(createLocalStatusBar)]) {
            UIView *localStatusBar = [statusBarManager performSelector:@selector(createLocalStatusBar)];
            if ([localStatusBar respondsToSelector:@selector(statusBar)]) {
                statusBar = [localStatusBar performSelector:@selector(statusBar)];
            }
        }
#pragma clang diagnostic pop
            
        if (statusBar) {
            id currentData = [[statusBar valueForKeyPath:[NSString stringWithFormat:@"%@",@"_statusBar"]] valueForKeyPath:[NSString stringWithFormat:@"%@",@"currentData"]];
            id _wifiEntry = [currentData valueForKeyPath:[NSString stringWithFormat:@"%@",@"wifiEntry"]];
            id _cellularEntry = [currentData valueForKeyPath:[NSString stringWithFormat:@"%@",@"cellularEntry"]];
            
            if (_wifiEntry && [[_wifiEntry valueForKeyPath:@"isEnabled"] boolValue]) {
                network = [NSString stringWithFormat:@"%@",@"WIFI"];
            } else if (_cellularEntry && [[_cellularEntry valueForKeyPath:@"isEnabled"] boolValue]) {
                NSNumber *type = [_cellularEntry valueForKeyPath:[NSString stringWithFormat:@"%@",@"type"]];
                if (type) {
                    switch (type.integerValue) {
                        case 0:
                            network = [NSString stringWithFormat:@"%@",@"NONE"];
                            break;
                        case 1:
                            network = [NSString stringWithFormat:@"%@",@"1G"];
                            break;
                        case 4:
                            network = [NSString stringWithFormat:@"%@",@"3G"];
                            break;
                        case 5:
                            network = [NSString stringWithFormat:@"%@",@"4G"];
                            break;
                        default:
                            network = [NSString stringWithFormat:@"%@",@"WWAN"];
                            break;
                    }
                }
            }
        }
    } else {
        
        
        return [NSString stringWithFormat:@"%@",@"WIFI"];
        
        statusBar = [app valueForKeyPath:[NSString stringWithFormat:@"%@",@"statusBar"]];
            
        if (IS_IPhoneX) { 
            id statusBarView = [statusBar valueForKeyPath:[NSString stringWithFormat:@"%@",@"statusBar"]];
            UIView *foregroundView = [statusBarView valueForKeyPath:[NSString stringWithFormat:@"%@",@"foregroundView"]];
            NSArray *subviews = [[foregroundView subviews][2] subviews];
                    
            if (subviews.count == 0) {
                id currentData = [statusBarView valueForKeyPath:[NSString stringWithFormat:@"%@",@"currentData"]];
                id wifiEntry = [currentData valueForKey:[NSString stringWithFormat:@"%@",@"wifiEntry"]];
                if ([[wifiEntry valueForKey:@"_enabled"] boolValue]) {
                    network = [NSString stringWithFormat:@"%@",@"WIFI"];
                } else {
                    id cellularEntry = [currentData valueForKey:[NSString stringWithFormat:@"%@",@"cellularEntry"]];
                    id secondaryCellularEntry = [currentData valueForKey:[NSString stringWithFormat:@"%@",@"secondaryCellularEntry"]];

                    if (([[cellularEntry valueForKey:@"_enabled"] boolValue]|[[secondaryCellularEntry valueForKey:@"_enabled"] boolValue]) == NO) {
                        network = [NSString stringWithFormat:@"%@",@"NONE"];
                    } else {
                        BOOL isCardOne = [[cellularEntry valueForKey:@"_enabled"] boolValue];
                        int networkType = isCardOne ? [[cellularEntry valueForKey:[NSString stringWithFormat:@"%@",@"type"]] intValue] : [[secondaryCellularEntry valueForKey:[NSString stringWithFormat:@"%@",@"type"]] intValue];
                        
                        switch (networkType) {
                            case 0:
                                network = [NSString stringWithFormat:@"%@-%@", isCardOne ? @"Card 1" : @"Card 2", [NSString stringWithFormat:@"%@",@"NONE"]];
                                break;
                            case 3:
                                network = [NSString stringWithFormat:@"%@-%@", isCardOne ? @"Card 1" : @"Card 2", @"2G/E"];
                                break;
                            case 4:
                                network = [NSString stringWithFormat:@"%@-%@", isCardOne ? @"Card 1" : @"Card 2", [NSString stringWithFormat:@"%@",@"3G"]];
                                break;
                            case 5:
                                network = [NSString stringWithFormat:@"%@-%@", isCardOne ? @"Card 1" : @"Card 2", [NSString stringWithFormat:@"%@",@"4G"]];
                                break;
                            default:
                                break;
                        }
                    }
                }
            } else {
                for (id subview in subviews) {
                    if ([subview isKindOfClass:NSClassFromString(@"_UIStatusBarWifiSignalView")]) {
                        network = [NSString stringWithFormat:@"%@",@"WIFI"];
                    } else if ([subview isKindOfClass:NSClassFromString(@"_UIStatusBarStringView")]) {
                        network = [subview valueForKeyPath:[NSString stringWithFormat:@"%@%@",@"origin",@"alText"]];
                    }
                }
            }
        } else { 
            UIView *foregroundView = [statusBar valueForKeyPath:[NSString stringWithFormat:@"%@",@"foregroundView"]];
            NSArray *subviews = [foregroundView subviews];
              
            for (id subview in subviews) {
                if ([subview isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
                    int networkType = [[subview valueForKeyPath:[NSString stringWithFormat:@"%@",@"dataNetworkType"]] intValue];
                    switch (networkType) {
                        case 0:
                            network = [NSString stringWithFormat:@"%@",@"NONE"];
                            break;
                        case 1:
                            network = [NSString stringWithFormat:@"%@",@"2G"];
                            break;
                        case 2:
                            network = [NSString stringWithFormat:@"%@",@"3G"];
                            break;
                        case 3:
                            network = [NSString stringWithFormat:@"%@",@"4G"];
                            break;
                        case 4:
                            network = [NSString stringWithFormat:@"%@",@"LTE"];
                            break;
                        case 5:
                            network = [NSString stringWithFormat:@"%@",@"WIFI"];
                            break;
                        default:
                            break;
                    }
                }
            }
        }
    }
    if ([network isEqualToString:@""]) {
        network = [NSString stringWithFormat:@"%@",@"WIFI"];
    }
    return network;
}

+ (void)setDeviceVibrate{
    AudioServicesPlaySystemSound ( kSystemSoundID_Vibrate);
}

- (int64_t)diskSpace {
    NSError *error = nil;
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) return -1;
    int64_t space =  [[attrs objectForKey:NSFileSystemSize] longLongValue];
    if (space < 0) space = -1;
    return space;
}

- (int64_t)diskSpaceFree {
    NSError *error = nil;
    NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:&error];
    if (error) return -1;
    int64_t space =  [[attrs objectForKey:NSFileSystemFreeSize] longLongValue];
    if (space < 0) space = -1;
    return space;
}

- (int64_t)diskSpaceUsed {
    int64_t total = self.diskSpace;
    int64_t free = self.diskSpaceFree;
    if (total < 0 || free < 0) return -1;
    int64_t used = total - free;
    if (used < 0) used = -1;
    return used;
}

+ (NSString *)gainIDFA {
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}

+ (NSString *)gainAppVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:[NSString stringWithFormat:@"%@",@"CFBundleShortVersionString"]];
}
- (NSString *)getIPAddress:(BOOL)preferIPv4
{
    NSArray *searchArray = preferIPv4 ?
    @[  IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[  IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary *addresses = [self getIPAddresses];
    
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         address = addresses[key];
         if(address) *stop = YES;
     } ];
    return address ? address : [NSString stringWithFormat:@"%@",@"0.0.0.0"];
}
- (NSDictionary *)getIPAddresses
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP)  ) {
                continue; 
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}
- (NSDictionary *)getWWANAndWIFIAddresses {
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithCapacity:2];
    
    NSDictionary *allAdresses = [[UIDevice currentDevice] getIPAddresses];
    NSString *wwan = [allAdresses objectForKey:[NSString stringWithFormat:@"%@/%@",IOS_CELLULAR,IP_ADDR_IPv4]];
    NSString *wifi = [allAdresses objectForKey:[NSString stringWithFormat:@"%@/%@",IOS_WIFI,IP_ADDR_IPv4]];
    if (!wwan) {
        wwan = @"";
    }
    if (!wifi) {
        wifi = @"";
    }
    [dict setObject:wwan forKey:IOS_CELLULAR];
    [dict setObject:wifi forKey:IOS_WIFI];
    return dict;
}
+ (NSString *)obtainChannel {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:[NSString stringWithFormat:@"%@",@"ChannelKey"]];
}

+ (NSString *)obtainSubChannel {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:[NSString stringWithFormat:@"%@",@"SubChannelKey"]];
}
+ (BOOL)getIsIpad

{

NSString *deviceType = [UIDevice currentDevice].model;

if([deviceType isEqualToString:@"iPhone"]) {

//iPhone

return NO;

}

else if([deviceType isEqualToString:@"iPod touch"]) {

//iPod Touch

return NO;

}

else if([deviceType isEqualToString:@"iPad"]) {

//iPad

return YES;

}

return NO;

}
int checkInject() {
    int ret;
    Dl_info dylib_info;
    int (*func_stat)(const char*, struct stat*) = stat;
    char *dylib_name = "/usr/lib/system/libsystem_kernel.dylib";
    if ((ret = dladdr(func_stat, &dylib_info)) && strncmp(dylib_info.dli_fname, dylib_name, strlen(dylib_name))) {
        return 0;
    }
    return 1;
}

int checkCydia() {
    struct stat stat_info;
    if (!checkInject()) {
        if (0 == stat("/Applications/Cydia.app", &stat_info)) {
            return 1;
        }
    } else {
        return 1;
    }
    return 0;
}

@end
