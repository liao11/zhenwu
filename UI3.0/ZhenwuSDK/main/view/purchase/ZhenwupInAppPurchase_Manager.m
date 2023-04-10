
#import "ZhenwupInAppPurchase_Manager.h"
#import "ZhenwupInAppPurchase_Server.h"
#import "EM_Define.h"
#import "ZhenwupKeychain_Manager.h"
#import "ZhenwupHelper_Utils.h"
#import "MBProgressHUD+GrossExtension.h"
#import "NSString+GrossExtension.h"
#import <StoreKit/StoreKit.h>
#import <Adjust/Adjust.h>
#import <Firebase/Firebase.h>

NSString * const MYMLAppPurchaseCreateOrdersDataKey = @"com.muugame.serialization.create.order.data";
NSString * const MYMLInAppPurchaseVerfysOrdersDataKey = @"com.muugame.serialization.verify.order.data";

@interface ZhenwupInAppPurchase_Manager () <SKProductsRequestDelegate, SKPaymentTransactionObserver>

@property (nonatomic, strong) ZhenwupInAppPurchase_Server *em11_purchaseServer;
@property (nonatomic, strong) ZhenwupPurchaseProduceOrder_Entity *em11_purchaseOrder;
@property (nonatomic, assign) BOOL em11_is_geting_products;
@property (readwrite, nonatomic, strong) NSLock *lock;
@property (readwrite, nonatomic, strong) NSLock *verlock;
@end

@implementation ZhenwupInAppPurchase_Manager

+ (instancetype)em11_SharedManager {
    static ZhenwupInAppPurchase_Manager *purchaseManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        purchaseManager = [[ZhenwupInAppPurchase_Manager alloc] init];
    });
    return purchaseManager;
}

- (void)dealloc {
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

- (instancetype)init {
    self = [super init];
    if(self) {
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        
        self.em11_is_geting_products = NO;
        self.lock = [[NSLock alloc] init];
        self.lock.name = [NSString stringWithFormat:@"%@",@"com.muugame.sdk.create.order.lock"];
        self.verlock = [[NSLock alloc] init];
        self.verlock.name = [NSString stringWithFormat:@"%@",@"com.muugame.sdk.verify.order.lock"];
    }
    return self;
}

- (ZhenwupInAppPurchase_Server *)em11_purchaseServer {
    if (!_em11_purchaseServer) {
        _em11_purchaseServer = [[ZhenwupInAppPurchase_Server alloc] init];
    }
    return _em11_purchaseServer;
}

- (void)em11_getPurchaseProduces:(BOOL)isPurchase {
    if([SKPaymentQueue canMakePayments]) {
        if (EMSDKGlobalInfo.productIdentifiers && EMSDKGlobalInfo.productIdentifiers.count > 0) {
            if (self.em11_is_geting_products == NO) {
                self.em11_is_geting_products = YES;
                SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:EMSDKGlobalInfo.productIdentifiers];
                request.delegate = self;
                [request start];
            }
        } else {
            EM_RunInMainQueue(^{
                ZhenwupResponseObject_Entity *em11_result = [[ZhenwupResponseObject_Entity alloc] init];
                em11_result.em14_responseType = EM_ResponseTypeApplePay;
                em11_result.em14_responseCode = EM_ResponseCodeApplePayNoGoods;
                em11_result.em14_responeMsg = MUUQYLocalizedString(@"EMKey_NoProduceCanPurchase_Alert_Text");
                
//                [MBProgressHUD em14_showError_Toast:em11_result.em14_responeMsg];
                
                if (isPurchase) {
                    [self em11_u_EndOfPurchase];
                    
                    if (EMSDKAPI.delegate && [EMSDKAPI.delegate respondsToSelector:@selector(zwp01_startPurchaseProduceOrderFinished:)]) {
                        [EMSDKAPI.delegate zwp01_startPurchaseProduceOrderFinished:em11_result];
                    }
                } else {
                    if (EMSDKAPI.delegate && [EMSDKAPI.delegate respondsToSelector:@selector(zwp01_getPurchaseProducesFinished:)]) {
                        [EMSDKAPI.delegate zwp01_getPurchaseProducesFinished:em11_result];
                    }
                }
            });
        }
    } else {
        EM_RunInMainQueue(^{
            ZhenwupResponseObject_Entity *em11_result = [[ZhenwupResponseObject_Entity alloc] init];
            em11_result.em14_responseType = EM_ResponseTypeApplePay;
            em11_result.em14_responseCode = EM_ResponseCodeApplePayCannotMakePayments;
            em11_result.em14_responeMsg = MUUQYLocalizedString(@"EMKey_CannotMakePurchase_Alert_Text");
            
            [MBProgressHUD em14_showError_Toast:em11_result.em14_responeMsg];
            
            if (isPurchase) {
                [self em11_u_EndOfPurchase];
                
                if (EMSDKAPI.delegate && [EMSDKAPI.delegate respondsToSelector:@selector(zwp01_startPurchaseProduceOrderFinished:)]) {
                    [EMSDKAPI.delegate zwp01_startPurchaseProduceOrderFinished:em11_result];
                }
            } else {
                if (EMSDKAPI.delegate && [EMSDKAPI.delegate respondsToSelector:@selector(zwp01_getPurchaseProducesFinished:)]) {
                    [EMSDKAPI.delegate zwp01_getPurchaseProducesFinished:em11_result];
                }
            }
        });
    }
}

