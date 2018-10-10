//
//  ACSTableViewController.h
//  ACSFramework
//
//  Created by wang on 2018/7/25.
//  Copyright © 2018年 qigge. All rights reserved.
//

#import "ACSBaseViewController.h"

#import "UIScrollView+ACSEmpty.h"

@interface ACSTableViewController : ACSBaseViewController

/** TableView的样式 */
@property (nonatomic, assign) UITableViewStyle tableStyle;

/** 下拉刷新开关 */
- (BOOL)shouldHeaderRefresh;

/** 上拉加载开关 */
- (BOOL)shouldFooterRefresh;

/** 下拉刷新执行的方法 */
- (void)handlePullRefresh;

/** 上拉加载执行的方法 */
- (void)handleInfiniteScrolling;

/** 关闭头部刷新 */
- (void)endHeadRefresh;

/** 关闭尾部刷新 */
- (void)endFootRefresh;


@end
