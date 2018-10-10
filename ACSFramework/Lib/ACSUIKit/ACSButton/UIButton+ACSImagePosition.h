//
//  UIButton+ACSImagePosition.h
//  ACSUIKit
//
//  Created by wang on 2018/4/25.
//  Copyright © 2018年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, ACSUIButtonImagePosition) {
    ACSUIButtonImagePositionLeft, // 图片在左
    ACSUIButtonImagePositionRight, // 图片在右
    ACSUIButtonImagePositionTop, // 图片在上
    ACSUIButtonImagePositionBottom, // 图片在下
};

@interface UIButton (ACSImagePosition)

/**
 设置button 图片位置
 @param type 位置
 @param edg  偏移
 */
- (void)acs_positionWith:(ACSUIButtonImagePosition)type edg:(CGFloat)edg;

@end
