//
//  ZhenwupcanGetCell.m
//  GiguoFrameWork
//
//  Created by Admin on 2021/9/29.
//  Copyright © 2021 Admin. All rights reserved.
//

#import "ZhenwupcanGetCell.h"
#import "ZhenwupTheme_Utils.h"
#import "UIView+GrossExtension.h"
#import "ZhenwupHelper_Utils.h"
@implementation ZhenwupcanGetCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
        self.em_bgV = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, self.em_width - 30,90)];
 
        self.em_bgV.image=[ZhenwupHelper_Utils imageName:@"zhenwuimcoupCell"];
        
        
        [self.contentView addSubview:self.em_bgV];
        
        UIFont *contFont = [ZhenwupTheme_Utils em_colors_LargeFont];
        self.em11_name = [[UILabel alloc] initWithFrame:CGRectMake(20, 18, self.em_bgV.em_width/2, 15)];
        self.em11_name.font = contFont;
        self.em11_name.textColor = [ZhenwupTheme_Utils em_colors_GrayColor];
        self.em11_name.text = @"";
        self.em11_name.textAlignment = NSTextAlignmentLeft;
        self.em11_name.numberOfLines = 0;
        [self.em_bgV addSubview:self.em11_name];
        
        self.em18_info = [[UILabel alloc] initWithFrame:CGRectMake(20, self.em11_name.em_bottom + 7, self.em_bgV.em_width/2, 12)];
        self.em18_info.font = [ZhenwupTheme_Utils em_colors_SmallFont];
        self.em18_info.textColor = [ZhenwupTheme_Utils em_colors_GrayColor];
        self.em18_info.text = @"";
        self.em18_info.adjustsFontSizeToFitWidth = true;
        self.em18_info.textAlignment = NSTextAlignmentLeft;
        self.em18_info.numberOfLines = 0;
        [self.em_bgV addSubview:self.em18_info];
        
      
        
        self.limitTime = [[UILabel alloc] initWithFrame:CGRectMake(20, self.em18_info.em_bottom + 7, self.em_bgV.em_width/2, 20)];
        self.limitTime.font = [ZhenwupTheme_Utils em_colors_LeastFont];
        self.limitTime.textColor = [ZhenwupTheme_Utils em_colors_GrayColor];
        self.limitTime.text = @"";
        self.limitTime.adjustsFontSizeToFitWidth = true;
        self.limitTime.textAlignment = NSTextAlignmentLeft;
        self.limitTime.numberOfLines = 0;
        [self.em_bgV addSubview:self.limitTime];
        
        
        self.em18_info1 = [[UILabel alloc] initWithFrame:CGRectMake(self.em_bgV.em_width/2+50, 25, self.em_bgV.em_width/2, 20)];
        self.em18_info1.font = contFont;
        self.em18_info1.textColor = [ZhenwupTheme_Utils em_colors_GrayColor];
        self.em18_info1.text = @"";
        self.em18_info1.adjustsFontSizeToFitWidth = true;
//        self.em18_info1.textAlignment = NSTextAlignmentRight;
        self.em18_info1.numberOfLines = 0;
        [self.em_bgV addSubview:self.em18_info1];
        
        
        self.em18_info2 = [[UILabel alloc] initWithFrame:CGRectMake(self.em_bgV.em_width/2+50, self.em18_info1.em_bottom + 5, self.em_bgV.em_width/2, 20)];
        self.em18_info2.font = contFont;
        self.em18_info2.textColor = [ZhenwupTheme_Utils em_colors_GrayColor];
        self.em18_info2.text = @"";
        self.em18_info2.adjustsFontSizeToFitWidth = true;
//        self.em18_info1.textAlignment = NSTextAlignmentRight;
        self.em18_info2.numberOfLines = 0;
        [self.em_bgV addSubview:self.em18_info2];
        
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    self.em_bgV.frame=CGRectMake(15, 10, self.em_width - 30,100);
    self.em11_name.frame = CGRectMake(20, 18, self.em_bgV.em_width/2, 15);
    self.em18_info.frame  = CGRectMake(20, self.em11_name.em_bottom + 7, self.em_bgV.em_width/2, 12);
    self.limitTime.frame   =CGRectMake(20, self.em18_info.em_bottom + 7, self.em_bgV.em_width/2, 20);
    self.em18_info1.frame  = CGRectMake(self.em_bgV.em_width/2+50, 25, self.em_bgV.em_width/2, 20);
    self.em18_info2.frame  =CGRectMake(self.em_bgV.em_width/2+50, self.em18_info1.em_bottom + 5, self.em_bgV.em_width/2, 20);
}
- (void)em14_getAction:(UIButton *)em14_getBtn{
    if (self.em11_getBtnBlock) {
        self.em11_getBtnBlock();
    }
}

/**
 ** lineView:      需要绘制成虚线的view
 ** lineLength:    虚线的宽度 //2
 ** lineSpacing:        虚线的间距//1
 ** lineColor:    虚线的颜色
 **/
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor{
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    //  设置虚线颜色为blackColor
    [shapeLayer setStrokeColor:lineColor.CGColor];
    //  设置虚线宽度
    [shapeLayer setLineWidth:0.5];
    [shapeLayer setLineJoin:kCALineJoinRound];
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(lineView.frame), 0);
    [shapeLayer setPath:path];
    CGPathRelease(path);
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
