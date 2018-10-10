//
//  AppDelegate+ACSAPNS.m
//  ACSFramework
//
//  Created by wang on 2018/6/1.
//  Copyright © 2018年 qigge. All rights reserved.
//

#import "AppDelegate+ACSAPNS.h"


@implementation AppDelegate (ACSAPNS)

- (void)acs_registerAPNSWithApplication:(UIApplication *)application launchOptions:(NSDictionary *)launchOptions{
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        // 必须写代理，不然无法监听通知的接收与点击
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                // 用户点击允许
                [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
                    
                }];
            } else {
                // 用户点击不允许
            }
        }];
    }
    else {
        //iOS8 - iOS10
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge categories:nil]];
    }
    // 注册获得device Token
    [application registerForRemoteNotifications];
}

#pragma mark - deviceToken
//获取DeviceToken成功
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *tempDeviceToken=[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]
                                stringByReplacingOccurrencesOfString: @">" withString: @""]
                               stringByReplacingOccurrencesOfString: @" " withString: @""];
    [mUserDefaults setObject:tempDeviceToken forKey:@"deviceToken"];
    NSLog(@"deviceToken ---:\n %@",deviceToken);
}
//获取DeviceToken失败
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    NSLog(@"[DeviceToken Error]:%@\n",error.description);
}
#pragma mark - iOS 10下的通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:
(void (^)(UIBackgroundFetchResult))completionHandler {
    
    NSLog(@"iOS7及以上系统，收到通知:%@", userInfo);
    completionHandler(UIBackgroundFetchResultNewData);
}
#pragma mark - iOS 10以上接收到通知 UNUserNotificationCenterDelegate
/**
 下面这个代理方法，只会是app处于前台状态 前台状态 and 前台状态下才会走，后台模式下是不会走这里的
 */
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler  API_AVAILABLE(ios(10.0)){
    //收到推送的请求
    UNNotificationRequest *request = notification.request;
    //收到推送的内容
    UNNotificationContent *content = request.content;
    //收到用户的基本信息
    NSDictionary *userInfo = content.userInfo;
    //收到推送消息的角标
//    NSNumber *badge = content.badge;
//    //收到推送消息body
//    NSString *body = content.body;
//    //推送消息的声音
//    UNNotificationSound *sound = content.sound;
//    // 推送消息的副标题
//    NSString *subtitle = content.subtitle;
//    // 推送消息的标题
//    NSString *title = content.title;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //此处省略一万行需求代码。。。。。。
        NSLog(@"iOS10 收到远程通知:%@",userInfo);
    }else {
        // 判断为本地通知
    }
    // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
    completionHandler(UNNotificationPresentationOptionBadge|
                      UNNotificationPresentationOptionSound|
                      UNNotificationPresentationOptionAlert);
}
/**
 下面这个代理方法，只会是用户点击消息才会触发，如果使用户长按（3DTouch）、Action等并不会触发。
 */
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler  API_AVAILABLE(ios(10.0)){
    //收到推送的请求
    UNNotificationRequest *request = response.notification.request;
    //收到推送的内容
    UNNotificationContent *content = request.content;
    //收到用户的基本信息
    NSDictionary *userInfo = content.userInfo;
    //收到推送消息的角标
//    NSNumber *badge = content.badge;
//    //收到推送消息body
//    NSString *body = content.body;
//    //推送消息的声音
//    UNNotificationSound *sound = content.sound;
//    // 推送消息的副标题
//    NSString *subtitle = content.subtitle;
//    // 推送消息的标题
//    NSString *title = content.title;
    
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        NSLog(@"iOS10 收到远程通知:%@",userInfo);
        //此处省略一万行需求代码。。。。。。
        
    }else {
        // 判断为本地通知
    }
    completionHandler(); // 系统要求执行这个方法
}

@end
