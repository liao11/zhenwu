
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (MYMGExtension)

+ (NSString *)em14_deviceNO;
+ (NSString *)em_getDeviceNo;
+(NSString *)em_getDeviceNo2;
+ (NSString *)em14_getCurrentDeviceModel;
+ (NSString *)em14_getCurrentDeviceUUID;
+(NSString *)em14_getCurrentDeviceModelProvider;
+ (NSString *)em14_getCurrentDeviceNetworkingStates;
+ (void)setDeviceVibrate;
@property (nonatomic, readonly) int64_t diskSpace;
@property (nonatomic, readonly) int64_t diskSpaceFree;
@property (nonatomic, readonly) int64_t diskSpaceUsed;
+ (NSString *)gainIDFA;
+ (NSString *)gainAppVersion;
- (NSString *)getIPAddress:(BOOL)preferIPv4;
- (NSDictionary *)getIPAddresses;
- (NSDictionary *)getWWANAndWIFIAddresses;
+ (NSString *)obtainChannel;

+ (NSString *)obtainSubChannel;

+ (BOOL)getIsIpad;


@end

NS_ASSUME_NONNULL_END
