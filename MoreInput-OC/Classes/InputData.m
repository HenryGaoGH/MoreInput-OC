#import "InputData.h"



@implementation InputRow
-(instancetype)initWithK:(NSString *)key withShow:(NSString *)show {
    self = [super init];
    if (self) {
        self.key = key;
        self.show = show;
    }
    return self;
}

@end

#pragma mark - Array Ext
@implementation NSArray (NOF)
- (NSArray *)filter:(BOOL (^)(id obj))block {
    NSMutableArray *mutableArray = [NSMutableArray new];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (block(obj) == YES) {
            [mutableArray addObject:obj];
        }
    }];
    return [mutableArray copy];
}
@end


#pragma mark - View
@implementation UIView (Method)
- (CGFloat)maxX {
    return CGRectGetMaxX(self.frame);
}
- (CGFloat)maxY {
    return CGRectGetMaxY(self.frame);
}
/**
 设置一个 批注View
 */
- (void)setRoundNotationWithFillColor:(UIColor *)fillColor {
    UIBezierPath *triangle = [UIBezierPath bezierPath];
    [triangle moveToPoint: CGPointMake(self.maxX/2, self.maxY)];
    [triangle addLineToPoint: CGPointMake(self.maxX/2-5, self.maxY-5)];
    [triangle addLineToPoint: CGPointMake(self.maxX/2+5, self.maxY-5)];
    [triangle closePath];
    UIBezierPath *rect = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.maxX, self.maxY-5) cornerRadius:8];
    [rect closePath];
    UIBezierPath *allBz = [UIBezierPath bezierPath];
    [allBz appendPath:triangle];
    [allBz appendPath:rect];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    [layer setFillColor: fillColor.CGColor];
    layer.path = allBz.CGPath;
    [layer setStrokeColor:fillColor.CGColor];
    self.layer.mask = layer;
}
@end
