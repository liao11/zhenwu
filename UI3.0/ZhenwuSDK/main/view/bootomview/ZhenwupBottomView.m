//
//  ZhenwupBottomView.m
//  EmpriSDK
//
//  Created by Admin on 2023/1/13.
//  Copyright © 2023 Admin. All rights reserved.
//

#import "ZhenwupBottomView.h"
#import "ZhenwupTheme_Utils.h"
#import "ZhenwupHelper_Utils.h"
#import "ZhenwupBottomView1.h"
#import "ZhenwupBottomView2.h"
#import "ZhenwupBottomView3.h"
#import "ZhenwupBottomView4.h"
#import "ZhenwupRelayoutBtn3.h"
#import "UIDevice+GrossExtension.h"
//#define  UI_View_Width     [UIScreen mainScreen].bounds.size.width
#define  UI_View_Width [UIDevice getIsIpad ]? 600 :[UIScreen mainScreen].bounds.size.width
#define  UI_View_Width1    [UIScreen mainScreen].bounds.size.width
#define  UI_View_Widthx    [UIDevice getIsIpad ]? [UIScreen mainScreen].bounds.size.width/2-300:0

#define  ZLBounceViewHight [UIScreen mainScreen].bounds.size.height
//#define  UI_View_Height  [UIDevice getIsIpad ]? 3* ([UIScreen mainScreen].bounds.size.height)/4:3* ([UIScreen mainScreen].bounds.size.height)/4

#define  UI_View_Height  3* ([UIScreen mainScreen].bounds.size.height)/4
#define XHHTuanNumViewHight UI_View_Height
#define EMWIDTH [UIScreen mainScreen].bounds.size.width
#define EMHEIGHT [UIScreen mainScreen].bounds.size.height
#define EM_RGBA(r,g,b,a)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:a]
@interface ZhenwupBottomView ()
{
    UIView *_contentView;
    UIView *_contentView22;
    UIView *_contentView1;
    ZhenwupBottomView1 *view1;
    ZhenwupBottomView2 *view2;
    ZhenwupBottomView3 *view3;
    ZhenwupBottomView4 *view4;
    
    UIScrollView *_scrollview;
}
@property(nonatomic,strong)  NSArray *titleArr;
@property(nonatomic,strong)  NSArray *imageArr;
@end



@implementation ZhenwupBottomView

- (id)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        
        [self setupContent];
    }
    
    return self;
}


-(void)setupContent{
    
    self.frame = CGRectMake(0,0,UI_View_Width1, ZLBounceViewHight);
    
    
    NSLog(@"%f %f",[UIScreen mainScreen].bounds.size.width,UI_View_Width);
   
        //alpha 0.0  白色   alpha 1 ：黑色   alpha 0～1 ：遮罩颜色，逐渐
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    self.userInteractionEnabled = YES;
//    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMissView)]];
    _contentView22=[[UIView alloc]init];
    _contentView22.frame=self.bounds;
    [self addSubview:_contentView22];

    
    _contentView22.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    _contentView22.userInteractionEnabled = YES;
    [_contentView22 addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMissView)]];
    
    
    if (_contentView == nil) {
        
        CGFloat margin = 15;
        
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(UI_View_Widthx, UI_View_Height -  ZLBounceViewHight, UI_View_Width, UI_View_Height)];
//        _contentView.userInteractionEnabled = NO;
        _contentView.backgroundColor = EM_RGBA(37, 46, 54, 1);
        [self addSubview:_contentView];
        
        
        _contentView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UI_View_Width, 40)];
        _contentView1.backgroundColor = EM_RGBA(43, 52, 61, 1);
        [_contentView addSubview:_contentView1];
        
        _titleArr=@[@"Tin hoạt động",@"VIP",@"Tiệm Điểm",@"Tài Khoản Tôi"];
        _imageArr=@[@"zhenwuimhome1",@"zhenwuimhome2",@"zhenwuimhome3",@"zhenwuimhome4"];
        
        CGFloat w=(UI_View_Width-0)/[self.titleArr count];
        CGFloat h=40;
        for (NSInteger i=0; i<[self.titleArr count]; i++) {
            
            
            
            ZhenwupRelayoutBtn3 *btn=[[ZhenwupRelayoutBtn3 alloc]initWithFrame:CGRectMake(i*w, 0, w, h)];
            btn.titlestr=_titleArr[i];

            btn.tag=888+i;
            
            
            btn.backgroundColor =EM_RGBA(43, 52, 61, 1);
           
            
            [btn addTarget:self action:@selector(choiceAction:) forControlEvents:UIControlEventTouchUpInside];
            [_contentView1 addSubview:btn];
            
            if(i==0){
                
                btn.imagestr=_imageArr[i];
                btn.backgroundColor =EM_RGBA(37, 46, 54, 1);
            }
            
            
            // 右上角关闭按钮
//            UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//            closeBtn.frame = CGRectMake(UI_View_Width - 20 - 15, 10, 20, 20);
//            [closeBtn setImage:[ZhenwupHelper_Utils imageName:@"zhenwuimclose"] forState:UIControlStateNormal];
//            [closeBtn addTarget:self action:@selector(disMissView) forControlEvents:UIControlEventTouchUpInside];
//            [_contentView1 addSubview:closeBtn];
            
            
            _scrollview = [[UIScrollView alloc] init];
            _scrollview.frame = CGRectMake(0, _contentView1.em_bottom+5, _contentView.em_width, _contentView.em_height-_contentView1.em_bottom-5);
            //            _scrollview.backgroundColor=[UIColor redColor];
            [_contentView addSubview:_scrollview];
            
            _scrollview.contentSize = CGSizeMake(_scrollview.em_width*4, _scrollview.em_height);
            _scrollview.scrollEnabled = NO;
            _scrollview.backgroundColor=[UIColor clearColor];
            //contentOffset属性是设置UIScrollView内加载视图的偏移量，例如想让轮播图向右播放第二张，就设置这个属性
            _scrollview.contentOffset = CGPointMake(0, 0);
            
            
           view1=[[ZhenwupBottomView1 alloc]initWithFrame:CGRectMake(0, 0, _scrollview.em_width, _scrollview.em_height)];
            view1.closedViewCompleted = ^() {
                [self disMissView];
                
            };
            
            
            [_scrollview addSubview:view1];
            
           view2=[[ZhenwupBottomView2 alloc]initWithFrame:CGRectMake(_scrollview.em_width, 0, _scrollview.em_width, _scrollview.em_height)];
            
            [_scrollview addSubview:view2];
            
            
            
           view3=[[ZhenwupBottomView3 alloc]initWithFrame:CGRectMake(_scrollview.em_width*2, 0, _scrollview.em_width, _scrollview.em_height)];
            
            [_scrollview addSubview:view3];
            
            
            view4=[[ZhenwupBottomView4 alloc]initWithFrame:CGRectMake(_scrollview.em_width*3, 0, _scrollview.em_width, _scrollview.em_height)];
            view4.closedViewCompleted = ^() {
                [self disMissView];
                
            };
            [_scrollview addSubview:view4];
            
            
            
        }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
    }
}

