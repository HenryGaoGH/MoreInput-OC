//
//  InputItem.m
//  ABIVPOiOS
//
//  Created by Henry Gao on 2020/12/14.
//  Copyright © 2020 zhangjiacheng. All rights reserved.
//

#import "InputItem.h"

@interface InputItem()
@property (weak, nonatomic) IBOutlet UITextField *input;
@end

@implementation InputItem
- (void)setCanEdit:(BOOL)canEdit {
    _canEdit = canEdit;
    _input.enabled = _canEdit;
}
- (void)setItem:(InputRow *)item {
    _item = item;
    _input.text = _item.show;
    [self editStyle:false btn:_input];
}
/// 开始输入的时候
/// @param sender textF
- (IBAction)startEdit:(UITextField *)sender {
    [self editStyle:true btn:sender];
}
/// 结束输入的时候
/// @param sender textF
- (IBAction)endEdit:(UITextField *)sender {
    if (sender.text.length==0) return;
    [self editStyle:false btn:sender];
    if(_textChanged) _textChanged(sender.text);
}

- (void)editStyle:(BOOL)editable btn:(UITextField *)sender {//238 59 59
    sender.backgroundColor = editable ? [UIColor clearColor] : [UIColor colorWithRed:238/255 green:59/255 blue:59/255 alpha:1]; //RGBA(238,59,59,1);
    sender.textColor = editable ? [UIColor blackColor] : [UIColor whiteColor];
    sender.clipsToBounds = !editable;
    sender.layer.cornerRadius = editable ? 0 : self.frame.size.height/2;
}
@end
