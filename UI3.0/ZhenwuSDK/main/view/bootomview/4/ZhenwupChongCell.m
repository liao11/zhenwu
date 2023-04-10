//
//  ZhenwupChongCell.m
//  GiguoFrameWork
//
//  Created by Admin on 2021/8/17.
//  Copyright © 2021 Admin. All rights reserved.
//

#import "ZhenwupChongCell.h"
#import "ZhenwupTheme_Utils.h"
#import "UIView+GrossExtension.h"
@implementation ZhenwupChongCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
//        TableViewCellBackgroundView *backgroundView = [[TableViewCellBackgroundView alloc] initWithFrame:CGRectZero];
//        backgroundView.backgroundColor = [UIColor clearColor];
//        [self setBackgroundView:backgroundView];
        
        
        UIFont *contFont = [ZhenwupTheme_Utils em_colors_LeastFont];
        self.em11_chongTime = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.em_width/4, 55)];
        self.em11_chongTime.font = contFont;
        self.em11_chongTime.textColor = [ZhenwupTheme_Utils em_colors_DarkGrayColor];
        self.em11_chongTime.text = @"";
        self.em11_chongTime.textAlignment = NSTextAlignmentCenter;
        self.em11_chongTime.numberOfLines = 0;
        [self.contentView addSubview:self.em11_chongTime];
        
        self.em18_orderNum = [[UILabel alloc] initWithFrame:CGRectMake(self.em11_chongTime.em_right, 0, self.em_width/4, 55)];
        self.em18_orderNum.font = contFont;
        self.em18_orderNum.textColor = [ZhenwupTheme_Utils em_colors_DarkGrayColor];
        self.em18_orderNum.text = @"";
        self.em18_orderNum.adjustsFontSizeToFitWidth = true;
        self.em18_orderNum.textAlignment = NSTextAlignmentCenter;
        self.em18_orderNum.numberOfLines = 0;
        [self.contentView addSubview:self.em18_orderNum];
        
        self.em11_orderMoney = [[UILabel alloc] initWithFrame:CGRectMake(self.em18_orderNum.em_right, 0, self.em_width/4, 55)];
        self.em11_orderMoney.font = contFont;
        self.em11_orderMoney.textColor = [ZhenwupTheme_Utils khxl_SmalltitleColor];
        self.em11_orderMoney.text = @"";
        self.em11_orderMoney.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.em11_orderMoney];
        
        self.lhxy_statues = [[UIImageView alloc]initWithFrame:CGRectMake(self.em11_orderMoney.em_right + (self.em_width/4 - 30)/2, 15, 24, 24)];
        [self.contentView addSubview:self.lhxy_statues];
  
     
        
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.em11_chongTime.frame = CGRectMake(0, 0, self.em_width/4, 55);
    
    self.em18_orderNum.frame = CGRectMake(self.em11_chongTime.em_right, 0, self.em_width/4, 55);
    self.em11_orderMoney.frame = CGRectMake(self.em18_orderNum.em_right, 0, self.em_width/4, 55);
    self.lhxy_statues.frame=CGRectMake(self.em11_orderMoney.em_right + (self.em_width/4 - 30)/2, 15, 24, 24);
   
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

@implementation TableViewCellBackgroundView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef cont = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(cont, [UIColor whiteColor].CGColor);
    CGContextSetLineWidth(cont, 1);
    CGFloat lengths[] = {2,2};
    CGContextSetLineDash(cont, 0, lengths, 2);  //画虚线
    CGContextBeginPath(cont);
    CGContextMoveToPoint(cont, 10.0, rect.size.height - 1);    //开始画线
    CGContextAddLineToPoint(cont, 300.0, rect.size.height - 1);
    CGContextStrokePath(cont);
}

@end




