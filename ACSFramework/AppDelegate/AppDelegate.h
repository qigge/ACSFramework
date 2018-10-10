//
//  AppDelegate.h
//  ZQFramework
//
//  Created by wang on 2017/12/20.
//  Copyright © 2017年 qigge. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AFNetworkReachabilityManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/** 网络状态 */
@property (assign, nonatomic) AFNetworkReachabilityStatus networktype;

@end

