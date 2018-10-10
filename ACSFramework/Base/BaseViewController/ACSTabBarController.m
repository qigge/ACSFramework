//
//  ACSTabBarController.m
//  ACSFramework
//
//  Created by wang on 2018/6/2.
//  Copyright © 2018年 qigge. All rights reserved.
//

#import "ACSTabBarController.h"
#import "ACSNavigationController.h"

@interface ACSTabBarController ()

@end

@implementation ACSTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadControllers];
    
    self.selectedIndex = 0;
    
    self.tabBar.tintColor = [UIColor acs_hexStringToColor:@"#fd5b4e"];
}

- (void)loadControllers {
    NSMutableArray *vcs = [NSMutableArray array];
    
    NSArray *vcClassArr = @[@"ACSBaseViewController",@"ACSBaseViewController",@"ACSBaseViewController"];
    NSArray *titleArr = @[@"首页",@"发现",@"我的"];
    NSArray *imageArr = @[@"",@"",@""];
    NSArray *selectedImageArr = @[@"",@"",@""];
    [vcClassArr enumerateObjectsUsingBlock:^(NSString *classStr, NSUInteger idx, BOOL * _Nonnull stop) {
        UIViewController *controller = [[NSClassFromString(classStr) alloc] init];
        ACSNavigationController *nav = [[ACSNavigationController alloc] initWithRootViewController:controller];
        nav.tabBarItem.title = titleArr[idx];
        nav.tabBarItem.image = [[UIImage imageNamed:imageArr[idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        nav.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageArr[idx]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        //未选中字体颜色
        [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor acs_hexStringToColor:@"#717171"],NSFontAttributeName:[UIFont systemFontOfSize:10]} forState:UIControlStateNormal];
        
        //选中字体颜色
        [nav.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor acs_hexStringToColor:@"#29C0C7"],NSFontAttributeName:[UIFont systemFontOfSize:10]} forState:UIControlStateSelected];
        
        [vcs addObject:nav];
    }];
    
    self.viewControllers = vcs;
}

#pragma mark - 状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle {
    return self.selectedViewController.preferredStatusBarStyle;
}
#pragma mark - 屏幕旋转
//是否自动旋转,返回YES可以自动旋转
- (BOOL)shouldAutorotate {
    return [self.selectedViewController shouldAutorotate];
}
//返回支持的方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.selectedViewController supportedInterfaceOrientations];
}
//这个是返回优先方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self.selectedViewController preferredInterfaceOrientationForPresentation];
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
