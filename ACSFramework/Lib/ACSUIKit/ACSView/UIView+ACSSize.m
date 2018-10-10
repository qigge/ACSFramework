//
//  UIView+ACSSize.m
//  ACSUIKit
//
//  Created by wang on 2018/4/18.
//  Copyright © 2018年 wang. All rights reserved.
//

#import "UIView+ACSSize.h"

@implementation UIView (ACSSize)

#pragma mark - public method
- (BOOL)acs_isDisplayedInScreen {
    if (self == nil) {
        return FALSE;
    }
    CGRect screenRect = [UIScreen mainScreen].bounds;
    
    // 转换view对应window的Rect
    CGRect rect = [self convertRect:self.frame fromView:nil];
    if (CGRectIsEmpty(rect) || CGRectIsNull(rect)) {
        return FALSE;
    }
    
    // 若view 隐藏
    if (self.hidden) {
        return FALSE;
    }
    
    // 若没有superview
    if (self.superview == nil) {
        return FALSE;
    }
    
    // 若size为CGrectZero
    if (CGSizeEqualToSize(rect.size, CGSizeZero)) {
        return  FALSE;
    }
    
    // 获取 该view与window 交叉的 Rect
    CGRect intersectionRect = CGRectIntersection(rect, screenRect);
    if (CGRectIsEmpty(intersectionRect) || CGRectIsNull(intersectionRect)) {
        return FALSE;
    }
    
    return TRUE;
}

#pragma mark - x

- (void)setAcs_x:(CGFloat)acs_x {
    CGRect frame = self.frame;
    frame.origin.x = acs_x;
    self.frame = frame;
}

- (CGFloat)acs_x {
    return self.frame.origin.x;
}

#pragma mark - y

- (void)setAcs_y:(CGFloat)acs_y {
    CGRect frame = self.frame;
    frame.origin.y = acs_y;
    self.frame = frame;
}

- (CGFloat)acs_y {
    return self.frame.origin.y;
}

#pragma mark - centerX

- (void)setAcs_centerX:(CGFloat)acs_centerX {
    CGPoint center = self.center;
    center.x = acs_centerX;
    self.center = center;
}

- (CGFloat)acs_centerX {
    return self.center.x;
}

#pragma mark - centerY

- (void)setAcs_centerY:(CGFloat)acs_centerY {
    CGPoint center = self.center;
    center.y = acs_centerY;
    self.center = center;
}

- (CGFloat)acs_centerY {
    return self.center.y;
}

#pragma mark - left

- (void)setAcs_left:(CGFloat)acs_left {
    CGRect frame = self.frame;
    frame.origin.x = acs_left;
    self.frame = frame;
}

- (CGFloat)acs_left {
    return self.frame.origin.x;
}

#pragma mark - right

- (void)setAcs_right:(CGFloat)acs_right {
    CGRect frame = self.frame;
    frame.origin.x = acs_right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)acs_right {
    return self.frame.origin.x + self.frame.size.width;
}

#pragma mark - top

- (void)setAcs_top:(CGFloat)acs_top {
    CGRect frame = self.frame;
    frame.origin.y = acs_top;
    self.frame = frame;
}

- (CGFloat)acs_top {
    return self.frame.origin.y;
}

#pragma mark - bottom

- (void)setAcs_bottom:(CGFloat)acs_bottom {
    CGRect frame = self.frame;
    frame.origin.y = acs_bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)acs_bottom {
    return self.frame.origin.y + self.frame.size.height;
}

#pragma mark - width

- (void)setAcs_width:(CGFloat)acs_width {
    CGRect frame = self.frame;
    frame.size.width = acs_width;
    self.frame = frame;
}

- (CGFloat)acs_width {
    return self.frame.size.width;
}

#pragma mark - height

- (void)setAcs_height:(CGFloat)acs_height {
    CGRect frame = self.frame;
    frame.size.height = acs_height;
    self.frame = frame;
}

- (CGFloat)acs_height {
    return self.frame.size.height;
}

#pragma mark - origin

- (void)setAcs_origin:(CGPoint)acs_origin {
    CGRect frame = self.frame;
    frame.origin = acs_origin;
    self.frame = frame;
}

- (CGPoint)acs_origin {
    return self.frame.origin;
}

#pragma mark - size

- (void)setAcs_size:(CGSize)acs_size {
    CGRect frame = self.frame;
    frame.size = acs_size;
    self.frame = frame;
}

- (CGSize)acs_size {
    return self.frame.size;
}

#pragma mark - add

- (void)acs_topAdd:(CGFloat)add {
    CGRect frame = self.frame;
    frame.origin.y += add;
    self.frame = frame;
}

- (void)acs_leftAdd:(CGFloat)add {
    CGRect frame = self.frame;
    frame.origin.x += add;
    self.frame = frame;
}

- (void)acs_widthAdd:(CGFloat)add {
    CGRect frame = self.frame;
    frame.size.width += add;
    self.frame = frame;
}

- (void)acs_heightAdd:(CGFloat)add {
    CGRect frame = self.frame;
    frame.size.height += add;
    self.frame = frame;
}

#pragma mark - align

- (void)acs_alignHorizontal {
    self.acs_x = (self.superview.acs_width - self.acs_width) * 0.5;
}

- (void)acs_alignVertical {
    self.acs_y = (self.superview.acs_height - self.acs_height) * 0.5;
}

@end
