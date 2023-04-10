
#import "ZhenwupGuestAccountPrompt_View.h"

@implementation ZhenwupGuestAccountPrompt_View

- (instancetype)init {
    self = [super initWithCurType:@"5"];
    if (self) {
        [self em14_setupViews];
    }
    return self;
}


- (void)em14_setupViews {
    self.title = MUUQYLocalizedString(@"EMKey_GuestAccount_Text");
    
    NSString *labelText = MUUQYLocalizedString(@"EMKey_GuestAccount_Tips_Text");
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:10];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSParagraphStyleAttributeName:paragraphStyle,NSFontAttributeName:[ZhenwupTheme_Utils em_colors_NormalFont]}];
    
    UILabel *messageLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 55, self.em_width-40, 500)];
    messageLab.numberOfLines = 0;
    messageLab.font = [ZhenwupTheme_Utils em_colors_NormalFont];
    messageLab.textColor = [UIColor redColor];
    messageLab.attributedText = attributedString;
    [self addSubview:messageLab];
    [messageLab sizeToFit];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.titleLabel.font = [ZhenwupTheme_Utils em_colors_NormalFont];
    cancelBtn.backgroundColor = [ZhenwupTheme_Utils em_colors_SecondaryColor];
    cancelBtn.layer.cornerRadius = 5.0;
    cancelBtn.layer.masksToBounds = YES;
    [cancelBtn setTitle:MUUQYLocalizedString(@"EMKey_RefuseUpgrade_Text") forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(em11_HandleClickedCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelBtn];
    
    UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    confirmBtn.titleLabel.font = [ZhenwupTheme_Utils em_colors_NormalFont];
    confirmBtn.backgroundColor = [ZhenwupTheme_Utils em_colors_MainColor];
    confirmBtn.layer.cornerRadius = 5.0;
    confirmBtn.layer.masksToBounds = YES;
    [confirmBtn setTitle:MUUQYLocalizedString(@"EMKey_UpdateAtOnce_Text") forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(em11_HandleClickedConfirmBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:confirmBtn];
    
    [cancelBtn sizeToFit];
    [confirmBtn sizeToFit];
    CGFloat maxW = (messageLab.em_width - 20) / 2.0;
    CGFloat caW = cancelBtn.em_width + 30;
    if (caW < 127.0) {
        caW = 127.0;
    }
    if (caW > maxW) {
        caW = maxW;
    }
    CGFloat coW = confirmBtn.em_width + 30;
    if (coW < 127.0) {
        coW = 127.0;
    }
    if (coW > maxW) {
        coW = maxW;
    }
    CGFloat btnW = MAX(caW, coW);
    cancelBtn.em_size = CGSizeMake(btnW, 35);
    confirmBtn.em_size = CGSizeMake(btnW, 35);
    cancelBtn.em_right = self.em_width/2.0 - 10;
    confirmBtn.em_left = self.em_width/2.0 + 10;
    cancelBtn.em_top = messageLab.em_bottom + 20;
    confirmBtn.em_bottom = cancelBtn.em_bottom;
    
    self.em_height = confirmBtn.em_bottom + 20;
}


- (void)em11_HandleClickedCancelBtn:(id)sender {
    if (_em11_HandleBeforeClosedView) {
        _em11_HandleBeforeClosedView();
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(em11_HandleClosePromptView:)]) {
        [_delegate em11_HandleClosePromptView:self];
    }
}

- (void)em11_HandleClickedConfirmBtn:(id)sender {
    if (_delegate && [_delegate respondsToSelector:@selector(em11_HandleUpgrateFromPromptView:upgrateCompletion:)]) {
        [_delegate em11_HandleUpgrateFromPromptView:self upgrateCompletion:_em11_HandleBeforeClosedView];
    }
}

@end
