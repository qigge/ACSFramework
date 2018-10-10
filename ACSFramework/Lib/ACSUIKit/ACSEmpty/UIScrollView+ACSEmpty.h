//
//  UIScrollView+ACSEmpty.h
//  ACSUIKit
//
//  Created by wang on 2018/4/25.
//  Copyright © 2018年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (ACSEmpty)

/** 空视图（tableview，colloctionview 为空时，显示此视图） */
@property (nonatomic, strong) UIView *acs_emptyView;

@end
