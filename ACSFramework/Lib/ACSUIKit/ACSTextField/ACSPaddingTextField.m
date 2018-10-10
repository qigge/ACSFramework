//
//  ACSPaddingTextField.m
//  ACSUIKit
//
//  Created by wang on 2018/4/25.
//  Copyright © 2018年 wang. All rights reserved.
//

#import "ACSPaddingTextField.h"

@implementation ACSPaddingTextField


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _maxLenght = 0;
        _edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        // 使用通知监听文字改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acs_textViewTextDicChange) name:UITextFieldTextDidChangeNotification object:nil];
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect rect = [super textRectForBounds:bounds];
    //根据edgeInsets，修改绘制文字的bounds
    rect.origin.x += self.edgeInsets.left;
    rect.origin.y += self.edgeInsets.top;
    rect.size.width -= self.edgeInsets.left + self.edgeInsets.right;
    rect.size.height -= self.edgeInsets.top + self.edgeInsets.bottom;
    return rect;
}
- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect rect = [super editingRectForBounds:bounds];
    //根据edgeInsets，修改绘制文字的bounds
    rect.origin.x += self.edgeInsets.left;
    rect.origin.y += self.edgeInsets.top;
    rect.size.width -= self.edgeInsets.left + self.edgeInsets.right;
    rect.size.height -= self.edgeInsets.top + self.edgeInsets.bottom;
    return rect;
}

- (void)drawTextInRect:(CGRect)rect {
    //令绘制区域为原始区域，增加的内边距区域不绘制
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.edgeInsets)];
}

- (void)acs_textViewTextDicChange {
    
    if (self.maxLenght == 0 ) {
        return;
    }
    
    NSString *lang = [[[UITextInputMode activeInputModes] firstObject] primaryLanguage];//当前的输入模式
    if ([lang isEqualToString:@"zh-Hans"]) {
        UITextRange *range = [self markedTextRange];
        UITextPosition *start = range.start;
        UITextPosition*end = range.end;
        NSInteger selectLength = [self offsetFromPosition:start toPosition:end];
        NSInteger contentLength = self.text.length - selectLength;
        
        if (contentLength > self.maxLenght) {
            self.text = [self.text substringToIndex:self.maxLenght];
            if (_maxBlock) {
                _maxBlock();
            }
        }
    }
    else {
        if (self.text.length > self.maxLenght) {
            self.text = [self.text substringToIndex:self.maxLenght];
            if (_maxBlock) {
                _maxBlock();
            }
        }
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
