//
//  ZhenwupShowView.h
//  EmpriSDK
//
//  Created by Admin on 2023/2/7.
//  Copyright © 2023 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^AlertResult)(NSInteger index);

@interface ZhenwupShowView : UIView

@property (nonatomic,copy) AlertResult resultIndex;

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message sureBtn:(NSString *)sureTitle cancleBtn:(NSString *)cancleTitle;

- (void)showXLAlertView;

@end

NS_ASSUME_NONNULL_END
