
#import "ZhenwupRemoteData_Server.h"
#import <AFNetworking/AFNetworking.h>
#import <GTMBase64/GTMBase64.h>
#import <Adjust/Adjust.h>
#import "NSString+GrossExtension.h"
#import "NSData+GrossExtension.h"
#import "UIDevice+GrossExtension.h"

@interface ZhenwupRemoteData_Server ()

@property (nonatomic, strong) AFHTTPSessionManager *em14_manager;
@end

@implementation ZhenwupRemoteData_Server

- (instancetype)init {
    if (self = [super init]) {
        _em14_manager = [AFHTTPSessionManager manager];
        _em14_manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
        _em14_manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _em14_manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _em14_manager.requestSerializer.timeoutInterval = 30.0;
        _em14_manager.responseSerializer.acceptableContentTypes =  [NSSet setWithObjects:[NSString stringWithFormat:@"%@",@"text/html"],[NSString stringWithFormat:@"%@",@"text/plain"],[NSString stringWithFormat:@"%@",@"application/json"],[NSString stringWithFormat:@"%@",@"application/xml"],@"application/xhtml+xml",[NSString stringWithFormat:@"%@",@"text/xml"],[NSString stringWithFormat:@"%@",@"*/*"], nil];
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        [securityPolicy setValidatesDomainName:YES];
        _em14_manager.securityPolicy = securityPolicy;
        
        
        
    }
    return self;
}


- (AFSecurityPolicy*)customSecurityPolicy
{
    
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",@"hgcang"] ofType:[NSString stringWithFormat:@"%@",@"cer"]];
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    
    
    securityPolicy.allowInvalidCertificates = YES;
    
    
    
    
    
    securityPolicy.validatesDomainName = NO;
    
    securityPolicy.pinnedCertificates = [NSSet setWithArray:@[certData]];
    
    return securityPolicy;
}

- (NSMutableDictionary *)em14_u_packPublicParameters {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    
    [params setObject:[NSString stringWithFormat:@"%.f", [[NSDate date] timeIntervalSince1970]] forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyTimeStamp]];
    [params setObject:EMSDKAPI.zwp01_SDKVersion forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeySDKVersion]];
    [params setObject:EMSDKGlobalInfo.gameInfo.gameID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyGameId]];
    [params setObject:@"2" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyPlatform]];
    [params setObject:[UIDevice obtainChannel]?:[NSString stringWithFormat:@"%@",@"10"] forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyChannel]];
    [params setObject:[UIDevice obtainSubChannel]?:[NSString stringWithFormat:@"%@",@"01"] forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeySubChannel]];
    
    [params setObject:[UIDevice em_getDeviceNo]?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyDeviceNO]];
    
    //1 idfa  2 idfv
    NSString *em14_iGet = @"1";
    NSString *em_iNor = [UIDevice gainIDFA]?:@"";
    if ([em_iNor hasPrefix:@"00000000"]) {
        em_iNor = [[UIDevice currentDevice].identifierForVendor UUIDString]?:@"";
        em14_iGet = @"2";
    }else{
        em_iNor = [UIDevice gainIDFA];
        em14_iGet = @"1";
    }
    
    [params setObject:em_iNor?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyDeviceIDFA]];
    
    [params setObject:em14_iGet?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyIsIdfa]];
    
    return params;
}

- (NSString *)em14_u_md5SignForParams:(NSMutableDictionary *)params withAppKey:(NSString *)appKey {
    NSMutableString * sign = [NSMutableString string];
    
    if (params && params.count > 0) {
        NSArray *allkeys = [params allKeys];
              
        NSArray *sortKeys = [allkeys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj1 compare:obj2];
        }];
        
        for (int i = 0; i < allkeys.count; i++) {
            NSString * temp = [NSString stringWithFormat:@"%@=%@&",sortKeys[i],[params objectForKey:sortKeys[i]]];
            [sign appendString:temp];
        }
        [sign deleteCharactersInRange:NSMakeRange(sign.length-1, 1)];
    }
      
    if (appKey) {
        [sign appendString:appKey];
    }
       
    return [[sign hash_md5] uppercaseString];
}

