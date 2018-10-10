//
//  a.h
//  ACSFramework
//
//  Created by wang on 2018/6/2.
//  Copyright © 2018年 qigge. All rights reserved.
//


#pragma mark - 域名

#define HostName   @"xxx.com"

#if DEBUG
// 测试环境
#define HostUrl    @"http://192.168.74.189:8000"
#else
// 正式环境
#define HostUrl    @"https://xxxx.com"
#endif

#pragma mark - UserDefaults的KEY

#define mUDFFirstRunKey    @"mUserDefaultsFirstRunKey"  //判断是否为第一次运行，升级后启动不算是第一次运行
