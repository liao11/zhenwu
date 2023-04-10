
#import "UIView+GrossExtension.h"

@implementation UIView (MYMGExtension)

CGPoint CGRectGetCenter(CGRect rect)
{
    CGPoint pt;
    pt.x = CGRectGetMidX(rect);
    pt.y = CGRectGetMidY(rect);
    return pt;
}

CGRect CGRectMoveToCenter(CGRect rect, CGPoint center)
{
    CGRect newrect = CGRectZero;
    newrect.origin.x = center.x-CGRectGetMidX(rect);
    newrect.origin.y = center.y-CGRectGetMidY(rect);
    newrect.size = rect.size;
    return newrect;
}

- (CGFloat)em_left {
    return self.frame.origin.x;
}

- (void)setEm_left:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)em_top {
    return self.frame.origin.y;
}

- (void)setEm_top:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)em_right {
    return self.em_left + self.em_width;
}

- (void)setEm_right:(CGFloat)right {
    if(right == self.em_right){
        return;
    }
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)em_bottom {
    return self.em_top + self.em_height;
}

- (void)setEm_bottom:(CGFloat)bottom {
    if(bottom == self.em_bottom){
        return;
    }
    
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)em_centerX {
    return self.center.x;
}

- (void)setEm_centerX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)em_centerY {
    return self.center.y;
}

- (void)setEm_centerY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)em_width {
    return self.frame.size.width;
}

- (void)setEm_width:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)em_height {
    return self.frame.size.height;
}

- (void)setEm_height:(CGFloat)height {
    if(height == self.em_height){
        return;
    }
    
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGPoint)em_origin {
    return self.frame.origin;
}

- (void)setEm_origin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)em_size {
    return self.frame.size;
}

- (void)setEm_size:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)em_removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

- (UIViewController*)em_viewController {
    UIResponder *responder = self;
    while ((responder = [responder nextResponder])) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
    }
    return nil;
}

- (void)em_moveBy:(CGPoint)delta
{
    CGPoint newcenter = self.center;
    newcenter.x += delta.x;
    newcenter.y += delta.y;
    self.center = newcenter;
}

- (void)em_scaleBy:(CGFloat)scaleFactor
{
    CGRect newframe = self.frame;
    newframe.size.width *= scaleFactor;
    newframe.size.height *= scaleFactor;
    self.frame = newframe;
}

- (void)em_fitInSize:(CGSize)aSize
{
    CGFloat scale;
    CGRect newframe = self.frame;
    
    if (newframe.size.height && (newframe.size.height > aSize.height))
    {
        scale = aSize.height / newframe.size.height;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    if (newframe.size.width && (newframe.size.width >= aSize.width))
    {
        scale = aSize.width / newframe.size.width;
        newframe.size.width *= scale;
        newframe.size.height *= scale;
    }
    
    self.frame = newframe;
}

- (void)em_drawCircle {
    [self em_drawCircleCornerRadii:CGSizeZero byRoundingCorners:UIRectCornerAllCorners];
}

- (void)em_drawCircleRadius:(CGFloat)cornerRadius {
    [self em_drawCircleCornerRadii:CGSizeMake(cornerRadius, cornerRadius) byRoundingCorners:UIRectCornerAllCorners];
}

- (void)em_drawCircleRadius:(CGFloat)cornerRadius byRoundingCorners:(UIRectCorner)corners {
    [self em_drawCircleCornerRadii:CGSizeMake(cornerRadius, cornerRadius) byRoundingCorners:corners];
}

- (void)em_drawCircleCornerRadii:(CGSize)cornerRadii byRoundingCorners:(UIRectCorner)corners {
    if (CGSizeEqualToSize(cornerRadii,CGSizeZero)) {
        cornerRadii = self.bounds.size;
    }
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                   byRoundingCorners:corners
                                                         cornerRadii:cornerRadii];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}

@end