- (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 0.1f, 0.1f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
-(void)choiceAction:(ZhenwupRelayoutBtn3 *)sbtn{
    
    for (NSInteger i=0; i<[self.titleArr count]; i++) {
        
        ZhenwupRelayoutBtn3 *btn=[_contentView1 viewWithTag:888+i ];
 
        btn.titlestr=_titleArr[i];
        btn.backgroundColor =EM_RGBA(43, 52, 61, 1);
        
        
    }

    sbtn.imagestr=_imageArr[sbtn.tag-888];
    sbtn.backgroundColor =EM_RGBA(37, 46, 54, 1);
    if(sbtn.tag==888){
        
    }else if (sbtn.tag==889){
        [view2 em11_GetUserInfo];
    }else if (sbtn.tag==890){
        [view3 em14_getGoodType];
    }else if (sbtn.tag==891){
        
    }
    _scrollview.contentOffset = CGPointMake(_scrollview.em_width*(sbtn.tag-888), 0);
    
}




//展示从底部向上弹出的UIView（包含遮罩）
//展示从底部向上弹出的UIView（包含遮罩）
- (void)showInView:(UIView *)view {
    if (!view) {
        return;
    }
    
    [view addSubview:self];
//    [self addSubview:_contentView];
    
    [_contentView setFrame:CGRectMake(UI_View_Widthx, ZLBounceViewHight, UI_View_Width, UI_View_Height)];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.alpha = 1.0;
        
        [_contentView setFrame:CGRectMake(UI_View_Widthx, ZLBounceViewHight - UI_View_Height - 0, UI_View_Width, UI_View_Height)];
        
    } completion:nil];
    
    
    
    
}

//移除从上向底部弹下去的UIView（包含遮罩）
- (void)disMissView {
    
    [_contentView setFrame:CGRectMake(UI_View_Widthx, ZLBounceViewHight - UI_View_Height - 0, UI_View_Width, UI_View_Height)];
    [UIView animateWithDuration:0.3f
                     animations:^{

        self.alpha = 0.0;

        [_contentView setFrame:CGRectMake(UI_View_Widthx, ZLBounceViewHight, UI_View_Width, UI_View_Height)];
    }
                     completion:^(BOOL finished){

        [self removeFromSuperview];
        [_contentView removeFromSuperview];

    }];
    
    [self removeFromSuperview];
    
}
-(void)entterYouhuiView{
    [view1 entterYouhuiView];
}
- (void)disMissView1 {
    [self removeFromSuperview];
}
@end
