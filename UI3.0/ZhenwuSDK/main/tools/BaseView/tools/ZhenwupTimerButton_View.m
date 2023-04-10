
#import "ZhenwupTimerButton_View.h"
#import "UIView+GrossExtension.h"
#import "ZhenwupTheme_Utils.h"
#import "ZhenwupHelper_Utils.h"
#import "ZhenwupWeakProxy_Utils.h"

@interface ZhenwupTimerButton_View ()


@property (nonatomic, strong) NSTimer *em14_Timer;
@property (nonatomic, assign) NSInteger em14_TimeNumber;

@end

@implementation ZhenwupTimerButton_View

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

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _em14_Button.em_centerY = self.em_centerY;
}

- (void)em14_SetupDefaultViews {
    self.em14_TimeInterval = 60.0f;
    
    self.em14_Button = [UIButton buttonWithType:UIButtonTypeCustom];
    self.em14_Button.frame = CGRectMake(0, 0, 77, 30);
//    self.em14_Button.em_right = self.em_width;
    self.em14_Button.titleLabel.font = [ZhenwupTheme_Utils em_colors_NormalFont];
    self.em14_Button.layer.cornerRadius = 5.0;
    self.em14_Button.layer.masksToBounds = YES;
//    [self.em14_Button setBackgroundImage:[ZhenwupHelper_Utils imageName:@"zhenwuimgetcode"] forState:0];
//    emprigetcode
//    [self.em14_Button setTitle:MUUQYLocalizedString(@"EMKey_SendButton_Text") forState:UIControlStateNormal];
    
    [self.em14_Button setTitle:@"Gửi mã KH" forState:UIControlStateNormal];
//    self.em14_Button.backgroundColor=[ZhenwupTheme_Utils khxl_SmalltitleColor];
    [self.em14_Button setTitleColor:[ZhenwupTheme_Utils khxl_SmalltitleColor] forState:UIControlStateNormal];
    [self.em14_Button addTarget:self action:@selector(em14_HandleClickedSendBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.em14_Button];
}


- (NSTimer *)em14_Timer {
    if (!_em14_Timer) {
        _em14_Timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:[ZhenwupWeakProxy_Utils proxyWithTarget:self] selector:@selector(em14_RefreshTimer:) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_em14_Timer forMode:NSRunLoopCommonModes];
    }
    return _em14_Timer;
}


- (void)em14_RefreshTimer:(NSTimer *)timer {
    if (_em14_TimeNumber <= 0) {
        [self em14_u_StopTimer];
    } else {
        [self.em14_Button setTitle:[NSString stringWithFormat:@"%ziS", self.em14_TimeNumber] forState:UIControlStateNormal];
    }
    self.em14_TimeNumber--;
}

- (void)em14_ResetNormalSendStates {
    [self em14_u_StopTimer];
}

- (void)em14_u_StarTimer {
    self.em14_TimeNumber = self.em14_TimeInterval;
    [self.em14_Timer fire];

    self.em14_Button.enabled = NO;
//    self.em14_Button.backgroundColor = [ZhenwupTheme_Utils em_colors_DisableColor];
    
    self.em14_Button.backgroundColor = [UIColor clearColor];
}

- (void)em14_u_StopTimer {
    if (_em14_Timer != nil) {
        if (_em14_Timer.isValid) {
            [_em14_Timer invalidate];
        }
        _em14_Timer = nil;
    }
    
    self.em14_Button.enabled = YES;
    [self.em14_Button setTitle:self.em14_BtnTitle forState:(UIControlStateNormal)];
//    self.em14_Button.backgroundColor = [ZhenwupTheme_Utils em_colors_ButtonColor];
    
    self.em14_Button.backgroundColor = [UIColor clearColor];
    [self.em14_Button setTitleColor:[ZhenwupTheme_Utils khxl_SmalltitleColor] forState:(UIControlStateNormal)];
}

- (void)em14_HandleClickedSendBtn:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(em14_ClickedTimerButtonView:)]) {
        if ([_delegate em14_ClickedTimerButtonView:self]) {
            [self em14_u_StarTimer];
        }
    } else {
        [self em14_u_StarTimer];
    }
}

@end
