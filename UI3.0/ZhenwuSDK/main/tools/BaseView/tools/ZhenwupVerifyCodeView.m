//
//  ZhenwupVerifyCodeView.m
//  EmpriSDK
//
//  Created by Admin on 2023/1/12.
//  Copyright © 2023 Admin. All rights reserved.
//

#import "ZhenwupVerifyCodeView.h"
#define WEAKSELF typeof(self) __weak weakSelf = self;
#define FONT(a)  [UIFont systemFontOfSize:a]
//自定义 验证码展示视图 view，由一个label和一个下划线组成
@interface SMSCodeView : UIView

///文字
@property (nonatomic, strong) NSString *text;

///显示光标 默认关闭
@property (nonatomic) BOOL showCursor;

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UIView *cursor;



@end



@interface ZhenwupVerifyCodeView () <UITextFieldDelegate>

@property (strong, nonatomic) UITextField *textField;
///格子数组
@property (nonatomic,strong) NSMutableArray <SMSCodeView *> *arrayTextFidld;
///记录上一次的字符串
@property (strong, nonatomic) NSString *lastString;
///放置小格子
@property (strong, nonatomic) UIView *contentView;

@end

@implementation ZhenwupVerifyCodeView

- (instancetype)init {
    if (self = [super init]) {
        [self config];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self config];
    }
    return self;
}

- (void)config {
    
    _codeCount = 6;  //在初始化函数里面, 如果重写了某个属性的setter方法, 那么使用 self.codeCount 会直接调用重写的 setter 方法, 会造成惊喜!
    _codeSpace = 15;
    
    //初始化数组
    _arrayTextFidld = [NSMutableArray array];
    
    _lastString = @"";
    
    self.backgroundColor = UIColor.clearColor;
    
    //输入框
    _textField = [[UITextField alloc] init];
    _textField.backgroundColor = [UIColor clearColor];
    _textField.textColor=[UIColor clearColor];
    _textField.tintColor=[UIColor clearColor];
    _textField.keyboardType = UIKeyboardTypeNumberPad;
    _textField.delegate = self;
    [self addSubview:_textField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChangeValue:) name:UITextFieldTextDidChangeNotification object:_textField];
    
    //放置View
    _contentView = [[UIView alloc] init];
    _contentView.backgroundColor = UIColor.clearColor;
    _contentView.userInteractionEnabled = NO;
    [self addSubview:_contentView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self updateSubViews];
}

- (void)updateSubViews {
    
    self.textField.frame = self.bounds;
    self.contentView.frame = self.bounds;
    
    /*
     方案1: 直接把原来的都删掉, 重新创建
     for (SMSCodeView *v in [self.arrayTextFidld reverseObjectEnumerator]) {
     [v removeFromSuperview];
     [self.arrayTextFidld removeObject:v];
     }
     */
    
    //方案2:能用就用,少了再建
    if (_arrayTextFidld.count < _codeCount) { //已经存在的子控件比新来的数要小, 那么就创建
        NSUInteger c = _codeCount - _arrayTextFidld.count;
        for (NSInteger i = 0; i < c; i ++) {
            SMSCodeView *v = [[SMSCodeView alloc] init];
            [_arrayTextFidld addObject:v];
        }
    } else if (_arrayTextFidld.count == _codeCount) { //个数相等
        
        return; //如果return,那么就是什么都不做, 如果不return, 那么后续可以更新颜色之类, 或者在转屏的时候重新布局
        
    } else if (_arrayTextFidld.count > _codeCount) { //个数有多余, 那么不用创建新的, 为了尽可能释放内存, 把不用的移除掉,
        NSUInteger c = _arrayTextFidld.count - _codeCount;
        for (NSInteger i = 0; i < c; i ++) {
            [_arrayTextFidld.lastObject removeFromSuperview];
            [_arrayTextFidld removeLastObject];
        }
    }
    
    //可用宽度 / 格子总数
    CGFloat w = (self.bounds.size.width - _codeSpace * (_codeCount - 1)) / (_codeCount * 1.0);
    
    //重新布局小格子
    for (NSInteger i = 0; i < _arrayTextFidld.count; i ++) {
        SMSCodeView *t = _arrayTextFidld[i];
        [self.contentView addSubview:t];
        t.frame = CGRectMake(i * (w + _codeSpace), 0, w, self.bounds.size.height);
    }
}

