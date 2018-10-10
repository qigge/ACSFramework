//
//  AppDelegate+ACSNetWorkReachability.m
//  ACSFramework
//
//  Created by wang on 2018/6/1.
//  Copyright © 2018年 qigge. All rights reserved.
//

#import "AppDelegate+ACSNetWorkReachability.h"

@implementation AppDelegate (ACSNetWorkReachability)

- (void)acs_startNetWorkReachability {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        self.networktype = status;
    }];
}

@end
