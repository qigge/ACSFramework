//
//  ACSErrorView.h
//  ACSFramework
//
//  Created by wang on 2018/6/19.
//  Copyright © 2018年 qigge. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ACSErrorViewType) {
    ACSErrorViewTypeServer,
    ACSErrorViewTypeNetwork,
    ACSErrorViewTypeEmpty,
};

@interface ACSErrorView : UIView

/** 使用错误状态初始化 */
- (instancetype)initWithFrame:(CGRect)frame type:(ACSErrorViewType)type;

/**
 刷新的Block
 type 为 TMErrorViewTypeEmpty 不可用
 */
@property (nonatomic, copy) void (^refreshBlock)(void);

@end
