//
//  ZhenwupSegView.m
//  EmpriSDK
//
//  Created by Admin on 2023/1/13.
//  Copyright © 2023 Admin. All rights reserved.
//

#import "ZhenwupSegView.h"
#define EM_RGBA(r,g,b,a)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
@interface ZhenwupSegView ()

@property(nonatomic, strong, nullable) UIView* em14_ProgressView;

@property(nonatomic, strong)NSArray *titleArr;
@end
@implementation ZhenwupSegView
- (void)dealloc {
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self em14_SetupDefaultViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
      
        [self em14_SetupDefaultViews];
    }
    return self;
}
- (instancetype)initWithTitleArr:(NSArray *)titleArr WithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleArr=titleArr;
        [self em14_SetupDefaultViews];
    }
    return self;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    
  
}

- (void)em14_SetupDefaultViews {
    self.backgroundColor=EM_RGBA(27, 28, 38, 1);
    
    
    self.layer.cornerRadius=15;
    self.layer.masksToBounds=YES;
    
    
    CGFloat w=self.frame.size.width/[self.titleArr count];
    CGFloat h=self.frame.size.height;
    for (NSInteger i=0; i<[self.titleArr count]; i++) {
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(i*w, 0, w, h)];
        
        [btn setTitle:_titleArr[i] forState:0];
        btn.tag=999+i;
        
        btn.layer.cornerRadius=15;
        btn.layer.masksToBounds=YES;
        btn.titleLabel.font=[UIFont systemFontOfSize:13];
        btn.backgroundColor =[UIColor clearColor];
        [btn setTitleColor:[UIColor whiteColor] forState:0];
        [btn setTitleColor:[ZhenwupTheme_Utils khxl_SmalltitleColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(choiceAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        if(i==0){
            btn.selected=YES;
            btn.backgroundColor =EM_RGBA(62, 66, 76, 1);
        }
    }
    
    
    
    
    
    
}
-(void)setNum:(NSInteger)num{
    if(num==1){
        for (NSInteger i=0; i<[self.titleArr count]; i++) {
            
            UIButton *btn=[self viewWithTag:999+i ];
            btn.titleLabel.font=[UIFont systemFontOfSize:10];
            
        }
    }
    
    
    
    
}
-(void)choiceAction:(UIButton *)sbtn{
    
    for (NSInteger i=0; i<[self.titleArr count]; i++) {
        
        UIButton *btn=[self viewWithTag:999+i ];
        btn.selected=NO;
        btn.backgroundColor =[UIColor clearColor];
        
    }
    sbtn.selected=YES;
    sbtn.backgroundColor =EM_RGBA(62, 66, 76, 1);
    
    if (_delegate && [_delegate respondsToSelector:@selector(em14_segValeDidChange:)]) {
        [_delegate em14_segValeDidChange:sbtn.tag-999];
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
