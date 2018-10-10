//
//  NSString+ACSSize.h
//  ACSUIKit
//
//  Created by wang on 2018/4/25.
//  Copyright © 2018年 wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (ACSSize)

/**
 固定高度，根据内容计算UILabel的宽度
 @param aHeight 高度
 @param aFont 字体大小
 @return 宽度
 */
- (CGFloat)acs_getWidthWithFixedHeight:(CGFloat)aHeight font:(UIFont *)aFont;
/**
 固定宽度，根据内容计算UILabel的高度
 @param aWidth 高度
 @param aFont 字体大小
 @return 高度
 */
- (CGFloat)acs_getHeightWithFixedWidth:(CGFloat)aWidth font:(UIFont *)aFont;

@end
