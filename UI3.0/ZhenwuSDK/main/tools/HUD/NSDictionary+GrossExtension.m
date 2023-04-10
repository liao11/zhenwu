
#import "NSDictionary+GrossExtension.h"

#define em14_isValidKey(key) ((key) != nil && ![key isKindOfClass:[NSNull class]])
#define em14_isValidValue(value) (((value) != nil) && ![value isKindOfClass:[NSNull class]])

@implementation NSDictionary (MYMGExtension)

- (NSString *)em14_jsonString
{
    NSData *infoJsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    NSString *json = [[NSString alloc] initWithData:infoJsonData encoding:NSUTF8StringEncoding];
    return json;
}

+ (NSDictionary *)em14_dictWithJsonString:(NSString *)json
{
    NSData *infoData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *info = [NSJSONSerialization JSONObjectWithData:infoData options:0 error:nil];
    return info;
}

@end

@implementation NSDictionary (MYMGSafe)

- (id)em14_safeObjectForKey:(id)key {
    if (!em14_isValidKey(key)) {
        return nil;
    }
    id obj = [self objectForKey:key];
    if(!em14_isValidValue(obj))
        return nil;
    return obj;
}

- (int)em14_intValueForKey:(id)key {
    id obj = [self em14_safeObjectForKey:key];
    return [obj intValue];
}

- (double)em14_doubleValueForKey:(id)key {
    id obj = [self em14_safeObjectForKey:key];
    return [obj doubleValue];
}

- (NSString *)em14_stringValueForKey:(id)key {
    id obj = [self em14_safeObjectForKey:key];
    if ([obj respondsToSelector:@selector(stringValue)]) {
        return [obj stringValue];
    }
    
    return nil;
}

@end

@implementation NSMutableDictionary(MYMGSafe)

- (void)em14_safeSetObject:(id)anObject forKey:(id)aKey {
    if (!em14_isValidKey(aKey)) {
        return;
    }
    if ([aKey isKindOfClass:[NSString class]]) {
        [self setValue:anObject forKey:aKey];
    }
    else {
        if (anObject != nil) {
            [self setObject:anObject forKey:aKey];
        }
        else {
            [self removeObjectForKey:aKey];
        }
    }
}

- (void)em14_setIntValue:(int)value forKey:(id)aKey {
    [self em14_safeSetObject:[[NSNumber numberWithInt:value] stringValue] forKey:aKey];
}

- (void)em14_setDoubleValue:(double)value forKey:(id)aKey {
    [self em14_safeSetObject:[[NSNumber numberWithDouble:value] stringValue] forKey:aKey];
}

- (void)em14_setStringValueForKey:(NSString *)string forKey:(id)aKey {
    [self em14_safeSetObject:string forKey:aKey];
}

@end
