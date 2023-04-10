
#import "ZhenwupResponseObject_Entity.h"

@implementation ZhenwupResponseObject_Entity

- (NSString *)description {
    return [NSString stringWithFormat:@"< %@:%p => code:%ld \n type=%ld \n msg=%@, \n result=%@ >",[self class], self, (long)self.em14_responseCode, (long)self.em14_responseType, self.em14_responeMsg, self.em14_responeResult];
}

- (NSString  *)description2 {
    
    
    NSLog(@"dic=%@",self.em14_responeResult);
    
    NSString *str=[NSString stringWithFormat:@"code:%ld", (long)self.em14_responseCode];
    return str;
//     NSData *data=[NSJSONSerialization dataWithJSONObject:self.em14_responeResult options:NSJSONWritingPrettyPrinted error:nil];
//
//    NSString *jsonStr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
//    NSLog(@"jsonStr=%@",jsonStr);
//    return jsonStr;
    
//    return [NSString stringWithFormat:@"code:%ld \n type=%ld \n msg=%@, \n result=%@", (long)self.em14_responseCode, (long)self.em14_responseType, self.em14_responeMsg, self.em14_responeResult];
}
@end
