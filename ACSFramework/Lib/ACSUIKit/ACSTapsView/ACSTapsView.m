//
//  ACSTapsView.m
//  ACSUIKit
//
//  Created by wang on 2018/4/25.
//  Copyright © 2018年 wang. All rights reserved.
//

#import "ACSTapsView.h"

@implementation ACSTapsView {
    UIView *_redLineView;
    NSArray<UIButton *> *_subBtnArr;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self initUI];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    _index = 0;
    _defaultColor = [UIColor blackColor];
    _selectedColor = [UIColor redColor];
    _btnFont = [UIFont systemFontOfSize:17];
    _btnSelectFont = [UIFont boldSystemFontOfSize:17];
    
    _redLineView = [[UIView alloc] init];
    [self addSubview:_redLineView];
}


- (void)setUI {
    for (UIView *view in _subBtnArr) {
        [view removeFromSuperview];
    }
    
    CGFloat width = _dataArr.count == 0 ?0: self.frame.size.width/_dataArr.count;
    _redLineView.frame = CGRectMake(width/2 - 49/2, self.frame.size.height - 2, width==0 ?:49, 2.0f);
    _redLineView.backgroundColor = _selectedColor;
    
    NSMutableArray *tempArr = [NSMutableArray array];
    [_dataArr enumerateObjectsUsingBlock:^(NSString * _Nonnull str, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(idx * width, 0, width, self.frame.size.height - 2);
        [btn setTitle:str forState:UIControlStateNormal];
        btn.titleLabel.font = self.btnFont;
        [btn setTitleColor:self->_defaultColor forState:UIControlStateNormal];
        [btn setTitleColor:self->_selectedColor forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        if (idx == self->_index) {
            btn.selected = YES;
            btn.titleLabel.font = self.btnSelectFont;
        }
        [tempArr addObject:btn];
    }];
    _subBtnArr = tempArr;
}

#pragma mark - Event
// 选中事件
- (void)buttonClick:(UIButton *)btn {
    self.index = [_subBtnArr indexOfObject:btn];
}

- (void)redLineViewAnimateWithFrame:(CGRect)sFrame {
    [UIView animateWithDuration:1.0f
                          delay:0.0f
         usingSpringWithDamping:0.5f
          initialSpringVelocity:0.5f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self->_redLineView.frame = sFrame;
                     }
                     completion:nil];
}
#pragma mark - Setter & Getter
- (void)setIndex:(NSInteger)index {
    _index = index;
    
    if (index < _subBtnArr.count) {
        for (UIButton *tempbtn in _subBtnArr) {
            tempbtn.selected = NO;
            tempbtn.titleLabel.font = _btnFont;
        }
        UIButton *btn = _subBtnArr[index];
        btn.titleLabel.font = _btnSelectFont;
        btn.selected = YES;
        
        CGFloat width = self.frame.size.width/_dataArr.count;
        // 移动红色的View
        CGRect redLineFrame = _redLineView.frame;
        redLineFrame.origin.x = btn.frame.origin.x + width/2 - redLineFrame.size.width/2;
        [self redLineViewAnimateWithFrame:redLineFrame];
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(acs_tapsViewSelectedIndex:)]) {
            [self.delegate acs_tapsViewSelectedIndex:index];
        }
    }
}
- (void)setDataArr:(NSArray *)dataArr {
    _dataArr = dataArr;
    [self setUI];
}

//- (void)setDefaultColor:(UIColor *)defaultColor {
//    _defaultColor = defaultColor;
//    for (UIButton *tempbtn in _subBtnArr) {
//        [tempbtn setTitleColor:_defaultColor forState:UIControlStateNormal];
//    }
//}
//- (void)setSelectedColor:(UIColor *)selectedColor {
//    _selectedColor = selectedColor;
//    for (UIButton *tempbtn in _subBtnArr) {
//        [tempbtn setTitleColor:_selectedColor forState:UIControlStateSelected];
//    }
//    _redLineView.backgroundColor = _selectedColor;
//}
//
//- (void)setBtnFont:(UIFont *)btnFont {
//    _btnFont = btnFont;
//    for (UIButton *tempbtn in _subBtnArr) {
//        tempbtn.titleLabel.font = btnFont;
//    }
//    if (self.index < _subBtnArr.count) {
//        UIButton *btn = _subBtnArr[self.index];
//        btn.titleLabel.font = _btnSelectFont;
//    }
//}
//
//- (void)setBtnSelectFont:(UIFont *)btnSelectFont {
//    _btnSelectFont = btnSelectFont;
//    if (self.index < _subBtnArr.count) {
//        UIButton *btn = _subBtnArr[self.index];
//        btn.titleLabel.font = _btnSelectFont;
//    }
//}


@end
