//
//  ZhenwupRelayoutBtn2.m
//  EmpriSDK
//
//  Created by Admin on 2023/2/8.
//  Copyright © 2023 Admin. All rights reserved.
//

#import "ZhenwupRelayoutBtn2.h"
#import "ZhenwupTheme_Utils.h"
#import "ZhenwupHelper_Utils.h"
#import "UIView+GrossExtension.h"
#import "UIDevice+GrossExtension.h"
@interface ZhenwupRelayoutBtn2 ()

@property(nonatomic, strong) UIImageView *em_imageview;

@property(nonatomic, strong) UILabel *em_titleLab;

@end
@implementation ZhenwupRelayoutBtn2

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
    self.em_imageview.frame=CGRectMake(self.em_width/2-15, 17.5, 30, 30);
    
    [self addSubview:self.em_imageview];
    
    
    self.em_titleLab=[[UILabel alloc]init];
    self.em_titleLab.frame=CGRectMake(0, self.em_imageview.em_bottom+5, self.em_width, 20);
    
   
    self.em_titleLab.font=  [UIDevice getIsIpad ]? [UIFont systemFontOfSize:14]:[ZhenwupTheme_Utils em_colors_LeastFont];
    self.em_titleLab.textColor=[UIColor whiteColor];
    self.em_titleLab.textAlignment=NSTextAlignmentCenter;
    [self addSubview:self.em_titleLab];
    
    
}

-(void)setImagestr:(NSString *)imagestr{
    
    
    self.em_imageview.image=[ZhenwupHelper_Utils imageName:imagestr];
    
}

-(void)setTitlestr:(NSString *)titlestr{
    self.em_titleLab.text=titlestr;
}
-(void)setNum:(NSInteger)num{
    self.em_imageview.frame=CGRectMake(self.em_width/2-15, 27.5, 30, 30);
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
