
#import "NSArray+GrossExtension.h"

@implementation NSArray (MYMGExtension)

- (NSString *)em14_jsonString
{
    NSData *infoJsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    NSString *json = [[NSString alloc] initWithData:infoJsonData encoding:NSUTF8StringEncoding];
    return json;
}

+ (NSArray *)em14_arrayWithJsonString:(NSString *)json
{
    NSData *infoData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSArray *array = [NSJSONSerialization JSONObjectWithData:infoData options:0 error:&error];
    if (error) {
        
    }
    return array;
}

@end
