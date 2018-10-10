//
//  UIView+ACSLayer.h
//  ACSUIKit
//
//  Created by wang on 2018/4/25.
//  Copyright © 2018年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ACSBorderSideType) {
    ACSBorderSideTypeAll = 0,
    ACSBorderSideTypeTop = 1 << 0,
    ACSBorderSideTypeBottom = 1 << 1,
    ACSBorderSideTypeLeft = 1 << 2,
    ACSBorderSideTypeRight = 1 << 3,
};

@interface UIView (ACSLayer)

/**
 圆角
 建议部分圆角使用
 
 @param radius 圆角尺寸
 @param corner 圆角位置
 */
- (void)acs_radiusWithRadius:(CGFloat)radius corner:(UIRectCorner)corner;

/**
 阴影 (兼容圆角)
 需要先加入到父视图
 
 @param color  颜色
 @param radius 尺寸
 @param offset 偏移位置
 @param shadowOpacity 透明度
 */
- (void)acs_shadowWithColor:(UIColor *)color radius:(CGFloat)radius offset:(CGSize)offset shadowOpacity:(CGFloat)shadowOpacity;

/**
 添加边框
 @param color  颜色
 @param borderWidth 宽度
 @param borderType 边框位置
 */
- (void)acs_borderForColor:(UIColor *)color borderWidth:(CGFloat)borderWidth borderType:(ACSBorderSideType)borderType;

@end
