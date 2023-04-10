
#import <Foundation/Foundation.h>
#import "ZhenwupPurchaseProduceOrder_Entity.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZhenwupInAppPurchase_Manager : NSObject

+ (instancetype)em11_SharedManager;

- (void)em11_getPurchaseProduces:(BOOL)isPurchase;

- (void)em11_startPurchaseProduceOrder:(ZhenwupPurchaseProduceOrder_Entity *)purchaseOrder;

- (void)em11_restorePurchaseProduces;

- (void)em11_recheckCachePurchaseOrderReceipts;
@end

NS_ASSUME_NONNULL_END
