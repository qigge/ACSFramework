//
//  ACSTapsView.h
//  ACSUIKit
//
//  Created by wang on 2018/4/25.
//  Copyright © 2018年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ACSTapsViewDelegate <NSObject>

@optional
- (void)acs_tapsViewSelectedIndex:(NSInteger)index;

@end

/** 选项卡TapView */
@interface ACSTapsView : UIView

/** 选中的序号 (0开始 ） */
@property (nonatomic, assign) NSInteger index;
/** 默认颜色 */
@property (nonatomic, strong) UIColor *defaultColor;
/** 选中的颜色（默认red） */
@property (nonatomic, strong) UIColor *selectedColor;
/** 按钮字体 默认常规17 */
@property (nonatomic, strong) UIFont *btnFont;
/** 选择按钮字体 默认粗体17 */
@property (nonatomic, strong) UIFont *btnSelectFont;
/** 是否展示下滑的View */
@property (nonatomic, assign) BOOL showLineView;

/**
 标题数组（设置这个重新更新标题）
 
 先设置好前面的属性后，再设置次属性
 */
@property (nonatomic, strong)  NSArray<NSString *> *dataArr;

@property (nonatomic, weak) id<ACSTapsViewDelegate> delegate;

@end
