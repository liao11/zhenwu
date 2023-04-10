
#import "ZhenwupVerifyInPutTextField_View.h"
#import "ZhenwupTheme_Utils.h"
#import "ZhenwupHelper_Utils.h"
#import "UIView+GrossExtension.h"
#import "ZhenwupTimerButton_View.h"

@interface ZhenwupVerifyInPutTextField_View () <UITextFieldDelegate, EM_TimerButton_ViewDelegate>

@property (nonatomic, strong) UIView *em14_TextFieldBgView;
@property (nonatomic, strong) ZhenwupTimerButton_View *em14_TimerButton;
@property (nonatomic, strong) UIView *em_rightView;
@end

@implementation ZhenwupVerifyInPutTextField_View

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
    
    _em_rightView.em_centerY = _em14_TextFieldBgView.em_centerY;
    _em_rightView.em_right = _em14_TextFieldBgView.em_width - 5;
    _em14_TextField.em_width = _em14_TextFieldBgView.em_width - 45 - _em_rightView.em_width;
}

- (void)em14_SetupDefaultViews {
    
    self.em14_TextFieldBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.em_width, self.em_height)];
    self.em14_TextFieldBgView.backgroundColor =[UIColor colorWithRed:18/255.0 green:19/255.0 blue:29/255.0 alpha:0.5];
//    self.em14_TextFieldBgView.layer.borderColor =  [UIColor colorWithRed:33/255.0 green:14/255.0 blue:0/255.0 alpha:0.5].CGColor;
//    self.em14_TextFieldBgView.layer.borderWidth = EM_1_PIXEL_SIZE;
//    self.em14_TextFieldBgView.layer.cornerRadius = 1;
    
    self.em14_TextFieldBgView.layer.cornerRadius = 15;
    self.em14_TextFieldBgView.layer.masksToBounds = YES;
    
    
    self.em14_TextFieldBgView.layer.masksToBounds = YES;
    [self addSubview:self.em14_TextFieldBgView];
    
//    self.em14_fieldLeftIcon = [[UIImageView alloc] initWithFrame:CGRectMake(18, 12, 16, 16)];
    
    self.em14_fieldLeftIcon = [[UIImageView alloc] initWithFrame:CGRectMake(13, 8, 29, 29)];
    [self.em14_TextFieldBgView addSubview:self.em14_fieldLeftIcon];
    
    self.em14_TextField = [[ZhenwupBaseTextField alloc] initWithFrame:CGRectMake(43, 2, self.em14_TextFieldBgView.em_width-45, self.em14_TextFieldBgView.em_height-4)];
    self.em14_TextField.delegate = self;
    self.em14_TextField.font = [ZhenwupTheme_Utils em_colors_NormalFont];
    self.em14_TextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.em14_TextField.placeholderColor = [ZhenwupTheme_Utils khxl_textPlaceholderColor];
    self.em14_TextField.textColor = [ZhenwupTheme_Utils em_colors_DarkGrayColor];
    [self.em14_TextField addTarget:self action:@selector(em14_TextFieldTextDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.em14_TextFieldBgView addSubview:self.em14_TextField];
//    emprigetcode
    
    
    
    self.em14_TimerButton = [[ZhenwupTimerButton_View alloc] initWithFrame:CGRectMake(0, 0, 77, self.em_height)];
    self.em14_TimerButton.em14_BtnTitle = MUUQYLocalizedString(@"EMKey_SendButton_Text");
    self.em14_TimerButton.delegate = self;
    [self em14_setRightView:self.em14_TimerButton];
    
//    Gửi mã KH
}

- (void)em14_setRightView:(UIView *)rightView {
    if (![self.subviews containsObject:rightView]) {
        self.em_rightView = rightView;
        [self addSubview:rightView];
    }
    
    rightView.em_centerY = _em14_TextFieldBgView.em_centerY;
    rightView.em_right = _em14_TextFieldBgView.em_width - 5;
    _em14_TextField.em_width = _em14_TextFieldBgView.em_width - 45 - rightView.em_width;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"text"] && object == self.em14_TextField) {
        NSString *newText = change[NSKeyValueChangeNewKey];
        NSString *oldText = change[NSKeyValueChangeOldKey];
        if (newText && oldText) {
            if ([newText isEqualToString:oldText] == NO) {
                if (newText.length == 0) {
                    [self em14_u_SetNodataNotActionStateLayout];
                } else if (oldText.length == 0) {
                    [self em14_u_SetActiveOrHasDataStateLayout];
                }
            }
        }
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)em14_SetInputCornerRadius:(CGFloat)cornerRadius {
    self.em14_TextFieldBgView.layer.cornerRadius = cornerRadius;
}

- (void)em14_ResetNormalSendStates {
    [_em14_TimerButton em14_ResetNormalSendStates];
}

- (void)em14_u_SetNodataNotActionStateLayout {
}

- (void)em14_u_SetActiveOrHasDataStateLayout {
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (_delegate && [_delegate respondsToSelector:@selector(em14_VerifyInputTextFieldViewShouldReturn:)]) {
        return [_delegate em14_VerifyInputTextFieldViewShouldReturn:self];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField.text.length == 0) {
        [self em14_u_SetActiveOrHasDataStateLayout];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.text.length == 0) {
        [self em14_u_SetNodataNotActionStateLayout];
    }
}

- (void)em14_TextFieldTextDidChange:(UITextField *)textField {
    if (_delegate && [_delegate respondsToSelector:@selector(em14_VerifyInputTextFieldViewTextDidChange:)]) {
        [_delegate em14_VerifyInputTextFieldViewTextDidChange:self];
    }
}


- (BOOL)em14_ClickedTimerButtonView:(ZhenwupTimerButton_View *)view {
    if (_delegate && [_delegate respondsToSelector:@selector(em14_HandleSendVerifyCode:)]) {
        return [_delegate em14_HandleSendVerifyCode:self];
    }
    return YES;
}

@end
