//
//  ACSNavigationController.m
//  ACSFramework
//
//  Created by wang on 2018/6/2.
//  Copyright © 2018年 qigge. All rights reserved.
//

#import "ACSNavigationController.h"
#import "ACSBaseViewController.h"

@interface ACSNavigationController ()<UINavigationControllerDelegate>

@end

@implementation ACSNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /*设置navigationbar的颜色*/
    self.navigationBar.barTintColor = [UIColor whiteColor];
    /*设置statusbar的字体颜色*/
    self.navigationBar.barStyle = UIBarStyleDefault;
    
    // 设置导航栏标题字体颜色和大小
    NSDictionary *fontDict = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor  blackColor],NSForegroundColorAttributeName, [UIFont systemFontOfSize:19],NSFontAttributeName,nil];
    self.navigationBar.titleTextAttributes = fontDict;
}


#pragma mark - Public method
- (void)acs_navigationBackgroundTranslucent:(BOOL)translucent {
    if (translucent) {
        //设置导航栏背景图片为一个空的image，这样就透明了
        [self.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        //去掉透明后导航栏下边的黑边
        [self.navigationBar setShadowImage:[[UIImage alloc] init]];
    }else {
        //    如果不想让其他页面的导航栏变为透明 需要重置
        [self.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
        [self.navigationBar setShadowImage:nil];
    }
}
#pragma mark - 状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.topViewController.preferredStatusBarStyle;
}

#pragma mark - 屏幕旋转
//是否自动旋转,返回YES可以自动旋转
- (BOOL)shouldAutorotate {
    return [self.topViewController shouldAutorotate];
}
//返回支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.topViewController supportedInterfaceOrientations];
}
//这个是返回优先方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self.topViewController preferredInterfaceOrientationForPresentation];
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if ([viewController isKindOfClass:[ACSBaseViewController class]]) {
        ACSBaseViewController * vc = (ACSBaseViewController *)viewController;
        if (vc.isHidenNaviBar) {
            vc.view.acs_top = 0;
            [vc.navigationController setNavigationBarHidden:YES animated:animated];
        } else {
            vc.view.acs_top = mTopHeight;
            [vc.navigationController setNavigationBarHidden:NO animated:animated];
        }
    }
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
