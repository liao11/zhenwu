//
//  ZhenwupVerifyCodeView.h
//  EmpriSDK
//
//  Created by Admin on 2023/1/12.
//  Copyright © 2023 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef void (^CodeResignCompleted)(NSString *content);
typedef void (^CodeResignUnCompleted)(NSString *content);

@interface ZhenwupVerifyCodeView : UIView

@property (copy, nonatomic) CodeResignCompleted codeResignCompleted;
@property (copy, nonatomic) CodeResignUnCompleted codeResignUnCompleted;

- (instancetype) initWithCodeBits:(NSInteger)codeBits;



///验证码文字
@property (strong, nonatomic) NSString *codeText;

///设置验证码位数 默认 4 位
@property (nonatomic) NSInteger codeCount;

///验证码数字之间的间距 默认 35
@property (nonatomic) CGFloat codeSpace;




@end

NS_ASSUME_NONNULL_END
