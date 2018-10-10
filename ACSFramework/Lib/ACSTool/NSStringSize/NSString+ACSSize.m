//
//  NSString+ACSSize.m
//  ACSUIKit
//
//  Created by wang on 2018/4/25.
//  Copyright © 2018年 wang. All rights reserved.
//

#import "NSString+ACSSize.h"

@implementation NSString (ACSSize)

/**
 固定宽度，根据内容计算UILabel的高度
 */
- (CGFloat)acs_getHeightWithFixedWidth:(CGFloat)aWidth font:(UIFont *)aFont {
    
    CGSize constranitSize = CGSizeMake(aWidth, MAXFLOAT);
    NSDictionary *dic = @{NSFontAttributeName : aFont};
    CGSize labelSize = [self boundingRectWithSize:constranitSize
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:dic
                                          context:nil].size;
    return labelSize.height;
}

/**
 固定高度，根据内容计算UILabel的宽度
 */
- (CGFloat)acs_getWidthWithFixedHeight:(CGFloat)aHeight font:(UIFont *)aFont {
    
    CGSize constranitSize = CGSizeMake(MAXFLOAT, aHeight);
    NSDictionary *dic = @{NSFontAttributeName : aFont}; // 获取该段attributedString的属性字典
    
    CGSize labelSize = [self boundingRectWithSize:constranitSize
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:dic
                                          context:nil].size;
    return labelSize.width;
}


@end
