//
//  AppDelegate+ACSUmeng.m
//  ACSFramework
//
//  Created by wang on 2018/6/1.
//  Copyright © 2018年 qigge. All rights reserved.
//

#import "AppDelegate+ACSUmeng.h"

#import <UMCommon/UMCommon.h>
#import <UMAnalytics/MobClick.h>        // 统计组件

@implementation AppDelegate (ACSUmeng)

- (void)acs_registerUmeng {
//    [UMConfigure setEncryptEnabled:YES];//打开加密传输
#ifdef DEBUG
#else
    [UMConfigure setLogEnabled:NO];
    [UMConfigure initWithAppkey:@"" channel:@"App Store"];
    
    [MobClick setScenarioType:E_UM_NORMAL];
    //    [MobClick setCrashReportEnabled:YES];   // 默认开启Crash收集
#endif
    
}

@end
