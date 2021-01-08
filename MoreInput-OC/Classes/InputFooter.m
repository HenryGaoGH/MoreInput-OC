//
//  InputFooter.m
//  ABIVPOiOS
//
//  Created by Henry Gao on 2020/12/15.
//  Copyright © 2020 zhangjiacheng. All rights reserved.
//

#import "InputFooter.h"
//#import "NSArray+HOF.h"

@interface InputFooter() {
    NSArray<InputRow *> *_searchRows;
}
@property (weak, nonatomic) IBOutlet UITextField *input;
@property(nonatomic,strong) UIButton *editDone;             // 手动输入的时候 点击此按钮完成输入
@property(nonatomic,strong) UITableView *selectTable;
@end

@implementation InputFooter
- (void)awakeFromNib {
    [super awakeFromNib];
    _input.rightView = self.editDone;
    _input.rightViewMode = _ignoreInput ? UITextFieldViewModeNever : UITextFieldViewModeWhileEditing;
}
- (UIButton *)editDone {
    if (!_editDone) {
        _editDone = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        [_editDone setImage:[UIImage imageNamed:@"todo"] forState:(UIControlStateNormal)];
        [_editDone addTarget:self action:@selector(editDoneAction:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _editDone;
}
- (void)editDoneAction:(UIButton *)sender {
    [self endEditing:true];
    if (_selectTable) {
        [self.selectTable removeFromSuperview];
        self.selectTable = nil;
    }
    if (self.input.text.length==0) return;
    if(_textChanged && !_ignoreInput) {
        _textChanged([[InputRow alloc]initWith:self.input.text withV:@""]);
        self.input.text = @"";
    }
}
- (void)setSelectDatas:(NSArray<InputRow *> *)selectDatas {
    _selectDatas = selectDatas;
    _searchRows = selectDatas;
}
- (void)setInputNumber:(BOOL)inputNumber {
    _inputNumber = inputNumber;
    self.input.keyboardType = _inputNumber ? UIKeyboardTypeDecimalPad : UIKeyboardTypeDefault;
}

/// 开始编辑
- (IBAction)beginEdit:(UITextField *)sender {
    if(_searchRows.count==0) return;
    [[[[UIApplication sharedApplication] keyWindow] viewWithTag:999999991] removeFromSuperview];
    [[[UIApplication sharedApplication] keyWindow] addSubview:self.selectTable];
}
/// 编辑结束
- (IBAction)textChange:(UITextField *)sender {
    NSString *text = sender.text?:@"";
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        self->_searchRows = [weakSelf.selectDatas filter:^BOOL(InputRow *obj) {
            if (text.length==0) return true;
            else return [obj.show containsString:text];
        }];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.selectTable reloadData];
        });
    });
}
/// 编辑结束
- (IBAction)textEnd:(UITextField *)sender {
    double delayInSeconds = 0.25;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        if (self->_selectTable && sender.text.length==0) {
            [self.selectTable removeFromSuperview];
            self.selectTable = nil;
        }
    });

}

@end



#pragma mark - table
@interface InputFooter (Table) <UITableViewDelegate,UITableViewDataSource> @end
@implementation InputFooter (Table)
- (UITableView *)selectTable {
    if (!_selectTable) {
        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
        CGRect rect = [self convertRect: self.bounds toView:keyWindow];
        _selectTable = [[UITableView alloc] initWithFrame:CGRectMake(rect.origin.x/1.7,rect.origin.y-120,self.frame.size.width*1.7, 130)];
        _selectTable.delegate = self;
        _selectTable.dataSource = self;
        _selectTable.tag = 99999999;
    }
    return _selectTable;
}
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"cell"];
    }
    cell.textLabel.lineBreakMode = NSLineBreakByTruncatingHead;
    cell.textLabel.text = _searchRows[indexPath.row].show;
    return cell;
}
- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _searchRows.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _input.text = @"";
    if(_textChanged) _textChanged(_searchRows[indexPath.row]);
    if (_selectTable) {
        [self.selectTable removeFromSuperview];
        self.selectTable = nil;
    }
}
@end
