
#import "ZhenwupCPPurchaseOrder_Entity.h"

NS_ASSUME_NONNULL_BEGIN

@interface ZhenwupPurchaseProduceOrder_Entity : ZhenwupCPPurchaseOrder_Entity

@property (nonatomic, copy) NSString *purchaseUserId;
@property (nonatomic, copy) NSString *chOrderNO;
@property (nonatomic, copy) NSString *appleOrderNO;
@property (nonatomic, copy) NSString *currencyType;
@property (nonatomic, copy) NSDecimalNumber *producePrice;
@property (nonatomic, assign) NSInteger flag;

+ (instancetype)initWithCPPurchaseOrder:(ZhenwupCPPurchaseOrder_Entity *)cpOrder;
- (instancetype)initWithJsonString:(NSString *)jsonString;
- (NSString *)em14_jsonString;

@end

NS_ASSUME_NONNULL_END
