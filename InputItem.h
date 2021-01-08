//
//  InputItem.h
//  ABIVPOiOS
//
//  Created by Henry Gao on 2020/12/14.
//  Copyright © 2020 zhangjiacheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InputData.h"

NS_ASSUME_NONNULL_BEGIN

@interface InputItem : UICollectionViewCell
/// 是不是可以编辑
@property(nonatomic,assign) BOOL canEdit;
/// 文字发生改变回掉(当前只是 结束编辑的时候回掉返回文字)
@property(nonatomic,copy) InputBack textChanged;
/// 模型
@property(nonatomic,strong)InputRow *item;
@end


NS_ASSUME_NONNULL_END
