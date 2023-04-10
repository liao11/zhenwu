//
//  ZhenwupRelayoutBtn3.m
//  EmpriSDK
//
//  Created by Admin on 2023/2/10.
//  Copyright © 2023 Admin. All rights reserved.
//

#import "ZhenwupRelayoutBtn3.h"
#import "ZhenwupTheme_Utils.h"
#import "ZhenwupHelper_Utils.h"
#import "UIView+GrossExtension.h"
@interface ZhenwupRelayoutBtn3 ()

@property(nonatomic, strong) UIImageView *em_imageview;

@property(nonatomic, strong) UILabel *em_titleLab;

@end
@implementation ZhenwupRelayoutBtn3
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        //视图准备
        [self em14_SetupDefaultViews];
    }
    
    return self;
}
-(void)em14_SetupDefaultViews{
    self.em_imageview=[[UIImageView alloc]init];
    
    
    //  100:26
    
    
    CGFloat with=self.em_width-20;
    CGFloat height= 26*with/100;
    self.em_imageview.frame=CGRectMake(10, self.em_height/2-height/2, with, height);
    
    [self addSubview:self.em_imageview];
    
    
    
    
    
    self.em_titleLab=[[UILabel alloc]init];
    self.em_titleLab.frame=CGRectMake(0, self.em_height/2-10, self.em_width, 20);
    self.em_titleLab.font= [ZhenwupTheme_Utils em_colors_LeastFont];
    
//    self.em_titleLab.font = [UIFont fontWithName:@"BoldItalic" size:6];
    self.em_titleLab.textColor=[UIColor whiteColor];
    self.em_titleLab.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.em_titleLab];
    
    
}

-(void)setImagestr:(NSString *)imagestr{
    
    
    self.em_imageview.image=[ZhenwupHelper_Utils imageName:imagestr];
    self.em_imageview.hidden=NO;
    self.em_titleLab.hidden=YES;
}

-(void)setTitlestr:(NSString *)titlestr{
    self.em_titleLab.text=titlestr;
    self.em_imageview.hidden=YES;
    self.em_titleLab.hidden=NO;
}
-(void)setNum:(NSInteger)num{
    self.em_imageview.frame=CGRectMake(self.em_width/2-17.5, 25, 35, 35);
    self.em_titleLab.frame=CGRectMake(0, self.em_imageview.em_bottom+5, self.em_width, 20);
}


-(void)setNum1:(NSInteger)num1{
    if (num1==1) {
        self.em_imageview.alpha = 0.5;
        self.em_titleLab.alpha = 0.5;
    }else{
        self.em_imageview.alpha = 1;
        self.em_titleLab.alpha = 1;
    }
    
}
@end
