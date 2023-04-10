
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, EM_ResponseCode) {
    
    EM_ResponseCodeUnknown = 110,              
    EM_ResponseCodeNetworkError = 111,         
    EM_ResponseCodeServerError = 112,          
    EM_ResponseCodeSuccess = 200,              
    EM_ResponseCodeParameterError = 201,       
    EM_ResponseCodeIllegalError = 202,         
    EM_ResponseCodeVerifyError = 203,          
    EM_ResponseCodeSystemError = 204,          
    EM_ResponseCodeTokenError = 205,           
    EM_ResponseCodeTokenFailureError = 206,    
    EM_ResponseCodeHandleError = 207,          
    EM_ResponseCodeReLoginError = 208,         
    
    
    EM_ResponseCodeAccountFormatError = 300,           
    EM_ResponseCodeAccountExisting = 301,              
    EM_ResponseCodeForbiddenPhoneForNor = 302,         
    EM_ResponseCodeAccountLimit = 303,                 
    EM_ResponseCodeQuickRegistrationError = 304,       
    EM_ResponseCodeCellPhoneNumberError = 305,         
    EM_ResponseCodeSendVerificationCodeError = 306,    
    EM_ResponseCodeAccountInexistenceError = 307,      
    EM_ResponseCodeAccountAbnormityError = 308,        
    EM_ResponseCodeVerificationCodeError = 309,        
    EM_ResponseCodeSendInitailPwdError = 310,          
    EM_ResponseCodeAccountLocked = 311,                
    EM_ResponseCodePwdError = 312,                     
    EM_ResponseCodeVerificationCodeFailure = 313,      
    EM_ResponseCodeVisitorsAccountRegisteredFTD = 314, 
    EM_ResponseCodeUnboundMainbox = 320,               
    
    
    EM_ResponseCodeGenerateOrderError = 400,       
    EM_ResponseCodeOrderInexistenceError = 401,    
    EM_ResponseCodeOrderMoneyError = 402,          
    
    
    EM_ResponseCodeBindedAccount = 500,            
    EM_ResponseCodeGainVerificationCode = 501,     
    EM_ResponseCodeBindedAccountFailure = 502,     
    EM_ResponseCodeAlterPwdfailure = 503,          
    
    
    EM_ResponseCodeApplePayFailureError = 600,             
    EM_ResponseCodeApplePayCancel = 601,                   
    EM_ResponseCodeApplePayNoGoods = 602,                  
    EM_ResponseCodeApplePayInvalidIProduceId = 603,        
    EM_ResponseCodeApplePayRestored = 604,                 
    EM_ResponseCodeApplePayCannotMakePayments = 605,       
    EM_ResponseCodeAppleTryAgainLater = 606,               
    EM_ResponseCodeApplePayRequestFailure = 607,           
    EM_ResponseCodeApplePayReceiptInvalid = 608,           
    EM_ResponseCodeGetPriceOfProductsFailure = 609,        
    
    
    EM_ResponseCodeFacebookLoginFailure = 700,            
    EM_ResponseCodeFacebookLoginCancel = 701,             
};

typedef NS_ENUM(NSInteger, EM_ResponseType) {
    EM_ResponseTypeUnknown = 1200,
    EM_ResponseTypeSDKInital = 1201,
    EM_ResponseTypeRegister = 1202,
    EM_ResponseTypeLoginOut = 1203,
    EM_ResponseTypeEnterGame = 1204,
    EM_ResponseTypeApplePay = 1205,
    EM_ResponseTypeNormalLogin = 1206,
    EM_ResponseTypeFacebookLogin = 1207,
    EM_ResponseTypeGuestLogin = 1208,
    EM_ResponseTypeAppleLogin = 1209,
    EM_ResponseTypeTelLogin = 1210,
    EM_ResponseTypeDelete = 1211,
};

NS_ASSUME_NONNULL_BEGIN

@interface ZhenwupResponseObject_Entity : NSObject

@property (nonatomic, assign) EM_ResponseCode em14_responseCode;
@property (nonatomic, assign) EM_ResponseType em14_responseType;
@property (nonatomic, strong, nullable) NSDictionary *em14_responeResult;
@property (nonatomic, copy, nullable) NSString *em14_responeMsg;
- (NSString *)description2;

@end

NS_ASSUME_NONNULL_END
