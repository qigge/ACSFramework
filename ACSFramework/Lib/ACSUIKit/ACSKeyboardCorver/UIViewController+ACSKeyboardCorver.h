//
//  UIViewController+ACSKeyboardCorver.h
//  ACSUIKit
//
//  Created by wang on 2018/4/18.
//  Copyright © 2018年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ACSKeyboardCorver)<UIGestureRecognizerDelegate>


/**
 隐藏键盘的手势
 */
@property (nonatomic, strong) UITapGestureRecognizer *hideKeyBoardGr;

/**
 添加键盘通知
 */
- (void)acs_addKeyboardCorverNotification;

/**
 清理通知和移除手势 在控制器的dealloc中记得要释放
 */
- (void)acs_clearNotificationAndGesture;

@end
