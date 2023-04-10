
#import "ZhenwupBaseWindow_View.h"

@interface ZhenwupBaseWindow_View ()



@end

@implementation ZhenwupBaseWindow_View

- (void)dealloc {
    MYMGLog(@"%@ dealloc..", NSStringFromClass([self class]));
}

- (instancetype)initWithCurType:(NSString *)curType {
    self = [super init];
    if (self) {
        [self em14_SetupWindowDefaultsWithCurType:curType];
    }
    return self;
}


- (void)em14_SetupWindowDefaultsWithCurType:(NSString *)curType {
    if ([curType isEqualToString:@"1"]) {
        self.frame = CGRectMake(0, 0, 320, 300);
    }else if ([curType isEqualToString:@"2"]) {
        self.frame = CGRectMake(0, 0, 320, 140);
    }else if ([curType isEqualToString:@"4"]) {
        self.frame = CGRectMake(0, 0, 320, 420);
    }else if ([curType isEqualToString:@"5"]) {
        self.frame = CGRectMake(0, 0, 320, 260);
    }else{
        self.frame = CGRectMake(0, 0, 320, 360);
    }
    

    self.bgview=[[UIImageView alloc]init];
    
    self.bgview.frame=self.bounds;
    
    
    self.bgview.image = [ZhenwupHelper_Utils imageName:@"zhenwuimbg3"];
    
    
    [self addSubview:self.bgview];
    
    
    
    self.em14_TitleImgV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 30, 40, 30)];
    self.em14_TitleImgV.em_centerX = self.em_width/2;
    self.em14_TitleImgV.image = [ZhenwupHelper_Utils imageName:@"zhenwuimlogo"];
    [self addSubview:self.em14_TitleImgV];
    
    self.em14_TitleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.em_width, 36)];
    self.em14_TitleLab.hidden = !self.em14_TitleImgV.hidden;
    self.em14_TitleLab.font = [ZhenwupTheme_Utils em_colors_LargestFont];
//    self.em14_TitleLab.textColor = [ZhenwupTheme_Utils em_colors_LightColor];
    self.em14_TitleLab.textColor = [ZhenwupTheme_Utils khxl_SmallGrayColor];
    self.em14_TitleLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.em14_TitleLab];
    
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.em14_TitleImgV.hidden = (title != nil);
    self.em14_TitleLab.hidden = !self.em14_TitleImgV.hidden;
    self.em14_TitleLab.text = title;
}

- (void)em14_ShowBackBtn:(BOOL)show {
    if (show) {
        if (_em14_BackBtn == nil) {
            _em14_BackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            _em14_BackBtn.frame = CGRectMake(12, 8, 20, 35);

            [_em14_BackBtn setImage:[ZhenwupHelper_Utils imageName:@"zhenwuimback"] forState:UIControlStateNormal];
            [_em14_BackBtn addTarget:self action:@selector(em14_HandleClickedBackBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_em14_BackBtn];
        }
        _em14_BackBtn.hidden = NO;
    } else {
        _em14_BackBtn.hidden = YES;
    }
}

- (void)em14_ShowCloseBtn:(BOOL)show {
    if (show) {
        if (_em14_CloseBtn == nil) {
            _em14_CloseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//            _em14_CloseBtn.frame = CGRectMake(self.em_width-45-5, 0, 45, 45);
            
            self.em14_CloseBtn.frame = CGRectMake(self.em_width-22-18, 18, 22, 22);
//            _em14_CloseBtn.contentEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8);
            [_em14_CloseBtn setImage:[ZhenwupHelper_Utils imageName:@"zhenwuimclose"] forState:UIControlStateNormal];
            [_em14_CloseBtn addTarget:self action:@selector(em14_HandleClickedCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_em14_CloseBtn];
        }
        _em14_CloseBtn.hidden = NO;
    } else {
        _em14_CloseBtn.hidden = YES;
    }
}

- (void)em14_HandleClickedBackBtn:(id)sender {
    
}

- (void)em14_HandleClickedCloseBtn:(id)sender {
    
}

@end
