//
//  UIView+ACSLayer.m
//  ACSUIKit
//
//  Created by wang on 2018/4/25.
//  Copyright © 2018年 wang. All rights reserved.
//

#import "UIView+ACSLayer.h"

@implementation UIView (ACSLayer)

- (void)acs_radiusWithRadius:(CGFloat)radius corner:(UIRectCorner)corner {
    if (@available(iOS 11.0, *)) {
        self.layer.cornerRadius = radius;
        self.layer.maskedCorners = (CACornerMask)corner;
        if ([self isKindOfClass:[UILabel class]]) {
            self.layer.masksToBounds = YES;
        }
    } else {
        [self layoutIfNeeded]; // 解决使用自动布局，获取bounds为0的情况
        UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corner cornerRadii:CGSizeMake(radius, radius)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.bounds;
        maskLayer.path = path.CGPath;
        self.layer.mask = maskLayer;
    }
}

- (void)acs_shadowWithColor:(UIColor *)color radius:(CGFloat)radius offset:(CGSize)offset shadowOpacity:(CGFloat)shadowOpacity{
//    if (@available(iOS 11.0, *)) {
//        self.layer.shadowColor = color.CGColor;
//        self.layer.shadowOffset = offset;
//        self.layer.shadowRadius = radius;
//        self.layer.shadowOpacity = shadowOpacity;
//    } else {
        [self.superview layoutIfNeeded]; // 解决使用自动布局，获取bounds为0的情况
        CALayer *shadowLayer = [CALayer layer];
        shadowLayer.frame = self.frame;
        shadowLayer.shadowColor = color.CGColor;
        shadowLayer.shadowOffset = offset;
        shadowLayer.shadowRadius = radius;
        shadowLayer.shadowOpacity = shadowOpacity;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
        shadowLayer.shadowPath = path.CGPath;
        [self.superview.layer insertSublayer:shadowLayer below:self.layer];
//    }
}

- (void)acs_borderForColor:(UIColor *)color borderWidth:(CGFloat)borderWidth borderType:(ACSBorderSideType)borderType {
    if (borderType == ACSBorderSideTypeAll) {
        self.layer.borderWidth = borderWidth;
        self.layer.borderColor = color.CGColor;
        return;
    }
    [self layoutIfNeeded]; // 解决使用自动布局，获取bounds为0的情况
    
    /// 线的路径
    UIBezierPath * bezierPath = [UIBezierPath bezierPath];
    
    /// 左侧
    if (borderType & ACSBorderSideTypeLeft) {
        /// 左侧线路径
        [bezierPath moveToPoint:CGPointMake(0.f, 0.f)];
        [bezierPath addLineToPoint:CGPointMake(0.0f, self.frame.size.height)];
    }
    /// 右侧
    if (borderType & ACSBorderSideTypeRight) {
        /// 右侧线路径
        [bezierPath moveToPoint:CGPointMake(self.frame.size.width, 0.0f)];
        [bezierPath addLineToPoint:CGPointMake( self.frame.size.width, self.frame.size.height)];
    }
    /// top
    if (borderType & ACSBorderSideTypeTop) {
        /// top线路径
        [bezierPath moveToPoint:CGPointMake(0.0f, 0.0f)];
        [bezierPath addLineToPoint:CGPointMake(self.frame.size.width, 0.0f)];
    }
    /// bottom
    if (borderType & ACSBorderSideTypeBottom) {
        /// bottom线路径
        [bezierPath moveToPoint:CGPointMake(0.0f, self.frame.size.height)];
        [bezierPath addLineToPoint:CGPointMake( self.frame.size.width, self.frame.size.height)];
    }
    CAShapeLayer * shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = color.CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    /// 添加路径
    shapeLayer.path = bezierPath.CGPath;
    /// 线宽度
    shapeLayer.lineWidth = borderWidth;
    [self.layer addSublayer:shapeLayer];
}
@end
