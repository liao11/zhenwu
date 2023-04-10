//
//  ZhenwupShowView.m
//  EmpriSDK
//
//  Created by Admin on 2023/2/7.
//  Copyright © 2023 Admin. All rights reserved.
//

#import "ZhenwupShowView.h"
#import "UIView+GrossExtension.h"
#import "ZhenwupTheme_Utils.h"
#import "ZhenwupHelper_Utils.h"

#define EM_RGBA(r,g,b,a)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
///alertView 宽
#define AlertW 320
///各个栏目之间的距离
#define XLSpace 10.0
 
@interface ZhenwupShowView()
 
//弹窗
@property (nonatomic,retain) UIImageView *alertView;
//title
@property (nonatomic,retain) UILabel *titleLbl;
//内容
@property (nonatomic,retain) UILabel *msgLbl;
//确认按钮
@property (nonatomic,retain) UIButton *sureBtn;
//取消按钮
@property (nonatomic,retain) UIButton *cancleBtn;
//横线线
@property (nonatomic,retain) UIView *lineView;
//竖线
@property (nonatomic,retain) UIView *verLineView;
@end
@implementation ZhenwupShowView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message sureBtn:(NSString *)sureTitle cancleBtn:(NSString *)cancleTitle
{
  if (self == [super init]) {
 
    self.frame = [UIScreen mainScreen].bounds;
 
    self.backgroundColor = [UIColor clearColor];
      
      
 
     self.alertView = [[UIImageView alloc] init];
   
 
    self.alertView.frame = CGRectMake(0, 0, AlertW, 100);
    self.alertView.layer.position = self.center;
      self.alertView.backgroundColor=EM_RGBA(37, 46, 54, 1);
      self.alertView.image = [ZhenwupHelper_Utils imageName:@"zhenwuimbg3"];
      self.alertView.userInteractionEnabled=YES;
      
      
      
      self.alertView.layer.cornerRadius = 17;
      [self addSubview:self.alertView];
      
      
      
      
 
    if (title) {
 
      self.titleLbl = [self GetAdaptiveLable:CGRectMake(2*XLSpace, 2*XLSpace, AlertW-4*XLSpace, 20) AndText:title andIsTitle:YES];
      self.titleLbl.textAlignment = NSTextAlignmentCenter;
 
      [self.alertView addSubview:self.titleLbl];
 
      CGFloat titleW = self.titleLbl.bounds.size.width;
      CGFloat titleH = self.titleLbl.bounds.size.height;
 
      self.titleLbl.frame = CGRectMake((AlertW-titleW)/2, 2*XLSpace, titleW, titleH);
 
    }
    if (message) {
 
      self.msgLbl = [self GetAdaptiveLable:CGRectMake(XLSpace, CGRectGetMaxY(self.titleLbl.frame)+XLSpace, AlertW-2*XLSpace, 20) AndText:message andIsTitle:NO];
      self.msgLbl.textAlignment = NSTextAlignmentCenter;
        self.msgLbl.textColor=[UIColor whiteColor];
      [self.alertView addSubview:self.msgLbl];
 
      CGFloat msgW = self.msgLbl.bounds.size.width;
      CGFloat msgH = self.msgLbl.bounds.size.height;
 
      self.msgLbl.frame = self.titleLbl?CGRectMake((AlertW-msgW)/2, CGRectGetMaxY(self.titleLbl.frame)+XLSpace, msgW, msgH):CGRectMake((AlertW-msgW)/2, 2*XLSpace, msgW, msgH);
    }
 
 
    //两个按钮
    if (cancleTitle && sureTitle) {
 
      self.cancleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
      self.cancleBtn.frame = CGRectMake(20, self.msgLbl.em_bottom+20, (AlertW-60)/2, 40);

        
        self.cancleBtn.titleLabel.font = [ZhenwupTheme_Utils em_colors_NormalFont];
        self.cancleBtn.backgroundColor = [ZhenwupTheme_Utils em_colors_SecondaryColor];
        self.cancleBtn.layer.cornerRadius = 5.0;
        self.cancleBtn.layer.masksToBounds = YES;
        [self.cancleBtn setTitle:cancleTitle forState:UIControlStateNormal];
        [self.cancleBtn setTitleColor:[UIColor whiteColor] forState:0];
      self.cancleBtn.tag = 1;
      [self.cancleBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
 
     
 
      [self.alertView addSubview:self.cancleBtn];
    }
 
 
    if(sureTitle && cancleTitle){
 
      self.sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
      self.sureBtn.frame = CGRectMake(40+(AlertW-60)/2, self.msgLbl.em_bottom+20, (AlertW-60)/2, 40);
        self.sureBtn.titleLabel.font = [ZhenwupTheme_Utils em_colors_NormalFont];
        self.sureBtn.backgroundColor = [ZhenwupTheme_Utils em_colors_MainColor];
        self.sureBtn.layer.cornerRadius = 5.0;
        self.sureBtn.layer.masksToBounds = YES;
        
        [self.sureBtn setTitleColor:[UIColor whiteColor] forState:0];
      [self.sureBtn setTitle:sureTitle forState:UIControlStateNormal];
      //[self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
      self.sureBtn.tag = 2;
      [self.sureBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
 

 
      [self.alertView addSubview:self.sureBtn];
 
    }
 
    //只有取消按钮
    if (cancleTitle && !sureTitle) {
 
      self.cancleBtn = [UIButton buttonWithType:UIButtonTypeSystem];
      self.cancleBtn.frame = CGRectMake(0, self.msgLbl.em_bottom+20, AlertW, 40);
        self.cancleBtn.titleLabel.font = [ZhenwupTheme_Utils em_colors_NormalFont];
        self.cancleBtn.backgroundColor = [ZhenwupTheme_Utils em_colors_SecondaryColor];
        self.cancleBtn.layer.cornerRadius = 5.0;
        self.cancleBtn.layer.masksToBounds = YES;
      [self.cancleBtn setTitle:cancleTitle forState:UIControlStateNormal];
      //[self.cancleBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
      self.cancleBtn.tag = 1;
        [self.cancleBtn setTitleColor:[UIColor whiteColor] forState:0];
      [self.cancleBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
 
      UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.cancleBtn.bounds byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(5.0, 5.0)];
      CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
      maskLayer.frame = self.cancleBtn.bounds;
      maskLayer.path = maskPath.CGPath;
      self.cancleBtn.layer.mask = maskLayer;
 
      [self.alertView addSubview:self.cancleBtn];
    }
 
    //只有确定按钮
    if(sureTitle && !cancleTitle){
 
      self.sureBtn = [UIButton buttonWithType:UIButtonTypeSystem];
      self.sureBtn.frame = CGRectMake(0, self.msgLbl.em_bottom+20, AlertW, 40);
        self.sureBtn.titleLabel.font = [ZhenwupTheme_Utils em_colors_NormalFont];
        self.sureBtn.backgroundColor = [ZhenwupTheme_Utils em_colors_MainColor];
        self.sureBtn.layer.cornerRadius = 5.0;
        self.sureBtn.layer.masksToBounds = YES;
        [self.sureBtn setTitleColor:[UIColor whiteColor] forState:0];
      [self.sureBtn setTitle:sureTitle forState:UIControlStateNormal];
      //[self.sureBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
      self.sureBtn.tag = 2;
      [self.sureBtn addTarget:self action:@selector(buttonEvent:) forControlEvents:UIControlEventTouchUpInside];
 
   
 
      [self.alertView addSubview:self.sureBtn];
 
    }
 
    //计算高度
      
      self.alertView.em_height = self.sureBtn.em_bottom + 20;
 
  
  }
 
  return self;
}
#pragma mark - 弹出 -
- (void)showXLAlertView
{
  UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
  [rootWindow addSubview:self];
  [self creatShowAnimation];
}
 
- (void)creatShowAnimation
{
  self.alertView.layer.position = self.center;
  self.alertView.transform = CGAffineTransformMakeScale(0.90, 0.90);
  [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
    self.alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
  } completion:^(BOOL finished) {
  }];
}
 
#pragma mark - 回调 -设置只有2 -- > 确定才回调
- (void)buttonEvent:(UIButton *)sender
{
  if (sender.tag == 2) {
    if (self.resultIndex) {
      self.resultIndex(sender.tag);
    }
  }
  [self removeFromSuperview];
}
 
-(UILabel *)GetAdaptiveLable:(CGRect)rect AndText:(NSString *)contentStr andIsTitle:(BOOL)isTitle
{
  UILabel *contentLbl = [[UILabel alloc] initWithFrame:rect];
  contentLbl.numberOfLines = 0;
  contentLbl.text = contentStr;
  contentLbl.textAlignment = NSTextAlignmentCenter;
  if (isTitle) {
    contentLbl.font = [UIFont boldSystemFontOfSize:16.0];
  }else{
    contentLbl.font = [UIFont systemFontOfSize:14.0];
  }
 
  NSMutableAttributedString *mAttrStr = [[NSMutableAttributedString alloc] initWithString:contentStr];
  NSMutableParagraphStyle *mParaStyle = [[NSMutableParagraphStyle alloc] init];
  mParaStyle.lineBreakMode = NSLineBreakByCharWrapping;
  [mParaStyle setLineSpacing:3.0];
  [mAttrStr addAttribute:NSParagraphStyleAttributeName value:mParaStyle range:NSMakeRange(0,[contentStr length])];
  [contentLbl setAttributedText:mAttrStr];
  [contentLbl sizeToFit];
 
  return contentLbl;
}
 
-(UIImage *)imageWithColor:(UIColor *)color
{
  CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
  UIGraphicsBeginImageContext(rect.size);
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetFillColorWithColor(context, [color CGColor]);
  CGContextFillRect(context, rect);
  UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return theImage;
}
@end
