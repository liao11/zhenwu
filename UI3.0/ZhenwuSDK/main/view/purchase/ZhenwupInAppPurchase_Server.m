
#import "ZhenwupInAppPurchase_Server.h"
#import "UIDevice+GrossExtension.h"
#import "ZhenwupPurchaseProduceOrder_Entity.h"

static NSUInteger verifyReceiptFailureCount = 0;

@implementation ZhenwupInAppPurchase_Server

- (void)em11_createAndGetChOrderNo:(ZhenwupPurchaseProduceOrder_Entity *)purchaseOrder responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    
    if (!purchaseOrder.productName || purchaseOrder.productName.length <= 0) {
        purchaseOrder.productName = purchaseOrder.appleProductId;
    }
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:EMSDKGlobalInfo.userInfo.userID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyUId]];
    [params setObject:EMSDKGlobalInfo.userInfo.userName?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyUsername]];
    [params setObject:EMSDKGlobalInfo.userInfo.token?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyToken]];
    
    [params setObject:EMSDKGlobalInfo.gameInfo.chServerID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyServiceID]];
    [params setObject:EMSDKGlobalInfo.gameInfo.chRoleID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyRoleID]];
    [params setObject:EMSDKGlobalInfo.gameInfo.cpRoleID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyCpRoleId]];
    [params setObject:EMSDKGlobalInfo.gameInfo.cpRoleName?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyCpRoleName]];
    [params setObject:@(EMSDKGlobalInfo.gameInfo.cpRoleLevel).stringValue forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyCpRoleLevel]];
    [params setObject:EMSDKGlobalInfo.gameInfo.cpServerID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyCpServiceID]];
    
    [params setObject:@"2" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyPaType]];
    [params setObject:purchaseOrder.cpOrderNO?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyCpOrderNum]];
    [params setObject:purchaseOrder.productName?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyProductName]];
    [params setObject:purchaseOrder.appleProductId?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyPaProductID]];
    [params setObject:@(purchaseOrder.cpGameCurrency)?:@"0" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyGameMoney]];
    [params setObject:purchaseOrder.cpExtraInfo?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyPaExtra]];
    [params setObject:purchaseOrder.currencyType?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyCurrencyty]];
    [params setObject:purchaseOrder.producePrice?:@"0" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyRealPa]];
    
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpOrderInfoPath];
    [self em14_PostRequestURL:url parameters:params responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull em11_result) {
        em11_result.em14_responseType = EM_ResponseTypeApplePay;
        if (em11_result.em14_responseCode != EM_ResponseCodeSuccess && em11_result.em14_responseCode != EM_ResponseCodeNetworkError) {
            em11_result.em14_responseCode = EM_ResponseCodeGenerateOrderError;
        }
        
        if (responseBlock) {
            responseBlock(em11_result);
        }
        
        if (EMSDKAPI.delegate && [EMSDKAPI.delegate respondsToSelector:@selector(zwp01_startPurchaseProduceOrderFinished:)]) {
            [EMSDKAPI.delegate zwp01_startPurchaseProduceOrderFinished:em11_result];
        }
    }];
}

- (void)em11_checkAppleReceipt:(NSString *)receiptString withPurshaseOrder:(ZhenwupPurchaseProduceOrder_Entity *)purchaseOrder msg:(NSString * _Nullable)msg responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    
    MYMGLog(@"发起服务验证的购买订单 = %@, msg = %@, \n重试次数 = %ld \n", purchaseOrder, msg, (long)verifyReceiptFailureCount);
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:EMSDKGlobalInfo.userInfo.userID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyUId]];
    [params setObject:EMSDKGlobalInfo.userInfo.token?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyToken]];
    
    [params setObject:receiptString?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyProof]];
    [params setObject:purchaseOrder.chOrderNO?:[NSString stringWithFormat:@"%@",@"so"] forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyOrderNum]];
    [params setObject:purchaseOrder.appleOrderNO?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyAppleOrderNum]];
    [params setObject:[NSString stringWithFormat:@"flag:%@ msg:%@", @(purchaseOrder.flag), msg?:@""] forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyFlags]];
    
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpAppleOrderVerifyPath];
    [self em14_PostRequestURL:url parameters:params responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull em11_result) {
        if (em11_result.em14_responseCode == EM_ResponseCodeNetworkError && verifyReceiptFailureCount < 3) {
            verifyReceiptFailureCount += 1;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self em11_checkAppleReceipt:receiptString withPurshaseOrder:purchaseOrder msg:msg responseBlock:responseBlock];
            });
        } else {
            verifyReceiptFailureCount = 0;
            em11_result.em14_responseType = EM_ResponseTypeApplePay;
            em11_result.em14_responeResult = @{[NSString stringWithFormat:@"%@",@"purchaseOrderJson"]: [purchaseOrder em14_jsonString]?:@""};
            
            if (!purchaseOrder.chOrderNO || purchaseOrder.chOrderNO.length <= 0) {
                em11_result.em14_responseCode = EM_ResponseCodeApplePayFailureError;
                em11_result.em14_responeMsg = MUUQYLocalizedString(@"EMKey_ChOrderNoIsNull_Alert_Text");
            }
            
            if (responseBlock) {
                responseBlock(em11_result);
            }
            
            if (EMSDKAPI.delegate && [EMSDKAPI.delegate respondsToSelector:@selector(zwp01_checkOrderAppleReceiptFinished:)]) {
                [EMSDKAPI.delegate zwp01_checkOrderAppleReceiptFinished:em11_result];
            }
        }
    }];
}

@end
