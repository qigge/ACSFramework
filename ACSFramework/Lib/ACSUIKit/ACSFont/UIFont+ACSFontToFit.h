//
//  UIFont+ACSFontToFit.h
//  ACSFramework
//
//  Created by wang on 2018/5/31.
//  Copyright © 2018年 qigge. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 根据屏幕尺寸计算字体大小
 默认设计尺寸为宽度为375，若不是请修改.m中（#define MyUIScreenWidth  375）
 */
@interface UIFont (ACSFontToFit)

@end


/**
 XIB和SB中UIButton字号适配
 */
@interface UIButton (ACSFontToFit)

@end

/**
 XIB和SB中UILabel字号适配
 */
@interface UILabel (ACSFontToFit)

@end

/**
 XIB和SB中UITextField字号适配
 */
@interface UITextField (ACSFontToFit)

@end

/**
 XIB和SB中UITextView字号适配
 */
@interface UITextView (ACSFontToFit)

@end