- (NSMutableDictionary *)em14_u_encryptParams:(NSMutableDictionary *)parameters {
//    parameters = @{}
    NSString *md5Sign = [self em14_u_md5SignForParams:parameters withAppKey:EMSDKGlobalInfo.gameInfo.gameKey];
    
    [parameters setValue:md5Sign?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeySign]];
    
    NSData * data = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:nil];
    
    data = [data AES128EncryptWithKey:MYMGUrlConfig.em14_datacodeconfig.em14_AES128Key iv:MYMGUrlConfig.em14_datacodeconfig.em14_AES128iv];
    
    data = [GTMBase64 encodeData:data];
    
    NSString *encryptParamsStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    NSMutableDictionary * encryptParams = [[NSMutableDictionary alloc] init];
    [encryptParams setObject:encryptParamsStr?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyData]];
    
    return encryptParams;
}

- (NSDictionary *)em14_u_decryptResponseObject:(NSData *)responseObject {
    if (responseObject) {
        NSData *responseData = responseObject;
        
        responseData = [GTMBase64 decodeData:responseData];
        
        responseData = [responseData AES128DecryptWithKey:MYMGUrlConfig.em14_datacodeconfig.em14_AES128Key iv:MYMGUrlConfig.em14_datacodeconfig.em14_AES128iv];;
        
        NSDictionary *dataDict = nil;
        if (responseData) {
            dataDict = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:nil];
        }
        
        return dataDict;
    }
    
    return nil;
}

- (void)em14_u_refreshNewTokenWithOriginUrl:(NSString *)originUrl parameters:(NSMutableDictionary *)parameters responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    [parameters removeObjectForKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeySign];
    MYMGLog(@"刷新新Token前的待签名参数 parameters=%@",parameters);
    
    [self em14_RefreshToken:^(ZhenwupResponseObject_Entity * _Nonnull em14_result) {
        if (em14_result.em14_responseCode == EM_ResponseCodeSuccess) {
            NSString * token = [em14_result.em14_responeResult objectForKey:[NSString stringWithFormat:@"%@",@"token"]];
            MYMGLog(@"刷新新Token后新token newtoken=%@",token);
            
            [parameters setObject:token?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyToken]];
            [self em14_PostRequestURL:originUrl parameters:parameters responseBlock:responseBlock];
        } else {
            if (responseBlock) {
                responseBlock(em14_result);
            }
        }
    }];
}


+ (NSString *)em14_BuildFinalUrl:(NSString *)url WithPath:(NSString *)path andParams:(NSDictionary *)params {
    NSMutableString * finalUrl = [[NSMutableString alloc] initWithFormat:@"%@%@",url, path];
    
    if (params && params.count > 0) {
        NSRange range = [finalUrl rangeOfCharacterFromSet:[NSCharacterSet characterSetWithCharactersInString:@"?"]];
        if (range.location == NSNotFound) {
            [finalUrl appendString:@"?"];
        } else {
            [finalUrl appendString:@"&"];
        }
        
        NSArray *keys = params.allKeys;
        for (int i=0; i<keys.count; i++) {
            NSString *key = keys[i];
            NSString *value = [params objectForKey:key];
            
            NSString *s = [NSString stringWithFormat:@"%@=%@", [key urlEncoding], [value urlEncoding]];
            [finalUrl appendString:s];
            
            if (i < keys.count-1) {
                [finalUrl appendString:@"&"];
            }
        }
    }
       
    return finalUrl;
}

- (NSString *)em14_BuildFinalUrlWithPath:(NSString *)urlPath {
    return [NSString stringWithFormat:@"%@%@",MYMGUrlConfig.em14_httpsdomain.em14_baseUrl, urlPath];
}

- (NSString *)em14_ParseParamKey:(NSString *)key {
    return key;
}

- (void)em14_SetDeviceInfosIntoParams:(NSMutableDictionary *)params {
    [params setObject:[UIDevice em14_getCurrentDeviceNetworkingStates]?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyDeviceNetwork]];
    [params setObject:[UIDevice em14_getCurrentDeviceModelProvider]?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyDeviceModelProvider]];
    [params setObject:[UIDevice em14_getCurrentDeviceModel]?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyDeviceType]];
    [params setObject:[UIDevice currentDevice].systemVersion forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeySystemVersion]];
    [params setObject:Adjust.adid?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyAdjustDeviceID]];
    [params setObject:@"1" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyPlaform]];
}

