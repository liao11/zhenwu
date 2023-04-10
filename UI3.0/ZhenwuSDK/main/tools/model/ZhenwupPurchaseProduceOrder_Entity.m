
#import "ZhenwupPurchaseProduceOrder_Entity.h"
#import <objc/runtime.h>
#import "NSDictionary+GrossExtension.h"

@implementation ZhenwupPurchaseProduceOrder_Entity

+ (instancetype)initWithCPPurchaseOrder:(ZhenwupCPPurchaseOrder_Entity *)cpOrder
{
    ZhenwupPurchaseProduceOrder_Entity *order = [[ZhenwupPurchaseProduceOrder_Entity alloc] init];
    order.cpOrderNO = cpOrder.cpOrderNO;
    order.cpExtraInfo = cpOrder.cpExtraInfo;
    order.appleProductId = cpOrder.appleProductId;
    order.productName = cpOrder.productName;
    order.cpGameCurrency = cpOrder.cpGameCurrency;
    
    return order;
}

- (instancetype)initWithJsonString:(NSString *)jsonString {
    if (self = [super init]) {
        if (jsonString) {
            NSDictionary *objDict = [NSDictionary em14_dictWithJsonString:jsonString];
            unsigned int count = 0, spcount = 0;
            Ivar *ivarLists = class_copyIvarList([self class], &count);
            Ivar *spIvarList = class_copyIvarList([ZhenwupCPPurchaseOrder_Entity class], &spcount);
            
            for (int i = 0; i < count; i++) {
                const char* name = ivar_getName(ivarLists[i]);
                NSString* strName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
                id value = [objDict em14_safeObjectForKey:strName];
                if (value) {
                    [self setValue:value forKey:strName];
                }
            }
            
            for (int j=0;  j<spcount; j++) {
                const char* name = ivar_getName(spIvarList[j]);
                NSString* strName = [NSString stringWithUTF8String:name];
                id value = [objDict em14_safeObjectForKey:strName];
                if (value) {
                    [self setValue:value forKey:strName];
                }
            }
            
            free(ivarLists);
            free(spIvarList);
        }
    }
    return self;
}
- (NSString *)em14_jsonString {
    unsigned int count = 0, spcount = 0;
    Ivar *ivarLists = class_copyIvarList([self class], &count);
    Ivar *spIvarList = class_copyIvarList([ZhenwupCPPurchaseOrder_Entity class], &spcount);
    
    NSMutableDictionary *objDict = [[NSMutableDictionary alloc] initWithCapacity:count+spcount];
    
    for (int j=0;  j<spcount; j++) {
        const char* name = ivar_getName(spIvarList[j]);
        NSString* strName = [NSString stringWithUTF8String:name];
        [objDict setObject:[self valueForKey:strName]?:@"" forKey:strName];
    }
    
    for (int i = 0; i < count; i++) {
        const char* name = ivar_getName(ivarLists[i]);
        NSString* strName = [NSString stringWithUTF8String:name];
        [objDict setObject:[self valueForKey:strName]?:@"" forKey:strName];
    }
    free(ivarLists);
    free(spIvarList);
    
    return [objDict em14_jsonString]?:@"";
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<Purchase 订单=%@ >",[self em14_jsonString]];
}

@end
