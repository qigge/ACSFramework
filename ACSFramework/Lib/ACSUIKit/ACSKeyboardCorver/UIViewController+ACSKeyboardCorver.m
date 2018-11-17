//
//  UIViewController+ACSKeyboardCorver.m
//  ACSUIKit
//
//  Created by wang on 2018/4/18.
//  Copyright © 2018年 wang. All rights reserved.
//

#import "UIViewController+ACSKeyboardCorver.h"

#import <objc/runtime.h>

char acsHideKeyBoardGrKey;

@implementation UIViewController (ACSKeyboardCorver)

#pragma mark - Getters &Setter
- (UITapGestureRecognizer *)hideKeyBoardGr {
    return objc_getAssociatedObject(self, &acsHideKeyBoardGrKey);
}
- (void)setHideKeyBoardGr:(UITapGestureRecognizer *)hideKeyBoardGr {
    objc_setAssociatedObject(self, &acsHideKeyBoardGrKey, hideKeyBoardGr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - public method
// 添加键盘通知 和手势
- (void)acs_addKeyboardCorverNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotify:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardNotify:) name:UIKeyboardWillHideNotification object:nil];
    
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(p_acs_tapGestureHandel)];
    tapGr.delegate = self;
    [self.view addGestureRecognizer:tapGr];
    self.hideKeyBoardGr = tapGr;
}

// 清理通知和移除手势
- (void)acs_clearNotificationAndGesture {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}


#pragma mark - UIGestureRecognizerDelegate

// 手势代理方法
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    // 判断如果点击的View是UICollectionView就可以执行手势方法，否则不执行
    UIView *view = touch.view;
    while (view) {
        if ([view isKindOfClass:[UITableView class]] ||
            [view isKindOfClass:[UICollectionView class]] ||
            [view isKindOfClass:[UITableViewCell class]] ||
            [view isKindOfClass:[UICollectionViewCell class]] ) {
            return NO;
        }else {
            view = view.superview;
        }
    }
    return YES;
}

#pragma mark - 单击手势调用
- (void)p_acs_tapGestureHandel{
    [[UIApplication sharedApplication].delegate.window endEditing:YES];
}

#pragma mark - 查找第一响应者
- (UIView *)p_acs_findFirstResponse:(UIView *)view{
    UIView * ojView =nil;
    for (UIView * tempView in view.subviews) {
        if ([tempView isKindOfClass:[UITextField class]] ||
            [tempView isKindOfClass:[UITextView class]]) {//要进行类型判断
            if ([tempView isFirstResponder]) {
                ojView = tempView;
                break;
            }
        }else {
            if (!ojView && tempView.subviews.count != 0) {
                ojView = [self p_acs_findFirstResponse:tempView];
            }
        }
    }
    return ojView;
}

#pragma mark - 键盘通知接收处理
- (void)keyboardNotify:(NSNotification *)notify{
    
    NSValue * frameNum = [notify.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect rect = frameNum.CGRectValue;
    CGFloat keyboardHeight = rect.size.height;//键盘高度
    
    CGFloat duration = [[notify.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];//获取键盘动画持续时间
    NSInteger curve = [[notify.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];//获取动画曲线
    
    if ([notify.name isEqualToString:UIKeyboardWillShowNotification]) {//键盘显示
        UIView * tempView = [self p_acs_findFirstResponse:self.view];
        CGRect rect = [tempView.superview convertRect:tempView.frame toView:self.view];//计算响应者到和屏幕的绝对位置
        CGFloat keyboardY = [UIScreen mainScreen].bounds.size.height - keyboardHeight;
        CGFloat tempViewBottom = (rect.origin.y + tempView.frame.size.height);
        if (tempViewBottom > keyboardY) {
            CGFloat offsetY;
            if ([UIScreen mainScreen].bounds.size.height - tempViewBottom < 0) {//判断是否超出了屏幕,超出屏幕做偏移纠正
                offsetY = keyboardY - tempViewBottom + (tempViewBottom-[UIScreen mainScreen].bounds.size.height);
            }else{
                offsetY = keyboardY - tempViewBottom;
            }
            if (duration > 0) {
                [UIView animateWithDuration:duration delay:0 options:curve animations:^{
                    self.view.transform = CGAffineTransformMakeTranslation(0, offsetY);
                } completion:^(BOOL finished) {
                    
                }];
            }else{
                self.view.transform = CGAffineTransformMakeTranslation(0, offsetY);
            }
        }
    }else if ([notify.name isEqualToString:UIKeyboardWillHideNotification]){//键盘隐藏
        if (duration > 0) {
            [UIView animateWithDuration:duration delay:0 options:curve animations:^{
                self.view.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                
            }];
        }else{
            self.view.transform = CGAffineTransformIdentity;
        }
    }
}


@end
