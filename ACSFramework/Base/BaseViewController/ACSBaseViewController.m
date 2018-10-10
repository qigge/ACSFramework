//
//  BaseViewController.m
//  ZQFramework
//
//  Created by wang on 2018/2/10.
//  Copyright © 2018年 qigge. All rights reserved.
//

#import "ACSBaseViewController.h"
#import "ACSLoadingView.h"
#import <UMAnalytics/MobClick.h>        // 统计组件

@interface ACSBaseViewController ()
{
    ACSLoadingView *_loadingView;
}

@end

@implementation ACSBaseViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isHidenNaviBar = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = false;
    
    if (self.navigationController.viewControllers.count > 1) {
        //设置返回按钮图片
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"icon_nav_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStyleDone target:self action:@selector(popToBack)];
        self.navigationItem.leftBarButtonItem = leftItem;
    }
    
    [self acs_setUI];
    [self acs_racBind];
    [self acs_getData];
}

/**
 搭建UI，需重写
 */
- (void)acs_setUI {}

/**
 rac数据绑定，需重写
 */
- (void)acs_racBind {}

/**
 页面获取数据，需重写
 */
- (void)acs_getData {}

#pragma mark - 友盟页面统计
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:NSStringFromClass([self class])];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [MobClick endLogPageView:NSStringFromClass([self class])];
}

#pragma mark - Public Method
/** 开始加载 */
- (void)startLodingWithTitle:(NSString *)title {
    if (!_loadingView) {
        _loadingView = [[ACSLoadingView alloc] init];
    }
    if (title) {
        _loadingView.loadingTitle.text = title;
    }
    if (![self.view.subviews containsObject:_loadingView]) {
        [self.view addSubview:_loadingView];
        [_loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
    [self.view bringSubviewToFront:_loadingView];
}

/** 结束加载 */
- (void)stopLoading {
    [_loadingView removeFromSuperview];
}

- (void)showErrorViewWithType:(ACSErrorViewType)type refreshBlock:(void (^)(void))block {
    [self stopLoading];
    
    ACSErrorView *view = [[ACSErrorView alloc] initWithFrame:self.view.bounds type:type];
    view.refreshBlock = block;
    [self.view addSubview:view];
}

/** 自定义返回 */
- (void)popToBack {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - 状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

#pragma mark - 屏幕旋转
//是否自动旋转,返回YES可以自动旋转
- (BOOL)shouldAutorotate {
    return NO;
}
//返回支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}
//这个是返回优先方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

#pragma mark - Getter & Setter

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"Dealloc -- %@",NSStringFromClass([self class]));
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