//已经编辑
- (void)textFieldDidChangeValue:(NSNotification *)notification {
    
    UITextField *sender = (UITextField *)[notification object];
    
    /*
     bug: NSUInteger.
     sender.text.length 返回值是 NSUInteger,无符号整型, 当两个无符号整型做减法, 如果 6 - 9, 那么不会得到 -3, 而是一串很长的整型数, 也就是计算失误
     */
    
    BOOL a = sender.text.length >= self.lastString.length;
    BOOL b = sender.text.length - self.lastString.length >= _codeCount;
    if (a && b) { //判断为一连串验证码输入, 那么,最后N个,就是来自键盘上的短信验证码,取最后N个
        NSLog(@"一连串的输入");
        sender.text = [sender.text substringFromIndex:sender.text.length - _codeCount];
    }
    
    if (sender.text.length >= _codeCount + 1) { //对于持续输入,只要前面N个就行
        NSLog(@"持续输入");
        sender.text = [sender.text substringToIndex:_codeCount - 1];
    }
    
    //字符串转数组
    NSMutableArray <NSString *> *stringArray = [NSMutableArray array];
    NSString *temp = nil;
    for(int i = 0; i < [sender.text length]; i++) {
        temp = [sender.text substringWithRange:NSMakeRange(i,1)];
        [stringArray addObject:temp];
    }
    
    //设置文字
    for(int i = 0; i < self.arrayTextFidld.count; i++) {
        SMSCodeView *SMSCodeView = self.arrayTextFidld[i];
        if (i < stringArray.count) {
            SMSCodeView.text = stringArray[i];
        } else {
            SMSCodeView.text = @"";
        }
    }
    
    //设置光标
    if (stringArray.count == 0) {
        for(int i = 0; i < self.arrayTextFidld.count; i++) {
            BOOL hide = (i == 0 ? YES : NO);
            SMSCodeView *SMSCodeView = self.arrayTextFidld[i];
            SMSCodeView.showCursor = hide;
        }
    } else if (stringArray.count == self.arrayTextFidld.count) {
        for(int i = 0; i < self.arrayTextFidld.count; i++) {
            SMSCodeView *SMSCodeView = self.arrayTextFidld[i];
            SMSCodeView.showCursor = NO;
        }
    } else {
        for(int i = 0; i < self.arrayTextFidld.count; i++) {
            SMSCodeView *SMSCodeView = self.arrayTextFidld[i];
            if (i == stringArray.count - 1) {
                SMSCodeView.showCursor = YES;
            } else {
                SMSCodeView.showCursor = NO;
            }
        }
    }
    self.lastString = sender.text;
    if (stringArray.count == self.arrayTextFidld.count) {
        [self.textField resignFirstResponder];
        self.codeResignCompleted(self.lastString);
    }
    
   
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    //检查上一次的字符串
    if (self.lastString.length == 0 || self.lastString.length == 1) {
        self.arrayTextFidld.firstObject.showCursor = YES;
    } else if (self.lastString.length == self.arrayTextFidld.count) {
        self.arrayTextFidld.lastObject.showCursor = YES;
//        self.codeResignCompleted(self.lastString);
        
        
    } else {
        self.arrayTextFidld[self.lastString.length - 1].showCursor = YES;
    }
}

- (NSString *)codeText {
    return self.textField.text;
}

- (BOOL)resignFirstResponder {
    for(int i = 0; i < self.arrayTextFidld.count; i++) {
        SMSCodeView *SMSCodeView = self.arrayTextFidld[i];
        SMSCodeView.showCursor = NO;
    }
    [self.textField resignFirstResponder];
    return YES;
}

