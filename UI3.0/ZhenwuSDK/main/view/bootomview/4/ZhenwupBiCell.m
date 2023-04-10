//
//  ZhenwupBiCell.m
//  GiguoFrameWork
//
//  Created by Admin on 2021/9/29.
//  Copyright © 2021 Admin. All rights reserved.
//

#import "ZhenwupBiCell.h"
#import "ZhenwupTheme_Utils.h"
#import "UIView+GrossExtension.h"

@implementation ZhenwupBiCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        
//        BiTableViewCellBackgroundView *backgroundView = [[BiTableViewCellBackgroundView alloc] initWithFrame:CGRectZero];
//        backgroundView.backgroundColor = [UIColor clearColor];
//        [self setBackgroundView:backgroundView];
        
        
        UIFont *contFont = [ZhenwupTheme_Utils em_colors_LeastFont];
        self.em11_date = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.em_width/3, 42)];
        self.em11_date.font = contFont;
        self.em11_date.textColor = [ZhenwupTheme_Utils em_colors_DarkGrayColor];
        self.em11_date.text = @"";
        self.em11_date.textAlignment = NSTextAlignmentCenter;
        self.em11_date.numberOfLines = 0;
        [self.contentView addSubview:self.em11_date];
        
        self.em18_cost = [[UILabel alloc] initWithFrame:CGRectMake(self.em11_date.em_right, 0, self.em_width/3, 42)];
        self.em18_cost.font = contFont;
        self.em18_cost.textColor = [ZhenwupTheme_Utils em_colors_DarkGrayColor];
        self.em18_cost.text = @"";
        self.em18_cost.adjustsFontSizeToFitWidth = true;
        self.em18_cost.textAlignment = NSTextAlignmentCenter;
        self.em18_cost.numberOfLines = 0;
        [self.contentView addSubview:self.em18_cost];
        
        self.em11_channel = [[UILabel alloc] initWithFrame:CGRectMake(self.em18_cost.em_right, 0, self.em_width/3, 42)];
        self.em11_channel.font = contFont;
        self.em11_channel.textColor = [ZhenwupTheme_Utils khxl_SmalltitleColor];
        self.em11_channel.text = @"";
        self.em11_channel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.em11_channel];
        
        
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.em11_date.frame = CGRectMake(0, 0, self.em_width/3, 55);
    
    self.em18_cost.frame = CGRectMake(self.em11_date.em_right, 0, self.em_width/3, 55);
    self.em11_channel.frame = CGRectMake(self.em18_cost.em_right, 0, self.em_width/3, 55);
   
   
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

@implementation BiTableViewCellBackgroundView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setBackgroundColor:[ZhenwupTheme_Utils em_colors_BackgroundColor]];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef cont = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(cont, [ZhenwupTheme_Utils em_colors_DarkGrayColor].CGColor);
    CGContextSetLineWidth(cont, 1);
    CGFloat lengths[] = {2,2};
    CGContextSetLineDash(cont, 0, lengths, 2);  //画虚线
    CGContextBeginPath(cont);
    CGContextMoveToPoint(cont, 10.0, rect.size.height - 1);    //开始画线
    CGContextAddLineToPoint(cont, 300.0, rect.size.height - 1);
    CGContextStrokePath(cont);
}

@end