- (void)em14_PostRequestURL:(NSString *)URL parameters:(NSMutableDictionary *)parameters responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    
    NSMutableDictionary *publicParams = [self em14_u_packPublicParameters];
    
    if (parameters && parameters.count > 0) {
        [publicParams addEntriesFromDictionary:parameters];
    }

    NSMutableDictionary *finalParams = [self em14_u_encryptParams:publicParams];
    
    [_em14_manager POST:URL parameters:finalParams headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        responseObject = [self em14_u_decryptResponseObject:responseObject];
        
        if ([URL hasSuffix:MYMGUrlConfig.em14_rcppathconfig.em14_rcpAppleOrderVerifyPath]) {
            NSMutableDictionary *temp = [publicParams mutableCopy];
            NSString *rp = temp[[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyProof]];
            if (rp && rp.length > 101) {
                [temp setObject:[rp substringToIndex:100] forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyProof]];
            }
            MYMGLog(@"请求url = %@,\n params = %@,\n respone =%@", URL, temp, responseObject);
        } else {
            MYMGLog(@"请求url = %@,\n params = %@,\n respone =%@", URL, publicParams, responseObject);
        }
        
        ZhenwupResponseObject_Entity *response = [[ZhenwupResponseObject_Entity alloc] init];
        response.em14_responeMsg = [responseObject objectForKey:[NSString stringWithFormat:@"%@",@"msg"]];
        response.em14_responseCode = [[responseObject objectForKey:[NSString stringWithFormat:@"%@",@"code"]] integerValue];
        response.em14_responeResult = [responseObject objectForKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyData];
        
        if (!responseObject) {
            response.em14_responseCode = EM_ResponseCodeServerError;
            response.em14_responeMsg = MUUQYLocalizedString(@"EMKey_Https_ServerError_Alert_Text");;
        }
        
        if (response.em14_responseCode == EM_ResponseCodeTokenError || response.em14_responseCode == EM_ResponseCodeTokenFailureError) {
            [self em14_u_refreshNewTokenWithOriginUrl:URL parameters:publicParams responseBlock:responseBlock];
        } else {
            if (responseBlock) {
                responseBlock(response);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MYMGLog(@"请求url = %@, params = %@, error =%@", URL, publicParams, error);
        
        ZhenwupResponseObject_Entity *failureResponse = [[ZhenwupResponseObject_Entity alloc] init];
        failureResponse.em14_responeMsg = [NSString stringWithFormat:@"%@(%ld)",MUUQYLocalizedString(@"EMKey_Https_NetworkError_Alert_Text"),(long)error.code];
        failureResponse.em14_responseCode = EM_ResponseCodeNetworkError;
        failureResponse.em14_responeResult = nil;
        if (responseBlock) {
            responseBlock(failureResponse);
        }
    }];
}

- (void)em14_RefreshToken:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:EMSDKGlobalInfo.userInfo.userName?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyUsername]];
    [params setObject:EMSDKGlobalInfo.userInfo.autoToken?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyRefreshToken]];
    
    NSString *url = [self em14_BuildFinalUrlWithPath:MYMGUrlConfig.em14_rcppathconfig.em14_rcpRefreshTokenPath];
    [self em14_PostRequestURL:url parameters:params responseBlock:^(ZhenwupResponseObject_Entity * _Nonnull em14_result) {
        if (em14_result.em14_responseCode == EM_ResponseCodeSuccess) {
            EMSDKGlobalInfo.userInfo.token = [em14_result.em14_responeResult objectForKey:[NSString stringWithFormat:@"%@",@"token"]];
        }
        
        if (responseBlock) {
            responseBlock(em14_result);
        }
    }];
}

- (void)em14_RequestPath:(NSString *)path parameters:(NSDictionary *)parameters  responseBlock:(void(^)(ZhenwupResponseObject_Entity *result))responseBlock {
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:EMSDKGlobalInfo.userInfo.userID?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyUId]];
    [params setObject:EMSDKGlobalInfo.userInfo.token?:@"" forKey:[self em14_ParseParamKey:MYMGUrlConfig.em14_paramsconfig.em14_ckeyToken]];
    if (parameters && parameters.count > 0) {
        [params addEntriesFromDictionary:parameters];
    }
    
    NSString *url = [self em14_BuildFinalUrlWithPath:path];
    [self em14_PostRequestURL:url parameters:params responseBlock:responseBlock];
}
@end