- (BOOL)becomeFirstResponder {
//    [self.textField becomeFirstResponder];
    return NO;
}

///如果要求可以随时更改输入位数, 那么,
- (void)setCodeCount:(NSInteger)codeCount {
    _codeCount = codeCount;
    
    //因为个数改变,清空之前输入的内容
    self.lastString = @"";
    self.textField.text = @"";
    
    for (NSInteger i = 0; i < _arrayTextFidld.count; i ++) {
        SMSCodeView *t = _arrayTextFidld[i];
        t.text = @"";
        if (i == 0) {
            t.showCursor = YES;
        } else {
            t.showCursor = NO;
        }
    }
    
    [self setNeedsLayout];
    [self layoutIfNeeded];
}



@end
@implementation SMSCodeView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self config];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self config];
    }
    return self;
}

- (void)config {
    
    self.userInteractionEnabled = NO;
    
    _line = [[UIView alloc] init];
    _line.userInteractionEnabled = NO;
    _line.backgroundColor = UIColor.whiteColor;
    [self addSubview:_line];
    
    _label = [[UILabel alloc] init];
    _label.textColor = UIColor.whiteColor;
    _label.font=[UIFont systemFontOfSize:20];
    [self addSubview:_label];
    
    //默认关闭
    _showCursor = NO;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.line.frame = CGRectMake(0, (self.frame.size.height/2) - 0.5, self.frame.size.width, 1);
    CGFloat x = (self.frame.size.width - self.label.frame.size.width) / 2.0;
    CGFloat y = (self.frame.size.height - self.label.frame.size.height) / 2.0;
    self.label.frame = CGRectMake(x, y, self.label.frame.size.width, self.label.frame.size.height);
    
    [self updateCursorFrame];
}

- (void)setText:(NSString *)text {
    _text = text;
    if (_text.length > 0) {
        _line.hidden=YES;
//        _line.backgroundColor = UIColor.redColor;
    } else {
        _line.hidden=NO;
//        _line.backgroundColor = UIColor.grayColor;
    }
    _label.text = text;
    [self.label sizeToFit];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)updateCursorFrame {
    CGFloat x = 0;
    if (self.label.frame.size.width <= 0) {
        x = (self.frame.size.width - 1.6) / 2.0;
    } else {
        x = CGRectGetMaxX(self.label.frame);
    }
    _cursor.frame = CGRectMake(x, 10, 1.6, self.frame.size.height - 20);
}

- (void)setShowCursor:(BOOL)showCursor {
    
    if (_showCursor == YES && showCursor == YES) { //重复开始, 那么,什么也不做
    } else if (_showCursor == YES && showCursor == NO) { //原来是开始的, 现在要求关闭, 那么,就关闭
        [_cursor removeFromSuperview];
    } else if (_showCursor == NO && showCursor == YES) { //原来是关闭, 现在要求开始, 那么, 开始
        _cursor = [[UIView alloc] init];
        _cursor.userInteractionEnabled = NO;
//        _cursor.backgroundColor = UIColor.redColor;
        _cursor.backgroundColor = [UIColor clearColor];
        [self addSubview:_cursor];
        [self updateCursorFrame];
        _cursor.alpha = 0;
        [self animationOne:_cursor];
    } else if (_showCursor == NO && showCursor == NO) { //重复关闭
        [_cursor removeFromSuperview];
    }
    _showCursor = showCursor;
}

// 光标效果
- (void)animationOne:(UIView *)aView {
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        aView.alpha = 1;
    } completion:^(BOOL finished) {
        if (self.showCursor) {
            [self performSelector:@selector(animationTwo:) withObject:aView afterDelay:0.5];
        }
    }];
}

- (void)animationTwo:(UIView *)aView {
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        aView.alpha = 0;
    } completion:^(BOOL finished) {
        if (self.showCursor) {
            [self performSelector:@selector(animationOne:) withObject:aView afterDelay:0.1];
        }
    }];
}

@end
