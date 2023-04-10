
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, ZW_Environment) {
    ZW_EnvironmentSandbox,
    ZW_EnvironmentProduction,
};
@interface ZhenwupAdjustConfig_Entity : NSObject

@property (nonatomic, copy) NSString *adjustAppToken;
@property (nonatomic, assign) ZW_Environment environment;

@property (nonatomic, copy) NSString *zwp01_eventTokenLogin;
@property (nonatomic, copy) NSString *zwp01_eventTokenRegister;
@property (nonatomic, copy) NSString *zwp01_eventTokenAccRegister;
@property (nonatomic, copy) NSString *zwp01_eventTokenFBRegister;
@property (nonatomic, copy) NSString *zwp01_eventTokenCreateRoles;
@property (nonatomic, copy) NSString *zwp01_eventTokenCompleteNoviceTask;
@property (nonatomic, copy) NSString *zwp01_eventTokenPurchase;
@property (nonatomic, copy) NSString *zwp01_eventTokenPurchaseARPU1;
@property (nonatomic, copy) NSString *zwp01_eventTokenPurchaseARPU5;
@property (nonatomic, copy) NSString *zwp01_eventTokenPurchaseARPU10;
@property (nonatomic, copy) NSString *zwp01_eventTokenPurchaseARPU30;
@property (nonatomic, copy) NSString *zwp01_eventTokenPurchaseARPU50;
@property (nonatomic, copy) NSString *zwp01_eventTokenPurchaseARPU100;


@property (nonatomic, copy) NSString *zwp01_eventTokenbegincdnTask;


@property (nonatomic, copy) NSString *zwp01_eventTokenfinishcdnTask;

@property (nonatomic, copy) NSString *zwp01_eventTokenbeginNoviceTask;
@end

NS_ASSUME_NONNULL_END
