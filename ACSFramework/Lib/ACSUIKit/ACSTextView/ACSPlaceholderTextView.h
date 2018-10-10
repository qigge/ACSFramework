//
//  ACSPlaceholderTextView.h
//  ACSUIKit
//
//  Created by wang on 2018/4/25.
//  Copyright © 2018年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 拥有占位文字(placeholder)的UITextView
 BUG： 在iOS 8上会有偏移，可以滑动
 */
@interface ACSPlaceholderTextView : UITextView

/** 占位文字 */
@property (nonatomic, copy) NSString *placeholder;

/** 占位文字颜色 默认 lightGrayColor */
@property (nonatomic, strong) UIColor *placeholderColor;

/** 输入最长字符 */
@property (nonatomic, assign) NSInteger maxLenght;

/** 输入超过长度回调 */
@property (nonatomic, copy) void(^maxBlock)(void);

@end
