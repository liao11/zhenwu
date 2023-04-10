
#import "ZhenwupVerifyCodeImage_View.h"
#import "EM_Define.h"

#define ARC4RAND_MAX 0x100000000

@interface ZhenwupVerifyCodeImage_View ()

@property (nonatomic, strong) NSArray *textArray;
@property (nonatomic, strong) UIView *bgView;
@end

@implementation ZhenwupVerifyCodeImage_View

- (void)dealloc {
    MYMGLog(@"%@ dealloc..", NSStringFromClass([self class]));
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)tapClick:(UITapGestureRecognizer*)tap {
    [self em14_refreshCode];
}

- (void)em14_refreshCode {
    [self changeCodeStr];
    [self initImageCodeView];
}

- (void)changeCodeStr {
    self.textArray = [[NSArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z",nil];
    
    for(NSInteger i = 0; i < 4; i++) {
        NSInteger index = arc4random() % ([self.textArray count] - 1);
        NSString *oneText = [self.textArray objectAtIndex:index];
        self.em14_codeString = (i==0)?oneText:[self.em14_codeString stringByAppendingString:oneText];
    }
    if (self.em14_ResultCodeBolck) {
        self.em14_ResultCodeBolck(self.em14_codeString);
    }
}

- (void)initImageCodeView {
    if (_bgView) {
        [_bgView removeFromSuperview];
    }
    _bgView = [[UIView alloc]initWithFrame:self.bounds];
    [_bgView setBackgroundColor:[self getRandomBgColorWithAlpha:0.5]];
    [self addSubview:_bgView];
    
    CGSize textSize = [@"W" sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}];
    int randWidth = (self.frame.size.width)/self.em14_codeString.length - textSize.width;
    int randHeight = self.frame.size.height - textSize.height;
    
    for (int i = 0; i<self.em14_codeString.length; i++) {
        CGFloat px = arc4random()%randWidth + i*(self.frame.size.width-3)/self.em14_codeString.length;
        CGFloat py = arc4random()%randHeight;
        UILabel * label = [[UILabel alloc] initWithFrame: CGRectMake(px+3, py, textSize.width, textSize.height)];
        label.text = [NSString stringWithFormat:@"%C",[self.em14_codeString characterAtIndex:i]];
        label.font = [UIFont systemFontOfSize:20];
        if (self.isRotation) {
            double r = (double)arc4random() / ARC4RAND_MAX * 2 - 1.0f;
            if (r>0.3) {
                r=0.3;
            } else if(r<-0.3){
                r=-0.3;
            }
            label.transform = CGAffineTransformMakeRotation(r);
        }
        
        [_bgView addSubview:label];
    }
    
    for (int i = 0; i<10; i++) {
        UIBezierPath *path = [UIBezierPath bezierPath];
        CGFloat pX = arc4random() % (int)CGRectGetWidth(self.frame);
        CGFloat pY = arc4random() % (int)CGRectGetHeight(self.frame);
        [path moveToPoint:CGPointMake(pX, pY)];
        CGFloat ptX = arc4random() % (int)CGRectGetWidth(self.frame);
        CGFloat ptY = arc4random() % (int)CGRectGetHeight(self.frame);
        [path addLineToPoint:CGPointMake(ptX, ptY)];
        
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.strokeColor = [[self getRandomBgColorWithAlpha:0.2] CGColor];
        layer.lineWidth = 1.0f;
        layer.strokeEnd = 1;
        layer.fillColor = [UIColor clearColor].CGColor;
        layer.path = path.CGPath;
        [_bgView.layer addSublayer:layer];
    }
    
}

- (UIColor *)getRandomBgColorWithAlpha:(CGFloat)alpha {
    float red = arc4random() % 100 / 100.0;
    float green = arc4random() % 100 / 100.0;
    float blue = arc4random() % 100 / 100.0;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    return color;
}

@end
