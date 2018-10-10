//
//  UIColor+ACSHexColor.m
//  ACSUIKit
//
//  Created by wang on 2018/4/18.
//  Copyright © 2018年 wang. All rights reserved.
//

#import "UIColor+ACSHexColor.h"

@implementation UIColor (ACSHexColor)

+ (UIColor *)acs_hexStringToColor:(NSString *)stringToConvert {
    return [UIColor p_privateHexStringToColor:stringToConvert alpha:1.0f];
}

+ (UIColor *)acs_hexStringToColor:(NSString *)stringToConvert alpha:(CGFloat)alpha {
    return [UIColor p_privateHexStringToColor:stringToConvert alpha:alpha];
}

/**
 不暴露私有方法
 */
+ (UIColor *)p_privateHexStringToColor:(NSString *)stringToConvert alpha:(CGFloat)alpha{
    NSString * cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6) {
        return [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:alpha];
    }
    
    if ([cString hasPrefix:@"0X"]) {
        cString = [cString substringFromIndex:2];
    }
    
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    
    if ([cString length] != 6) {
        return [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:alpha];
    }
    
    NSRange range;
    
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    unsigned int r, g, b;
    
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:alpha];
}


@end
