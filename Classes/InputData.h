
typedef void(^InputBack)(id args);

#pragma mark - 一行数据
@interface InputRow : NSObject
@property(nonatomic,strong) NSString * key;     // 提交的内容
@property(nonatomic,strong) NSString * show;    // 展示的内容

/// 工厂函数
/// @param key 提交的值
/// @param show 展示的内容
-(instancetype)initWith:(NSString *)key withV:(NSString *)show;
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
