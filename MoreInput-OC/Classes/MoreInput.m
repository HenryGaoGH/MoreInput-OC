//
//  MoreInput.m
//  ABIVPOiOS
//
//  Created by Henry Gao on 2020/12/14.
//  Copyright © 2020 zhangjiacheng. All rights reserved.
//  多个选择

#import "MoreInput.h"
#import "InputItem.h"
#import "InputFooter.h"

@interface MoreInput()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout> {
    NSArray<InputRow *> *_selectDatas; // 全部的数据 ( select的全部数据)
}
@property(nonatomic,strong) UICollectionView *collection;
@property(nonatomic,strong) NSMutableArray<InputRow *> *datas;
@end
@implementation MoreInput
- (NSArray<InputRow *> *)currSelectedRows {
    return _selectDatas?:@[];
}
- (void)setType:(MoreInputType)type {
    _type = type;
    switch (_type) {
        case MoreInputTypeWatch: {
            [self.collection reloadData];
            break;
        }
        case MoreInputTypeSingleChoice: {
            InputRow *lastRow = self.datas.lastObject;
            if (lastRow) {
                [self.datas removeAllObjects];
                [self.datas addObject:lastRow];
                [self.collection reloadData];
            }
            break;
        }
        default: {
            break;
        }
    }
}
- (NSMutableArray<InputRow *> *)datas {
    if (!_datas) _datas = [[NSMutableArray alloc] init];
    return _datas;
}
- (UICollectionView *)collection {
    if (!_collection) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 3;
        layout.sectionInset = UIEdgeInsetsMake(3, 3, 3, 3);
        layout.minimumInteritemSpacing = 5;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collection = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collection.delegate = self;
        _collection.dataSource = self;
        _collection.backgroundColor = [UIColor whiteColor];
        [_collection registerNib:[UINib nibWithNibName:@"InputItem" bundle:nil] forCellWithReuseIdentifier:@"InputItem"];
        [_collection registerNib:[UINib nibWithNibName:@"InputFooter" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"InputFooter"];
        [self addSubview:_collection];
    }
    return _collection;
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.collection.frame = self.bounds;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if(_type == MoreInputTypeWatch) return CGSizeZero;
    return CGSizeMake(120, self.frame.size.height-6);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if(_type == MoreInputTypeWatch) return nil;
    if ([kind isEqualToString: UICollectionElementKindSectionFooter]) {
        InputFooter *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"InputFooter" forIndexPath:indexPath];
        footer.ignoreInput = _ignoreInput;
        footer.selectDatas = self.selectDatas;
        footer.inputNumber = self.inputNumber;
        __weak typeof(self) weakSelf = self;
        footer.textChanged = ^(InputRow *row) {
            if(self->_type == MoreInputTypeSingleChoice) [weakSelf.datas removeAllObjects];
            [weakSelf.datas addObject:row];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.collection reloadData];
                if(weakSelf.changedBack) weakSelf.changedBack(weakSelf.datas);
            });
        };
        return footer;
    }else return nil;
}
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    InputItem *item = item = [collectionView dequeueReusableCellWithReuseIdentifier:@"InputItem" forIndexPath:indexPath];
    item.item = (_type == MoreInputTypeSingleChoice) ? _datas.firstObject : _datas[indexPath.row];
//    item.canEdit = (_type != MoreInputTypeWatch);
    __weak typeof(self) weakSelf = self;
    item.textChanged = ^(NSString *text) {
        weakSelf.datas[indexPath.row].show = text;
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.collection reloadData];
        });
    };
    return item;
}
- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return (_type == MoreInputTypeSingleChoice) ? MIN(self.datas.count, 1) : self.datas.count;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_type == MoreInputTypeWatch) return;
    [_datas removeObjectAtIndex:indexPath.row];
    [self.collection reloadData];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *str = self.datas[indexPath.row].show?:@"";
    CGFloat width1=[str boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, self.frame.size.height-6) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size.width;
    return CGSizeMake(width1, self.frame.size.height-12);
}
@end





#pragma mark - Method
@implementation MoreInput (Method)
- (void)setSelectDatas:(NSArray<InputRow *> *)selectDatas {
    _selectDatas = selectDatas;
    [self.datas removeAllObjects];
    [self.collection reloadData];
}
- (NSArray<InputRow *> *)selectDatas {
    return _selectDatas;
}
- (void)setItems:(NSArray<InputRow *> *)items isAdd:(BOOL)add {
    if (add) [self.datas addObjectsFromArray:items];
    else self.datas = [NSMutableArray arrayWithArray:items];
    [self.collection reloadData];
}
@end
