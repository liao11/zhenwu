
#import "PureHFieldV.h"
#import "ZhenwupTheme_Utils.h"
#import "UIView+GrossExtension.h"

@interface PureHFieldV () <UITextFieldDelegate>

@property (nonatomic, strong) UIView *em14_TextFieldBgView;
@property (nonatomic, strong) UIView *em_rightView;
@end

@implementation PureHFieldV

- (void)dealloc {
    [self.em14_TextField removeObserver:self forKeyPath:@"text" context:nil];
    MYMGLog(@"%@ dealloc..", NSStringFromClass([self class]));
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
    
    if (_em14_FixedTitleWidth > 0) {
        _em14_TitleLab.em_width = _em14_FixedTitleWidth;
    } else {
        [_em14_TitleLab sizeToFit];
    }
    
    _em14_TitleLab.em_centerY = self.em_height / 2.0;
    _em14_TextFieldBgView.em_height = MIN(30.0, self.em_height);
    _em14_TextFieldBgView.em_centerY = _em14_TitleLab.em_centerY;
    _em14_TextFieldBgView.em_left = _em14_TitleLab.em_right + 5;
    _em14_TextFieldBgView.em_width = self.em_width - _em14_TitleLab.em_right - 5;
    _em14_TextField.frame = CGRectMake(8, 2, _em14_TextFieldBgView.em_width - 10 - _em_rightView.em_width, _em14_TextFieldBgView.em_height-4);
}

- (void)em14_SetupDefaultViews {
    self.em14_TitleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.em_width/4.0, self.em_height)];
    self.em14_TitleLab.font = [ZhenwupTheme_Utils em_colors_LargeFont];
    self.em14_TitleLab.textColor = [ZhenwupTheme_Utils em_colors_LightColor];
    [self addSubview:self.em14_TitleLab];
    
    self.em14_TextFieldBgView = [[UIView alloc] initWithFrame:CGRectMake(self.em14_TitleLab.em_right + 5, 0, self.em_width - self.em14_TitleLab.em_right, self.em_height)];
    self.em14_TextFieldBgView.backgroundColor = [ZhenwupTheme_Utils em_colors_MaskInputColor];
    self.em14_TextFieldBgView.layer.borderColor =  [ZhenwupTheme_Utils em_colors_LineColor].CGColor;
    self.em14_TextFieldBgView.layer.borderWidth = EM_1_PIXEL_SIZE;
    self.em14_TextFieldBgView.layer.cornerRadius = 3.0;
    [self addSubview:self.em14_TextFieldBgView];
    
    self.em14_TextField = [[ZhenwupBaseTextField alloc] initWithFrame:CGRectMake(8, 2, self.em14_TextFieldBgView.em_width-10, self.em14_TextFieldBgView.em_height-4)];
    self.em14_TextField.delegate = self;
    self.em14_TextField.font = [ZhenwupTheme_Utils em_colors_NormalFont];
    self.em14_TextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.em14_TextField.textColor = [ZhenwupTheme_Utils em_colors_DarkGrayColor];
    self.em14_TextField.placeholderColor = [ZhenwupTheme_Utils khxl_textPlaceholderColor];
    [self.em14_TextField addTarget:self action:@selector(em14_TextFieldTextDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.em14_TextField addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self.em14_TextFieldBgView addSubview:self.em14_TextField];
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

- (void)em14_setRightView:(UIView *)rightView {
    if (![self.subviews containsObject:rightView]) {
        self.em_rightView = rightView;
        [self addSubview:rightView];
    }
    
    rightView.em_centerY = _em14_TextField.em_centerY;
    rightView.em_right = self.em_width;
    
    _em14_TextFieldBgView.em_width = self.em_width - _em14_TitleLab.em_right - 5;
    _em14_TextField.frame = CGRectMake(8, 2, _em14_TextFieldBgView.em_width - 10 - _em_rightView.em_width, _em14_TextFieldBgView.em_height-4);
}

- (void)em14_u_SetNodataNotActionStateLayout {
}

- (void)em14_u_SetActiveOrHasDataStateLayout {
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (_delegate && [_delegate respondsToSelector:@selector(em14_HorizontalInputTextFieldViewShouldReturn:)]) {
        return [_delegate em14_HorizontalInputTextFieldViewShouldReturn:self];
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
    if (_delegate && [_delegate respondsToSelector:@selector(em14_HorizontalInputTextFieldViewTextDidChange:)]) {
        [_delegate em14_HorizontalInputTextFieldViewTextDidChange:self];
    }
}

@end
