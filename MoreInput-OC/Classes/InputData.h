
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
@interface NSArray (NOF)
- (NSArray *)filter:(BOOL (^)(id obj))block;
@end

#pragma mark - View
@interface UIView (NOF)

/// 设置一个 批注View
/// @param fillColor 填充颜色
- (void)setRoundNotationWithFillColor:(UIColor *)fillColor;
@end