- (void)em11_startPurchaseProduceOrder:(ZhenwupPurchaseProduceOrder_Entity *)purchaseOrder {
    [self em11_recheckCachePurchaseOrderReceipts];
    
    if (self.em11_purchaseOrder && self.em11_purchaseOrder.appleProductId && self.em11_purchaseOrder.appleProductId.length > 0) {
        return;
    }
    
    EM_RunInMainQueue(^{
        [MBProgressHUD em14_ShowLoadingHUD];
    });
    
    purchaseOrder.purchaseUserId = EMSDKGlobalInfo.userInfo.userID;
    self.em11_purchaseOrder = purchaseOrder;
    
    if (EMSDKGlobalInfo.productIdentifiers && [EMSDKGlobalInfo.productIdentifiers containsObject:purchaseOrder.appleProductId] == NO) {
        NSMutableSet *new_set = [[NSMutableSet alloc] initWithSet:EMSDKGlobalInfo.productIdentifiers];
        [new_set addObject:purchaseOrder.appleProductId];
        EMSDKGlobalInfo.productIdentifiers = new_set;
        
        [self em11_getPurchaseProduces:YES];
    } else {
        if (EMSDKGlobalInfo.purchaseProduces) {
            [self em11_u_GetProductAndStartPurchaseForCPOrder:purchaseOrder];
        } else {
            [self em11_getPurchaseProduces:YES];
        }
    }
}

- (void)em11_recheckCachePurchaseOrderReceipts {
    NSArray *dictList = [self em11_u_getOrderReceiptsFromKeychain];
    if (dictList && dictList.count > 0) {
        
        for (NSDictionary *dict in dictList) {
            NSString *json = dict[[NSString stringWithFormat:@"%@",@"purchaseOrderJson"]];
            NSString *receipt = dict[[NSString stringWithFormat:@"%@",@"receipt"]];

            if (json && json.length > 0) {
                ZhenwupPurchaseProduceOrder_Entity *purchaseOrder = [[ZhenwupPurchaseProduceOrder_Entity alloc] initWithJsonString:json];
                purchaseOrder.flag = 200;
                
                if (purchaseOrder && [purchaseOrder.purchaseUserId isEqualToString:EMSDKGlobalInfo.userInfo.userID]) {
                    [self.em11_purchaseServer em11_checkAppleReceipt:receipt withPurshaseOrder:purchaseOrder msg:@"" responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull result) {
                        if (result.em14_responseCode != EM_ResponseCodeNetworkError && result.em14_responseCode != EM_ResponseCodeTokenFailureError && result.em14_responseCode != EM_ResponseCodeTokenError && result.em14_responseCode != EM_ResponseCodeReLoginError && result.em14_responseCode != EM_ResponseCodeServerError) {
                            [self em11_u_removeOrderReceiptFromKeychain:purchaseOrder];
                        }
                    }];
                }
            }
        }
    }
    
    for (SKPaymentTransaction *transaction in [[SKPaymentQueue defaultQueue] transactions]) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:{
                [self em11_u_verifyReceiptWithTransaction:transaction flag:100];
            }
                break;
            case SKPaymentTransactionStateFailed:{
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            }
                break;
            case SKPaymentTransactionStateRestored: {
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
            }
                break;
            case SKPaymentTransactionStatePurchasing:
            default:
                break;
        }
    }
}

