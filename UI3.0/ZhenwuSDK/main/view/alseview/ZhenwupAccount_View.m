
#import "ZhenwupAccount_View.h"

@interface ZhenwupAccount_View ()

@property (nonatomic, strong) UIView *em11_ButtonContainerView;
@end

@implementation ZhenwupAccount_View

- (instancetype)init {
    if (self = [super initWithCurType:@"0"]) {
        [self em14_setupViews];
    }
    return self;
}

- (UIView *)em11_ButtonContainerView {
    if (!_em11_ButtonContainerView) {
        _em11_ButtonContainerView = [[UIView alloc] initWithFrame:CGRectMake(35, 55, self.em_width - 70, 100)];
    }
    return _em11_ButtonContainerView;
}

- (void)em14_setupViews {
    self.title = MUUQYLocalizedString(@"EMKey_Account_Text");
    
    [self em14_ShowCloseBtn:YES];
    
    [self addSubview:self.em11_ButtonContainerView];
    [self em11_UpdateInterface];
}

- (void)em14_u_SetAccountButtons:(NSArray *)buttonNames {
    [self.em11_ButtonContainerView em_removeAllSubviews];
    
    if (buttonNames && buttonNames.count > 0) {
        CGFloat buttonHeight = 30.0f;
        CGFloat buttonWidth = self.em11_ButtonContainerView.em_width;
        CGFloat buttonGap = 10;
        [buttonNames enumerateObjectsUsingBlock:^(NSArray * obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, idx * (buttonHeight + buttonGap), buttonWidth, buttonHeight);
            button.titleLabel.font = [ZhenwupTheme_Utils em_colors_NormalFont];
            button.layer.cornerRadius = 5.0;
            button.layer.masksToBounds = YES;
            button.tag = [obj[0] integerValue];
            button.showsTouchWhenHighlighted = YES;
            button.backgroundColor = idx == 0 ? [ZhenwupTheme_Utils em_colors_MainColor] : [ZhenwupTheme_Utils em_colors_SecondaryColor];
            [button setTitle:obj[1] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(em11_HandleClickedBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            [self.em11_ButtonContainerView addSubview:button];
        }];
        
        self.em11_ButtonContainerView.em_height = (buttonHeight + buttonGap) * buttonNames.count;
        self.em_height = self.em11_ButtonContainerView.em_bottom + 20;
    }
}

- (void)em11_UpdateInterface {
    NSArray *btns = nil;
    
    NSArray *btn0 = @[@"0",MUUQYLocalizedString(@"EMKey_PersonCenter_Text")];
    NSArray *btn1 = @[@"1",MUUQYLocalizedString(@"EMKey_AccountUpgrade_Text")];
    NSArray *btn2 = @[@"2",MUUQYLocalizedString(@"EMKey_EmailBind_Text")];
    NSArray *btn3 = @[@"3",MUUQYLocalizedString(@"EMKey_ModifyPassword_Text")];
    NSArray *btn4 = @[@"4",MUUQYLocalizedString(@"EMKey_PresentCollection_Text")];
    NSArray *btn5 = @[@"5",MUUQYLocalizedString(@"EMKey_Logout_Text")];
    
    switch (EMSDKGlobalInfo.userInfo.accountType) {
        case EM_AccountTypeMuu:
        {
            if (EMSDKGlobalInfo.userInfo.isBindEmail) {
                btns = @[btn0, btn3, btn4, btn5];
            } else {
                btns = @[btn0, btn2, btn3, btn4, btn5];
            }
        }
            break;
        case EM_AccountTypeGuest:
        {
            if (EMSDKGlobalInfo.userInfo.isBindEmail) {
                btns = @[btn4, btn5];
            } else {
                btns = @[btn1, btn4, btn5];
            }
        }
            break;
        default:
        {
            if (EMSDKGlobalInfo.userInfo.isBindEmail) {
                btns = @[btn0, btn4, btn5];
            } else {
                btns = @[btn0, btn2, btn4, btn5];
            }
        }
            break;
    }
    [self em14_u_SetAccountButtons:btns];
}


- (void)em14_HandleClickedCloseBtn:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(em11_handleCloseAccount_Delegate:)]) {
        [self.delegate em11_handleCloseAccount_Delegate:self];
    }
}


- (void)em11_HandleClickedBtnAction:(UIButton *)button {
    if (self.delegate && [self.delegate respondsToSelector:@selector(em11_handleAccount_Delegate:onClickBtn:)]) {
        [self.delegate em11_handleAccount_Delegate:self onClickBtn:button.tag];
    }
}

@end
