
#import "ZhenwupRemoteData_Server.h"

NS_ASSUME_NONNULL_BEGIN
@class ZhenwupPurchaseProduceOrder_Entity;
@interface ZhenwupInAppPurchase_Server : ZhenwupRemoteData_Server

- (void)em11_createAndGetChOrderNo:(ZhenwupPurchaseProduceOrder_Entity *)purchaseOrde responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;

- (void)em11_checkAppleReceipt:(NSString *)receiptString withPurshaseOrder:(ZhenwupPurchaseProduceOrder_Entity *)purchaseOrder msg:(NSString * _Nullable)msg responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock;

@end

NS_ASSUME_NONNULL_END
