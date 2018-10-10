//
//  UIView+ACSSize.h
//  ACSUIKit
//
//  Created by wang on 2018/4/18.
//  Copyright © 2018年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ACSSize)

@property (nonatomic, assign) CGFloat acs_x;
@property (nonatomic, assign) CGFloat acs_y;
@property (nonatomic, assign) CGFloat acs_centerX;
@property (nonatomic, assign) CGFloat acs_centerY;

@property (nonatomic, assign) CGFloat acs_left;
@property (nonatomic, assign) CGFloat acs_top;
@property (nonatomic, assign) CGFloat acs_right;
@property (nonatomic, assign) CGFloat acs_bottom;

@property (nonatomic, assign) CGFloat acs_width;
@property (nonatomic, assign) CGFloat acs_height;
@property (nonatomic, assign) CGPoint acs_origin;
@property (nonatomic, assign) CGSize  acs_size;

- (void)acs_topAdd:(CGFloat)add;
- (void)acs_leftAdd:(CGFloat)add;
- (void)acs_widthAdd:(CGFloat)add;
- (void)acs_heightAdd:(CGFloat)add;

/**
 判断View是否显示在屏幕上
 
 @return YES/NO
 */
- (BOOL)acs_isDisplayedInScreen;

/**
 水平居中
 */
- (void)acs_alignHorizontal;

/**
 水平居中
 */
- (void)acs_alignVertical;

@end

