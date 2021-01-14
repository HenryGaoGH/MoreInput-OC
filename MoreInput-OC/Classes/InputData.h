
typedef void(^InputBack)(id args);

#pragma mark - 一行数据
@interface InputRow : NSObject
@property(nonatomic,strong) NSString * key;     // 提交的内容
@property(nonatomic,strong) NSString * show;    // 展示的内容

/// 工厂函数
/// @param key 提交的值
/// @param show 展示的内容
-(instancetype)initWithK:(NSString *)key withShow:(NSString *)show;
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