- (void)em11_restorePurchaseProduces {
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}


- (void)em11_u_EndOfPurchase {
    self.em11_purchaseOrder = nil;
    
    EM_RunInMainQueue(^{
        [MBProgressHUD em14_DismissLoadingHUD];
    });
}

- (void)em11_u_GetProductAndStartPurchaseForCPOrder:(ZhenwupPurchaseProduceOrder_Entity *)purchaseOrder {
    SKProduct *purchaseOrder_product = nil;
    for (SKProduct *product in EMSDKGlobalInfo.purchaseProduces) {
        if ([purchaseOrder.appleProductId isEqualToString:product.productIdentifier]) {
            purchaseOrder.currencyType = [product.priceLocale objectForKey:NSLocaleCurrencyCode];
            purchaseOrder.producePrice = product.price;

            purchaseOrder_product = product;
            break;
        }
    }
    
    if (purchaseOrder_product != nil) {
        [self em11_u_createPurchaseOrder:purchaseOrder withProduct:purchaseOrder_product];
    } else {
        EM_RunInMainQueue(^{
            [self em11_u_EndOfPurchase];
            
            NSString *msg = [NSString stringWithFormat:@"%@%@%@",MUUQYLocalizedString(@"EMKey_ProductInvalidOrNotExist_Pre_Text"), purchaseOrder.appleProductId, MUUQYLocalizedString(@"EMKey_ProductInvalidOrNotExist_Suf_Text")];
            [MBProgressHUD em14_showError_Toast:msg];
            
            ZhenwupResponseObject_Entity *em11_result = [[ZhenwupResponseObject_Entity alloc] init];
            em11_result.em14_responseType = EM_ResponseTypeApplePay;
            em11_result.em14_responseCode = EM_ResponseCodeApplePayInvalidIProduceId;
            em11_result.em14_responeMsg = msg;
            
            if (EMSDKAPI.delegate && [EMSDKAPI.delegate respondsToSelector:@selector(zwp01_startPurchaseProduceOrderFinished:)]) {
                [EMSDKAPI.delegate zwp01_startPurchaseProduceOrderFinished:em11_result];
            }
        });
    }
}

- (void)em11_u_createPurchaseOrder:(ZhenwupPurchaseProduceOrder_Entity *)purchaseOrder withProduct:(SKProduct *)product {
    [self.em11_purchaseServer em11_createAndGetChOrderNo:purchaseOrder responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        if (result.em14_responseCode == EM_ResponseCodeSuccess) {
            purchaseOrder.chOrderNO = result.em14_responeResult[[NSString stringWithFormat:@"%@",@"sdk_orderno"]];
            [self em11_u_hikeApplePurchaseOrder:purchaseOrder withProduct:product];
        } else {
            EM_RunInMainQueue(^{
                [self em11_u_EndOfPurchase];
                
                [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
            });
        }
    }];
}

