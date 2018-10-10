//
//  IPTool.h
//  Passeasily
//
//  Created by wang on 2017/4/13.
//  Copyright © 2017年 qigge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ifaddrs.h>
#import <arpa/inet.h>

@interface DeviceTool : NSObject

/**
 获取IP地址
 */
+(NSString *)getIPAddress;

/**
 获取手机型号
 */
+ (NSString *)getCurrentDeviceModel;

/**
 设备唯一标识符
 */
+ (NSString *)getIdentifierUUID;

/**
 设备名称
 */
+ (NSString *)getSystemName;

/**
 手机别名： 用户定义的名称
 */
+ (NSString *)getSystemUserName;

/**
 手机系统版本
 */
+ (NSString *)getSystemVersion;

/**
 地方型号  （国际化区域名称）
 */
+ (NSString *)getlocalizedModel;

/**
 当前应用软件版本  比如：1.0.1
 */
+ (NSString *)getAppCurVersion;

/**
 当前应用版本号码   int类型
 */
+ (NSString *)getAppCurVersionNum;

@end
