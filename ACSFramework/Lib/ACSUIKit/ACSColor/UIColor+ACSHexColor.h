//
//  UIColor+ACSHexColor.h
//  ACSUIKit
//
//  Created by wang on 2018/4/18.
//  Copyright © 2018年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ACSHexColor)

/**
 根据十六进制色值返回颜色
 
 @param stringToConvert 十六进制色值
 @return 系统颜色
 */
+ (UIColor *)acs_hexStringToColor:(NSString *)stringToConvert;


/**
 根据十六进制色值和透明度返回颜色
 
 @param stringToConvert 十六进制色值
 @param alpha 透明度
 @return 系统颜色
 */
+ (UIColor *)acs_hexStringToColor:(NSString *)stringToConvert alpha:(CGFloat)alpha;

@end