- (void)em11_u_hikeApplePurchaseOrder:(ZhenwupPurchaseProduceOrder_Entity *)purchaseOrder withProduct:(SKProduct *)product {
    if (!purchaseOrder.chOrderNO || [purchaseOrder.chOrderNO isKindOfClass:[NSString class]] == NO || purchaseOrder.chOrderNO.length <= 0) {
        EM_RunInMainQueue(^{
            [self em11_u_EndOfPurchase];
            
            ZhenwupResponseObject_Entity *em11_result = [[ZhenwupResponseObject_Entity alloc] init];
            em11_result.em14_responseType = EM_ResponseTypeApplePay;
            em11_result.em14_responseCode = EM_ResponseCodeApplePayFailureError;
            em11_result.em14_responeMsg = MUUQYLocalizedString(@"EMKey_GetChOrderNoFail_Alert_Text");
            
            [MBProgressHUD em14_showError_Toast:em11_result.em14_responeMsg];
            
            if (EMSDKAPI.delegate && [EMSDKAPI.delegate respondsToSelector:@selector(zwp01_startPurchaseProduceOrderFinished:)]) {
                [EMSDKAPI.delegate zwp01_startPurchaseProduceOrderFinished:em11_result];
            }
        });
    } else {
        if (product == nil) {
            [self em11_u_EndOfPurchase];
            
            return;
        }
        
        SKMutablePayment *payment = [SKMutablePayment paymentWithProduct:product];
        payment.applicationUsername = purchaseOrder.chOrderNO;
        [[SKPaymentQueue defaultQueue] addPayment:payment];
        
        [self em11_u_saveStartOrder:purchaseOrder];
        
        EM_RunInMainQueue(^{
            ZhenwupResponseObject_Entity *em11_result = [[ZhenwupResponseObject_Entity alloc] init];
            em11_result.em14_responseType = EM_ResponseTypeApplePay;
            em11_result.em14_responseCode = EM_ResponseCodeSuccess;
            em11_result.em14_responeResult = @{[NSString stringWithFormat:@"%@",@"purchaseOrder"]: [purchaseOrder em14_jsonString]};
            
            if (EMSDKAPI.delegate && [EMSDKAPI.delegate respondsToSelector:@selector(zwp01_startPurchaseProduceOrderFinished:)]) {
                [EMSDKAPI.delegate zwp01_startPurchaseProduceOrderFinished:em11_result];
            }
        });
    }
}

- (void)em11_u_verifyReceiptWithTransaction:(SKPaymentTransaction *)transaction flag:(NSInteger)flag {
    MYMGLog(@"内购:验单 productid=%@, transaction.payment.applicationUsername=%@, flag：%ld", transaction.payment.productIdentifier, transaction.payment.applicationUsername, (long)flag);
    
    NSString *base64_receipt = nil;
    NSData *receiptData = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] appStoreReceiptURL]];
    if(receiptData){
        base64_receipt = [receiptData base64EncodedStringWithOptions:0];
    }
    
    ZhenwupPurchaseProduceOrder_Entity *tradingPurchaseOrder = nil;
    if (flag == 0) {
        if (self.em11_purchaseOrder && [self.em11_purchaseOrder.appleProductId isEqualToString:transaction.payment.productIdentifier]) {
            tradingPurchaseOrder = self.em11_purchaseOrder;
        }
    }
    
    NSString *msg = nil;
    if (!tradingPurchaseOrder) {
        NSString *order_json = [self em11_u_getStartOrdersForProductid:transaction.payment.productIdentifier];
        tradingPurchaseOrder = [[ZhenwupPurchaseProduceOrder_Entity alloc] initWithJsonString:order_json];
        if (order_json == nil || order_json.length <= 0) {
            tradingPurchaseOrder.appleProductId = transaction.payment.productIdentifier;
            msg = [NSString stringWithFormat:@"%@",@"验单从本地获取发起支付的购买订单为空的。"];
            EM_RunInMainQueue(^{
                [MBProgressHUD em14_showError_Toast:msg];
            });
        }
    }
    tradingPurchaseOrder.appleOrderNO = transaction.transactionIdentifier;
    
    [self em11_u_saveToKeychainOrder:tradingPurchaseOrder wtihReceipt:base64_receipt];
    [self em11_u_removeStartOrder:tradingPurchaseOrder];
    
    
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    
    tradingPurchaseOrder.flag = flag;
    [self.em11_purchaseServer em11_checkAppleReceipt:base64_receipt withPurshaseOrder:tradingPurchaseOrder msg:msg responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull result) {
        if (flag == 0 && self.em11_purchaseOrder) {
            [self em11_u_EndOfPurchase];
            
            if (result.em14_responseCode != EM_ResponseCodeSuccess) {
                EM_RunInMainQueue(^{
                    [MBProgressHUD em14_showError_Toast:result.em14_responeMsg];
                });
            }
        }
        
        if (result.em14_responseCode == EM_ResponseCodeSuccess) {
            double purchase_price = [tradingPurchaseOrder.producePrice doubleValue];
            if (purchase_price > 0) {
                NSString *currency = tradingPurchaseOrder.currencyType?:[NSString stringWithFormat:@"%@",@"VND"];
                
                ADJEvent *event = [ADJEvent eventWithEventToken:EMSDKGlobalInfo.adjustConfig.zwp01_eventTokenPurchase];
                [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:EMSDKGlobalInfo.userInfo.userID?:@""];
                [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"order_id"] value:tradingPurchaseOrder.chOrderNO?:@""];
                [event setRevenue:purchase_price currency:currency];
                [Adjust trackEvent:event];
                
                [FIRAnalytics logEventWithName:[NSString stringWithFormat:@"%@",@"充值金额"] parameters:@{kFIRParameterPrice : @(purchase_price), kFIRParameterCurrency : currency, [NSString stringWithFormat:@"%@",@"order_id"]: tradingPurchaseOrder.chOrderNO?:@""}];
                
                [self em11_u_SendAdjustARPUEvent:purchase_price currency:currency orderId:tradingPurchaseOrder.chOrderNO?:@""];
            }
        }
        
        if (result.em14_responseCode != EM_ResponseCodeNetworkError && result.em14_responseCode != EM_ResponseCodeTokenFailureError && result.em14_responseCode != EM_ResponseCodeTokenError && result.em14_responseCode != EM_ResponseCodeReLoginError && result.em14_responseCode != EM_ResponseCodeServerError) {
            
            [self em11_u_removeOrderReceiptFromKeychain:tradingPurchaseOrder];
        }
    }];
}

