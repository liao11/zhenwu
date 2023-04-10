
#import "ZhenwupProgress_View.h"
#import "ZhenwupTheme_Utils.h"
#import "UIView+GrossExtension.h"

@interface ZhenwupProgress_View ()

@property(nonatomic, strong, nullable) UIView* em14_ProgressView;
@end

@implementation ZhenwupProgress_View

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

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self em14_SetupDefaultViews];
    }
    return self;
}

- (void)em14_SetupDefaultViews {
//    self.layer.borderColor =  [ZhenwupTheme_Utils em_colors_MainColor].CGColor;
//    self.layer.borderWidth = 0.5;
    self.layer.cornerRadius = self.em_height / 2.0;
    self.layer.masksToBounds = YES;
    
    self.backgroundColor = [ZhenwupTheme_Utils em_colors_DarkColor];
    
    self.em14_ProgressView = [[UIView alloc] initWithFrame:self.bounds];
    self.em14_ProgressView.layer.masksToBounds = YES;
    self.layer.cornerRadius = self.em_height / 2.0;
    
    
    self.em14_ProgressView.backgroundColor = [ZhenwupTheme_Utils em_colors_MainColor];
    [self addSubview:self.em14_ProgressView];
}

- (void)setProgress:(float)progress {
    _progress = progress;
    self.em14_ProgressView.em_width = self.em_width * progress;
}

@end
