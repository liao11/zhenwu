//
//  ZhenwupBottomBaseView.m
//  EmpriSDK
//
//  Created by Admin on 2023/1/17.
//  Copyright © 2023 Admin. All rights reserved.
//

#import "ZhenwupBottomBaseView.h"
#import "ZhenwupTheme_Utils.h"
#import "ZhenwupAccount_Server.h"




#define EM_RGBA(r,g,b,a)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
@implementation ZhenwupBottomBaseView
- (id)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        
        
        self.backgroundColor=EM_RGBA(37, 46, 54, 1);
       
        [self setupTitleViewContent];
        
        
        
        
        [self setupContent];
        
        
    }
    
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [_em14_AccountLoginView em11_HiddenHistoryTable];
    [self endEditing:YES];
}
-(void)setupTitleViewContent{
    
    self.topBgview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.em_width, 40)];
    self.topBgview.backgroundColor=EM_RGBA(27, 28, 38, 1);
    [self addSubview:_topBgview];
    
    
    _em14_BackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _em14_BackBtn.frame = CGRectMake(12, 2.5, 20, 35);
    
    [_em14_BackBtn setImage:[ZhenwupHelper_Utils imageName:@"zhenwuimback"] forState:UIControlStateNormal];
    [_em14_BackBtn addTarget:self action:@selector(em14_HandleClickedBackBtn) forControlEvents:UIControlEventTouchUpInside];
    [_topBgview addSubview:_em14_BackBtn];
    
    
    self.em14_TitleLab = [[UILabel alloc] initWithFrame:CGRectMake(60, 0, self.em_width-120, 40)];
    
    self.em14_TitleLab.font = [ZhenwupTheme_Utils em_colors_LargestFont];
    self.em14_TitleLab.textColor = [ZhenwupTheme_Utils khxl_SmallGrayColor];
    self.em14_TitleLab.textAlignment = NSTextAlignmentCenter;
    [_topBgview addSubview:self.em14_TitleLab];
    
    
}


- (void)em14_ShowTopview:(BOOL)show {
    self.topBgview.hidden=!show;
}
-(void)em14_HandleClickedBackBtn{
    [self removeFromSuperview];
}
- (void)setTitle:(NSString *)title {
    self.em14_TitleLab.text = title;
}

-(void)setupContent{
    
}

@end