- (void)em11_u_SendAdjustARPUEvent:(double)price currency:(NSString *)currency orderId:(NSString *)orderId {
    NSArray *arpu_level = @[@(2199000),@(1199000),@(709000),@(219000),@(109000)];
    if (currency) {
        if ([currency isEqualToString:@"USD"]) {
            arpu_level = @[@(99.99),@(49.99),@(29.99),@(9.99),@(4.99)];
        } else if ([currency isEqualToString:@"CNY"]) {
            arpu_level = @[@(648),@(348),@(208),@(68),@(30)];
        } else if ([currency isEqualToString:@"THB"]) {
            arpu_level = @[@(3000),@(1700),@(929),@(299),@(149)];
        }
    }
    
    if (price >= [arpu_level[0] doubleValue]) {
        ADJEvent *event = [ADJEvent eventWithEventToken:EMSDKGlobalInfo.adjustConfig.zwp01_eventTokenPurchaseARPU100];
        [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:EMSDKGlobalInfo.userInfo.userID?:@""];
        [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"order_id"] value:orderId];
        [Adjust trackEvent:event];
        
        [FIRAnalytics logEventWithName:[NSString stringWithFormat:@"%@",@"充值_99_99"] parameters:@{[NSString stringWithFormat:@"%@",@"order_id"]: orderId}];
    }
    if (price >= [arpu_level[1] doubleValue]) {
        ADJEvent *event = [ADJEvent eventWithEventToken:EMSDKGlobalInfo.adjustConfig.zwp01_eventTokenPurchaseARPU50];
        [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:EMSDKGlobalInfo.userInfo.userID?:@""];
        [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"order_id"] value:orderId];
        [Adjust trackEvent:event];
        
        [FIRAnalytics logEventWithName:[NSString stringWithFormat:@"%@",@"充值_49_99"] parameters:@{[NSString stringWithFormat:@"%@",@"order_id"]: orderId}];
    }
    if (price >= [arpu_level[2] doubleValue]) {
        ADJEvent *event = [ADJEvent eventWithEventToken:EMSDKGlobalInfo.adjustConfig.zwp01_eventTokenPurchaseARPU30];
        [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:EMSDKGlobalInfo.userInfo.userID?:@""];
        [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"order_id"] value:orderId];
        [Adjust trackEvent:event];
        
        [FIRAnalytics logEventWithName:[NSString stringWithFormat:@"%@",@"充值_29_99"] parameters:@{[NSString stringWithFormat:@"%@",@"order_id"]: orderId}];
    }
    if (price >= [arpu_level[3] doubleValue]) {
        ADJEvent *event = [ADJEvent eventWithEventToken:EMSDKGlobalInfo.adjustConfig.zwp01_eventTokenPurchaseARPU10];
        [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:EMSDKGlobalInfo.userInfo.userID?:@""];
        [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"order_id"] value:orderId];
        [Adjust trackEvent:event];
        
        [FIRAnalytics logEventWithName:[NSString stringWithFormat:@"%@",@"充值_9_99"] parameters:@{[NSString stringWithFormat:@"%@",@"order_id"]: orderId}];
    }
    if (price >= [arpu_level[4] doubleValue]) {
        ADJEvent *event = [ADJEvent eventWithEventToken:EMSDKGlobalInfo.adjustConfig.zwp01_eventTokenPurchaseARPU5];
        [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:EMSDKGlobalInfo.userInfo.userID?:@""];
        [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"order_id"] value:orderId];
        [Adjust trackEvent:event];
        
        [FIRAnalytics logEventWithName:[NSString stringWithFormat:@"%@",@"充值_4_99"] parameters:@{[NSString stringWithFormat:@"%@",@"order_id"]: orderId}];
    }
    ADJEvent *event = [ADJEvent eventWithEventToken:EMSDKGlobalInfo.adjustConfig.zwp01_eventTokenPurchaseARPU1];
    [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"user_id"] value:EMSDKGlobalInfo.userInfo.userID?:@""];
    [event addPartnerParameter:[NSString stringWithFormat:@"%@",@"order_id"] value:orderId];
    [Adjust trackEvent:event];
    
    [FIRAnalytics logEventWithName:[NSString stringWithFormat:@"%@",@"充值_0_99"] parameters:@{[NSString stringWithFormat:@"%@",@"order_id"]: orderId}];
}


