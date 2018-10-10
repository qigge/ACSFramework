//
//  ACSPaddingTextField.h
//  ACSUIKit
//
//  Created by wang on 2018/4/25.
//  Copyright © 2018年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 有内边距的UITextField */
@interface ACSPaddingTextField : UITextField

/** 设置内边距 */
@property (assign, nonatomic) UIEdgeInsets edgeInsets;

/** 最长字符 */
@property (nonatomic, assign) NSInteger maxLenght;

/** 超过长度回掉 */
@property (nonatomic, copy) void(^maxBlock)(void);

@end
