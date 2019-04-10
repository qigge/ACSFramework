//
//  AppDelegate.m
//  ZQFramework
//
//  Created by wang on 2017/12/20.
//  Copyright © 2017年 qigge. All rights reserved.
//

#import "AppDelegate.h"
#import "ACSTabBarController.h"
#import "AppDelegate+ACSAPNS.h"
#import "AppDelegate+ACSNetWorkReachability.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[ACSTabBarController alloc] init];
    [self.window makeKeyAndVisible];
    
//     注册推送
//    [self acs_registerAPNSWithApplication:application launchOptions:launchOptions];
    
//     注册友盟
//    [self acs_registerUmeng];
    
    // 网络状态监控
    [self acs_startNetWorkReachability];

    return YES;
}

#pragma mark - 处理分享和支付
// iOS 9以上
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    return YES;
}
// iOS 8
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return YES;
}


#pragma mark -  AppDelegate Life
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
