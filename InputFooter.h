//
//  InputFooter.h
//  ABIVPOiOS
//
//  Created by Henry Gao on 2020/12/15.
//  Copyright © 2020 zhangjiacheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputData.h"
NS_ASSUME_NONNULL_BEGIN

@interface InputFooter : UICollectionReusableView
/// 编辑完成回掉 返回一个 FilterRow
@property(nonatomic,copy) InputBack textChanged;
/// 选择的数据源 *** 数据源为nil count==0 时 只会返回 输入的信息. 如果ignore Input==true 则什么也不会回掉返回
@property(nonatomic,strong)NSArray<InputRow *> *selectDatas;

/// 忽略输入内容 **** 也就是或 输入的内容 只供模糊查找筛选数据 不作为输入的内容返回! 只返回筛选中有的数据
@property(nonatomic,assign)BOOL ignoreInput;

/// 输入数字
@property(nonatomic,assign)BOOL inputNumber;

@end

NS_ASSUME_NONNULL_END
