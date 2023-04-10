
#import "ZhenwupHelper_Utils.h"
#import "ZhenwupSDKGlobalInfo_Entity.h"
#import "ZhenwupOpenAPI.h"
#import "GMGBase64.h"
#import <CommonCrypto/CommonCryptor.h>
#import "DES.h"
@implementation ZhenwupHelper_Utils

+ (NSBundle *)em14_resBundle:(Class)classtype {
    static NSBundle *framworkBundle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        framworkBundle = [NSBundle bundleForClass:classtype];
        if (framworkBundle) {
            NSString *resourceBundlePath = [framworkBundle pathForResource:[NSString stringWithFormat:@"%@",@"ZhenwuBundle"] ofType:[NSString stringWithFormat:@"%@",@"bundle"]];
            if (resourceBundlePath && [[NSFileManager defaultManager] fileExistsAtPath:resourceBundlePath]) {
                framworkBundle = [NSBundle bundleWithPath:resourceBundlePath];
            }
        }
    });
    return framworkBundle;
}
    
+ (UIImage*)imageName:(NSString*)name {
    

    if (name.length == 0) {
        return nil;
    }
    

    NSBundle *bundle = [self em14_resBundle:[self class]];
    NSString *path = [bundle pathForResource:[NSString stringWithFormat:@"%@.png.data",name] ofType:nil];
    NSData *dataImage = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (dataImage) {
        return [[UIImage imageWithData:dataImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return nil;
    
//
//    if (name.length == 0) {
//        return nil;
//    }
//    NSBundle *bundle = [self em14_resBundle:[self class]];
//
//
//
//    NSString *path = [bundle pathForResource:name ofType:[NSString stringWithFormat:@"%@",@"png"]];
//    UIImage *imageData = [UIImage imageWithContentsOfFile:path];
//    if(!imageData){
//        imageData = [self em14_encodeImageView:path];
//    }
//    return imageData;
    
}

+ (UIImage *)imageWithDataName:(NSString *)dataName
{
    if (dataName.length == 0) {
        return nil;
    }
    
    NSBundle *bundle = [self em14_resBundle:[self class]];
    NSString *path = [bundle pathForResource:[NSString stringWithFormat:@"%@.png.data",dataName] ofType:nil];
    NSData *dataImage = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (dataImage) {
        return [[UIImage imageWithData:dataImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    return nil;
}

+ (UIImage *)em14_encodeImageView:(NSString *)filePath {
    NSString *em14_decodeKey = @"";
    NSData *dataEncoded = [NSData dataWithContentsOfFile:filePath];
    NSMutableString *dataString = [NSMutableString stringWithString:[[NSString alloc] initWithData:dataEncoded encoding:NSUTF8StringEncoding]];
    dataString = [NSMutableString stringWithString:[self em14_decodeString:dataString em14_key:em14_decodeKey]]; 
    [dataString deleteCharactersInRange:NSMakeRange(em14_decodeKey.length,  em14_decodeKey.length)];
    NSData *dataDecode = [[NSData alloc] initWithBase64EncodedString:dataString options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *decodeImage = [[UIImage imageWithData:dataDecode] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    return decodeImage;
}
+ (NSString *)em14_normalDecodeString:(NSString *)em14_encodeString {
    NSString *em14_decodeKey = @"";
    NSString *em14_string = [self em14_decodeString:em14_encodeString em14_key:em14_decodeKey];
    
    if ([em14_string containsString:@"\\n"]) {
        em14_string = [em14_string stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
    }
    
    return em14_string.length==0?em14_encodeString:em14_string;
}
+ (NSString*)em14_decodeString:(NSString*)em14_encodeString em14_key:(NSString*)em14_key {
    NSData* asse = [GMGBase64 decodeString:em14_encodeString];
    const char*nRSchizogonic = [em14_encodeString UTF8String];
    NSUInteger er =strlen(nRSchizogonic);
    size_t aNFlightful = er + kCCBlockSizeAES128;
    void *pseudoblepsia = malloc(aNFlightful);
    size_t floatman =0;
    Byte iv[] = {0x12,0x34,0x56,0x78,0x90,0xAB,0xCD,0xEF};
    CCCryptorStatus an =CCCrypt(kCCDecrypt,kCCAlgorithmDES,kCCOptionPKCS7Padding,[em14_key UTF8String],kCCKeySizeDES,iv,[asse bytes],[asse length],pseudoblepsia,aNFlightful,&floatman);
    NSString* nondefense =nil;
    if(an ==kCCSuccess) {
        NSData* data = [NSData dataWithBytes:pseudoblepsia length:(NSUInteger)floatman];
        nondefense = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return nondefense;
}

+ (NSString *)em14_getLocalFromDocAndKey:(NSString *)key{
    NSDictionary *dict = [self em14_getWordParam];
    NSDictionary *subDict = [dict objectForKey:[NSString stringWithFormat:@"%@",@"em14_localStr"]];
    NSString *str = @"";
    str = [subDict objectForKey:[NSString stringWithFormat:@"%@",key]];
    return str;
}


+ (NSDictionary *)em14_getWordParam{
    NSBundle *bundle = [self em14_resBundle:[self class]];
    NSString *path = [bundle pathForResource:@"UI3" ofType:@".plist"];
    NSPropertyListFormat format;
    NSString *errorDesc = nil;
        
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSDictionary *dictionary1 = (NSDictionary *)[NSPropertyListSerialization propertyListFromData:data
                         mutabilityOption:NSPropertyListMutableContainersAndLeaves
                                                                  format:&format
                                                    errorDescription:&errorDesc];
//    NSLog(@"%@", dictionary1);
    //////
    return [NSDictionary dictionaryWithContentsOfFile:path];
}


@end