- (void)em11_u_saveStartOrder:(ZhenwupPurchaseProduceOrder_Entity *)purchaseOrder {
    [self.lock lock];
    if (purchaseOrder) {
        ZhenwupPurchaseProduceOrder_Entity *starPurchaseOrder = purchaseOrder;
        NSString *order_jsonString = [starPurchaseOrder em14_jsonString];
        if (!order_jsonString || order_jsonString.length <= 0) {
            EM_RunInMainQueue(^{
                [MBProgressHUD em14_showError_Toast:[NSString stringWithFormat:@"%@",@"保存发起订单，订单对象转json失败。"]];
            });
        } else {
            NSString *key = starPurchaseOrder.appleProductId?:@"";
            NSDictionary *savedDict = [ZhenwupKeychain_Manager em14_keychainObjectForService:MYMLAppPurchaseCreateOrdersDataKey andAccount:MYMLAppPurchaseCreateOrdersDataKey];
            NSMutableDictionary *newDict = savedDict?[savedDict mutableCopy]:[[NSMutableDictionary alloc] init];
            [newDict setObject:order_jsonString forKey:key];
            
            [ZhenwupKeychain_Manager em14_keychainSaveObject:newDict forService:MYMLAppPurchaseCreateOrdersDataKey andAccount:MYMLAppPurchaseCreateOrdersDataKey];
        }
    }
    [self.lock unlock];
}

- (void)em11_u_removeStartOrder:(ZhenwupPurchaseProduceOrder_Entity *)purchaseOrder {
    [self.lock lock];
    if (purchaseOrder) {
        ZhenwupPurchaseProduceOrder_Entity *starPurchaseOrder = purchaseOrder;
        NSString *key = starPurchaseOrder.appleProductId?:@"";
        NSDictionary *savedDict = [ZhenwupKeychain_Manager em14_keychainObjectForService:MYMLAppPurchaseCreateOrdersDataKey andAccount:MYMLAppPurchaseCreateOrdersDataKey];
        if (savedDict && savedDict.count > 0) {
            NSMutableDictionary *newDict = [savedDict mutableCopy];
            [newDict removeObjectForKey:key];
            
            [ZhenwupKeychain_Manager em14_keychainSaveObject:newDict forService:MYMLAppPurchaseCreateOrdersDataKey andAccount:MYMLAppPurchaseCreateOrdersDataKey];
        }
    }
    [self.lock unlock];
}

