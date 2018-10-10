//
//  ACSTableViewController.m
//  ACSFramework
//
//  Created by wang on 2018/7/25.
//  Copyright © 2018年 qigge. All rights reserved.
//

#import "ACSTableViewController.h"

#import <MJRefresh.h>

@interface ACSTableViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *baseTableView;

@end

@implementation ACSTableViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tableStyle = UITableViewStylePlain;
    }
    return self;
}

- (void)loadView {
    [super loadView];
    
    if (![self.view.subviews containsObject:self.baseTableView]) {
        [self.view addSubview:self.baseTableView];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (@available(iOS 11.0, *)) {
        self.baseTableView.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
    }
    [self setBaseTableViewUI];
}

/** 公有方法 */
#pragma mark - public Methods

/** 默认关闭下拉刷新 */

- (BOOL)shouldHeaderRefresh{
    return NO;
}

/** 默认关闭上拉加载 */
- (BOOL)shouldFooterRefresh {
    return NO;
}
/** pull hide navigationBar setting */
- (BOOL)shouldHideNavigationBarPullDown {
    return NO;
}

/** 下拉刷新 */
- (void)handlePullRefresh {
    // 方法由子类重写
}

/** 上拉加载 */
- (void)handleInfiniteScrolling {
    // 方法由子类去重写
}

/** 关闭头部刷新 */
- (void)endHeadRefresh {
    if ([self.baseTableView.mj_header isRefreshing]) {
        [self.baseTableView.mj_header endRefreshing];
    }
}

/** 关闭尾部刷新 */
- (void)endFootRefresh {
    if ([self.baseTableView.mj_footer isRefreshing]) {
        [self.baseTableView.mj_footer endRefreshing];
    }
}

/** 私有方法 */
#pragma mark - Private Methods

- (void)setBaseTableViewUI {
    //头部下拉刷新
    if ([self shouldHeaderRefresh]) {
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(handlePullRefresh)];

        [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
        [header setTitle:@"松开即可刷新" forState:MJRefreshStatePulling];
        [header setTitle:@"正在刷新..." forState:MJRefreshStateRefreshing];

        self.baseTableView.mj_header = header;
    }
    
    //底部上拉加载
    if ([self shouldFooterRefresh]) {
        
        MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(handleInfiniteScrolling)];
        
        [footer setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
        [footer setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
        [footer setTitle:@"松开即可加载" forState:MJRefreshStatePulling];
        [footer setTitle:@"没有更多了" forState:MJRefreshStateNoMoreData];
        
        self.baseTableView.mj_footer = footer;
    }
}

#pragma mark - UITableViewDelegate And UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}


/** 初始化 */
#pragma mark - Getter and Setter

- (UITableView *)baseTableView {
    if (_baseTableView == nil || [_baseTableView isEqual:[NSNull null]]) {
        CGRect rectFrame = CGRectMake(0, mTopHeight, mScreenWidth, mScreenHeight - mTopHeight);
        _baseTableView = [[UITableView alloc] initWithFrame:rectFrame style:self.tableStyle];
        _baseTableView.delegate = self;
        _baseTableView.dataSource = self;
        _baseTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0.001)];
        _baseTableView.tableFooterView = view;
        _baseTableView.tableHeaderView = view;
        
        if (@available (iOS 11,*)) {
            _baseTableView.estimatedRowHeight = 0;
            _baseTableView.estimatedSectionHeaderHeight = 0;
            _baseTableView.estimatedSectionFooterHeight = 0;
            _baseTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _baseTableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
