
#import "KeenWireField.h"
#import "ZhenwupTheme_Utils.h"
#import "UIView+GrossExtension.h"
#import <objc/runtime.h>
#import "ZhenwupHelper_Utils.h"
@interface KeenWireField () <UITextFieldDelegate>

@property (nonatomic, strong) UIView *em14_TextFieldBgView;
@property (nonatomic, strong) UIView *em_rightView;
@end

@implementation KeenWireField

- (void)dealloc {
    MYMGLog(@"%@ dealloc..", NSStringFromClass([self class]));
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self em14_SetupDefaultViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
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
//    self.em14_TextFieldBgView.backgroundColor = [ZhenwupTheme_Utils em_colors_MaskInputColor];
    self.em14_TextFieldBgView.backgroundColor = [UIColor colorWithRed:18/255.0 green:19/255.0 blue:29/255.0 alpha:0.5];
//    self.em14_TextFieldBgView.layer.borderColor =  [UIColor colorWithRed:33/255.0 green:14/255.0 blue:0/255.0 alpha:0.5].CGColor;
//    self.em14_TextFieldBgView.layer.borderWidth = EM_1_PIXEL_SIZE;
    self.em14_TextFieldBgView.layer.cornerRadius = 15;
    self.em14_TextFieldBgView.layer.masksToBounds = YES;
    [self addSubview:self.em14_TextFieldBgView];
    
    self.em14_TextField = [[ZhenwupBaseTextField alloc] initWithFrame:CGRectMake(43, 2, self.em14_TextFieldBgView.em_width-45, self.em14_TextFieldBgView.em_height-4)];
    self.em14_TextField.delegate = self;
    
    self.em14_TextField.clearButtonMode=UITextFieldViewModeNever;
    
    
    self.em14_TextField.font = [ZhenwupTheme_Utils em_colors_NormalFont];
//    self.em14_TextField.clearButtonMode = UITextFieldViewModeWhileEditing;
//    
//    UIButton *button =[self.em14_TextField valueForKey:@"_clearButton"];
//    [button setImage:[ZhenwupHelper_Utils imageName:@"zhenwuimshan"] forState:UIControlStateNormal];
    
    
    
    
    
    self.em14_TextField.placeholderColor = [ZhenwupTheme_Utils khxl_textPlaceholderColor];
    self.em14_TextField.textColor = [ZhenwupTheme_Utils em_colors_DarkGrayColor];
    [self.em14_TextField addTarget:self action:@selector(em14_TextFieldTextDidChange:) forControlEvents:UIControlEventEditingChanged];

    [self.em14_TextFieldBgView addSubview:self.em14_TextField];
    
    self.em14_fieldLeftIcon = [[UIImageView alloc] initWithFrame:CGRectMake(13, 8, 29, 29)];
    [self.em14_TextFieldBgView addSubview:self.em14_fieldLeftIcon];
    
    self.em_telBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.em_telBtn.frame = CGRectMake(18, 12, 16, 16);
    [self.em_telBtn setTitle:MUUQYLocalizedString(@"EMKey_nowDist") forState:UIControlStateNormal];
    [self.em_telBtn setTitleColor:[ZhenwupTheme_Utils em_colors_ButtonColor] forState:UIControlStateNormal];
    [self.em_telBtn addTarget:self action:@selector(em18_telClick) forControlEvents:UIControlEventTouchUpInside];
    self.em_telBtn.titleLabel.font = [ZhenwupTheme_Utils em_colors_SmallFont];
    [self.em14_TextFieldBgView addSubview:self.em_telBtn];
    self.em_telBtn.hidden = true;
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

- (void)setzwp01_tel:(bool)zwp01_tel{
    if (zwp01_tel) {
        self.em14_fieldLeftIcon.hidden = true;
        self.em_telBtn.hidden = false;
    }else{
        self.em14_fieldLeftIcon.hidden = false;
        self.em_telBtn.hidden = true;
    }
}

- (void)em18_telClick{
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (_delegate && [_delegate respondsToSelector:@selector(em14_InputTextFieldViewShouldReturn:)]) {
        return [_delegate em14_InputTextFieldViewShouldReturn:self];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (_delegate && [_delegate respondsToSelector:@selector(em14_InputTextFieldViewTextDidChange:)]) {
        [_delegate em14_InputTextFieldViewTextDidChange:self];
    }
}


-(void)em14_TextFieldTextDidChange:(UITextField *)textField {
    if (_delegate && [_delegate respondsToSelector:@selector(em14_InputTextFieldViewTextDidChange:)]) {
        [_delegate em14_InputTextFieldViewTextDidChange:self];
    }
}
@end