- (NSString *)em11_u_getStartOrdersForProductid:(NSString *)productid {
    [self.lock lock];
    NSString *key = productid;
    NSDictionary *savedDict = [ZhenwupKeychain_Manager em14_keychainObjectForService:MYMLAppPurchaseCreateOrdersDataKey andAccount:MYMLAppPurchaseCreateOrdersDataKey];
    NSString *order_jsonString = [savedDict objectForKey:key];
    [self.lock unlock];
    return order_jsonString;
}

- (void)em11_u_saveToKeychainOrder:(ZhenwupPurchaseProduceOrder_Entity *)purchaseOrder wtihReceipt:(NSString *)receiptStr {
    [self.verlock lock];
    NSString *key = purchaseOrder.chOrderNO;
    NSString *order_jsonString = [purchaseOrder em14_jsonString];
    NSString *purchaseUserId = purchaseOrder.purchaseUserId;
    if (!order_jsonString || order_jsonString.length <= 0) {
        EM_RunInMainQueue(^{
            [MBProgressHUD em14_showError_Toast:[NSString stringWithFormat:@"%@",@"保存验证订单，订单对象转json失败。"]];
        });
    } else {
        if (key && key.length > 0) {
            NSDictionary *savedDict = [ZhenwupKeychain_Manager em14_keychainObjectForService:MYMLInAppPurchaseVerfysOrdersDataKey andAccount:purchaseUserId];
            
            NSMutableDictionary *newDict = savedDict?[savedDict mutableCopy]:[[NSMutableDictionary alloc] init];
            [newDict setObject:@{[NSString stringWithFormat:@"%@",@"purchaseOrderJson"]:order_jsonString, [NSString stringWithFormat:@"%@",@"receipt"]:receiptStr?:@""} forKey:key];
            
            [ZhenwupKeychain_Manager em14_keychainSaveObject:newDict forService:MYMLInAppPurchaseVerfysOrdersDataKey andAccount:purchaseUserId];
        } else {
            EM_RunInMainQueue(^{
                [MBProgressHUD em14_showError_Toast:[NSString stringWithFormat:@"%@",@"保存验证订单，SDK订单号为空。"]];
            });
        }
    }
    [self.verlock unlock];
}

- (void)em11_u_removeOrderReceiptFromKeychain:(ZhenwupPurchaseProduceOrder_Entity *)purchaseOrder {
    [self.verlock lock];
    NSString *key = purchaseOrder.chOrderNO;
    NSString *purchaseUserId = purchaseOrder.purchaseUserId;
    if (key && key.length > 0) {
        NSDictionary *savedDict = [ZhenwupKeychain_Manager em14_keychainObjectForService:MYMLInAppPurchaseVerfysOrdersDataKey andAccount:purchaseUserId];
        if (savedDict && savedDict.count > 0) {
            NSMutableDictionary *newDict = [savedDict mutableCopy];
            [newDict removeObjectForKey:key];
            
            [ZhenwupKeychain_Manager em14_keychainSaveObject:newDict forService:MYMLInAppPurchaseVerfysOrdersDataKey andAccount:purchaseUserId];
        }
    }
    [self.verlock unlock];
}

- (NSArray *)em11_u_getOrderReceiptsFromKeychain {
    [self.verlock lock];
    NSDictionary *savedDict = [ZhenwupKeychain_Manager em14_keychainObjectForService:MYMLInAppPurchaseVerfysOrdersDataKey andAccount:EMSDKGlobalInfo.userInfo.userID];
    [self.verlock unlock];
    return savedDict.allValues;
}


- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    NSArray *myProduct = response.products;
    
    MYMGLog(@"内购:向苹果服务器请求产品结果 invalidProductIdentifiers:%@ 产品付费数量: %d",response.invalidProductIdentifiers, (int)myProduct.count);
    NSMutableArray *productsPrices = [[NSMutableArray alloc] initWithCapacity:myProduct.count];
    for(SKProduct *product in myProduct){
        MYMGLog(@"\n\n Product id: %@ \n 描述信息: %@ \n 产品标题: %@\n 产品描述信息: %@\n 价格: %@\n 货币类型: %@\n",
                   product.productIdentifier, product.description,
                   product.localizedTitle, product.localizedDescription,
                   product.price, [product.priceLocale objectForKey:NSLocaleCurrencyCode]);
        
        [productsPrices addObject:@{[NSString stringWithFormat:@"%@",@"productPrice"] : (product.price?:@""),
                                   [NSString stringWithFormat:@"%@",@"currencyType"] : ([product.priceLocale objectForKey:NSLocaleCurrencyCode]?:@""),
                                   [NSString stringWithFormat:@"%@",@"applePayProductId"] : (product.productIdentifier?:@"")}];
    }
    
    EMSDKGlobalInfo.purchaseProduces = myProduct;
    
    self.em11_is_geting_products = NO;
    
    if (self.em11_purchaseOrder) {
        [self em11_u_GetProductAndStartPurchaseForCPOrder:self.em11_purchaseOrder];
    } else {
        EM_RunInMainQueue(^{
            ZhenwupResponseObject_Entity *em11_result = [[ZhenwupResponseObject_Entity alloc] init];
            em11_result.em14_responseType = EM_ResponseTypeApplePay;
            if (myProduct.count <= 0) {
                em11_result.em14_responseCode = EM_ResponseCodeApplePayNoGoods;
            } else {
                em11_result.em14_responseCode = EM_ResponseCodeSuccess;
                em11_result.em14_responeResult = @{[NSString stringWithFormat:@"%@",@"productsPrices"] : productsPrices};
            }
            
            if (EMSDKAPI.delegate && [EMSDKAPI.delegate respondsToSelector:@selector(zwp01_getPurchaseProducesFinished:)]) {
                [EMSDKAPI.delegate zwp01_getPurchaseProducesFinished:em11_result];
            }
        });
    }
}


- (void)request:(SKRequest *)request didFailWithError:(NSError *)error {
    self.em11_is_geting_products = NO;
    
    EM_RunInMainQueue(^{
        if (self.em11_purchaseOrder) {
            [self em11_u_EndOfPurchase];
            
            [MBProgressHUD em14_showError_Toast:error.localizedDescription];
        }
        
        ZhenwupResponseObject_Entity *em11_result = [[ZhenwupResponseObject_Entity alloc] init];
        em11_result.em14_responseType = EM_ResponseTypeApplePay;
        em11_result.em14_responseCode = EM_ResponseCodeApplePayRequestFailure;
        em11_result.em14_responeMsg = error.localizedDescription;
        
        if (EMSDKAPI.delegate && [EMSDKAPI.delegate respondsToSelector:@selector(zwp01_getPurchaseProducesFinished:)]) {
            [EMSDKAPI.delegate zwp01_getPurchaseProducesFinished:em11_result];
        }
    });
}

- (void)requestDidFinish:(SKRequest *)request {
    self.em11_is_geting_products = NO;
}


- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
    for(SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchased:{
                [self em11_u_verifyReceiptWithTransaction:transaction flag:0];
            }
                break;
            case SKPaymentTransactionStateFailed:{
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                EM_RunInMainQueue(^{
                    [self em11_u_EndOfPurchase];
                    
                    ZhenwupResponseObject_Entity *em11_result = [[ZhenwupResponseObject_Entity alloc] init];
                    em11_result.em14_responseType = EM_ResponseTypeApplePay;
                    
                    if (transaction.error.code == SKErrorPaymentCancelled) {
                        em11_result.em14_responseCode = EM_ResponseCodeApplePayCancel;
                        em11_result.em14_responeMsg = MUUQYLocalizedString(@"EMKey_AuthorizeCanceled_Alert_Text");
                    } else {
                        em11_result.em14_responseCode = EM_ResponseCodeApplePayFailureError;
                        em11_result.em14_responeMsg = transaction.error.localizedDescription;
                    }
                    
                    [MBProgressHUD em14_showError_Toast:em11_result.em14_responeMsg];
                    
                    if (EMSDKAPI.delegate && [EMSDKAPI.delegate respondsToSelector:@selector(zwp01_startPurchaseProduceOrderFinished:)]) {
                        [EMSDKAPI.delegate zwp01_startPurchaseProduceOrderFinished:em11_result];
                    }
                });
            }
                break;
            case SKPaymentTransactionStateRestored: {
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                
                [self em11_u_EndOfPurchase];
            }
                break;
            case SKPaymentTransactionStatePurchasing:
            default:
                break;
        }
    }
}

@end
