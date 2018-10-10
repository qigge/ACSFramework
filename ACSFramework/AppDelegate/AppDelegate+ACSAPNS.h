//
//  AppDelegate+ACSAPNS.h
//  ACSFramework
//
//  Created by wang on 2018/6/1.
//  Copyright © 2018年 qigge. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>

@interface AppDelegate (ACSAPNS)<UNUserNotificationCenterDelegate>

/** 注册推送（第三方等） */
- (void)acs_registerAPNSWithApplication:(UIApplication *)application launchOptions:(NSDictionary *)launchOptions;

@end
