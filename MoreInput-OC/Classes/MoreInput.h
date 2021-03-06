//
//  MoreInput.h
//  ABIVPOiOS
//
//  Created by Henry Gao on 2020/12/14.
//  Copyright © 2020 zhangjiacheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputData.h"
NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    MoreSelectTypeNone,         // 不允许选择
    MoreSelectTypeSingle,       // 选择一个或者输入一个
    MoreSelectTypeMore,         // 多选 如果设置ignoreInput 则只能多选
} MoreSelectType;

@interface MoreInput : UIView

/// 设置 选择类型
@property(nonatomic,assign) MoreSelectType type;

/// 忽略输入的内容 (是不是 将输入的内容 设置 成选择内容)
@property(nonatomic,assign) BOOL ignoreInput;

/// 设置 键盘是不是数字 defult: string
@property(nonatomic,assign) BOOL inputNumber;

/// 选择发生改变 回掉 参数为当前的选中数据 InputRow
@property(nonatomic,copy) InputBack changedBack;

/// 当前选中的数据
@property(nonatomic,strong,readonly) NSArray<InputRow *> *currSelectedRows;
@end


@interface MoreInput (Method)
/// 设置Items
/// @param items 待增加的项目
/// @param add 是不是增加 还是替换
- (void)setItems:(NSArray<InputRow *> *)items isAdd:(BOOL)add;

/// 当前的可以选择的 全部数据源  会产生一个浮动的selectView
@property(nonatomic,strong)NSArray<InputRow *> *selectDatas;

@end

NS_ASSUME_NONNULL_END
