
#import <UIKit/UIKit.h>
#import "EM_Define.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIView (MYMGExtension)

@property (nonatomic) CGFloat em_left;
@property (nonatomic) CGFloat em_top;
@property (nonatomic) CGFloat em_right;
@property (nonatomic) CGFloat em_bottom;
@property (nonatomic) CGFloat em_width;
@property (nonatomic) CGFloat em_height;
@property (nonatomic) CGPoint em_origin;
@property (nonatomic) CGSize  em_size;
@property (nonatomic) CGFloat em_centerX;
@property (nonatomic) CGFloat em_centerY;

- (void)em_removeAllSubviews;
- (UIViewController *)em_viewController;

- (void)em_moveBy:(CGPoint)delta;
- (void)em_scaleBy:(CGFloat)scaleFactor;
- (void)em_fitInSize:(CGSize)aSize;

- (void)em_drawCircle;
- (void)em_drawCircleRadius:(CGFloat)cornerRadius;
- (void)em_drawCircleCornerRadii:(CGSize)cornerRadii byRoundingCorners:(UIRectCorner)corners;

@end

NS_ASSUME_NONNULL_END
