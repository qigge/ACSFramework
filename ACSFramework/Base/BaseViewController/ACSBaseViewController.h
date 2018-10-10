//
//  BaseViewController.h
//  ACSFramework
//
//  Created by wang on 2018/2/10.
//  Copyright © 2018年 qigge. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ACSErrorView.h"

@interface ACSBaseViewController : UIViewController

#pragma mark - UI设置
/** 是否隐藏导航栏,默认情况是NO */
@property (nonatomic, assign) BOOL isHidenNaviBar;

#pragma mark - 需重写
/**
 搭建UI，需重写
 */
- (void)acs_setUI;
/**
 rac数据绑定，需重写
 */
- (void)acs_racBind;
/**
 页面获取数据，需重写
 */
- (void)acs_getData;

#pragma mark - 页面显示信息
/** 开始加载 */
- (void)startLodingWithTitle:(NSString *)title;
/** 结束加载 */
- (void)stopLoading;

/**
 显示错误页面
 @param type 错误类型
 @param block 刷新回掉
 */
- (void)showErrorViewWithType:(ACSErrorViewType)type refreshBlock:(void (^)(void))block;

/** 自定义返回 */
- (void)popToBack;

@end
