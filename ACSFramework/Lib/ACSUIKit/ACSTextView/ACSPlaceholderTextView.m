//
//  ACSPlaceholderTextView.m
//  ACSUIKit
//
//  Created by wang on 2018/4/25.
//  Copyright © 2018年 wang. All rights reserved.
//

#import "ACSPlaceholderTextView.h"


@implementation ACSPlaceholderTextView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _maxLenght = 0;
        _placeholderColor = [UIColor lightGrayColor];
        
        // 使用通知监听文字改变
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acs_textViewTextDicChange) name:UITextViewTextDidChangeNotification object:self];
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    _maxLenght = 0;
    _placeholderColor = [UIColor lightGrayColor];

    // 使用通知监听文字改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(acs_textViewTextDicChange) name:UITextViewTextDidChangeNotification object:self];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    // 如果有文字，就直接返回，不需要画占位文字
    if (self.hasText) return;
    
    // 属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor;
    
    // 画文字
    rect.origin.x = 5;
    rect.origin.y = 8;
    rect.size.width -= 2 * rect.origin.x;
    [self.placeholder drawInRect:rect withAttributes:attrs];
}

-(void)setText:(NSString *)text {
    [super setText:text];
    [self setNeedsDisplay];
}


- (void)acs_textViewTextDicChange {
    [self setNeedsDisplay];
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
