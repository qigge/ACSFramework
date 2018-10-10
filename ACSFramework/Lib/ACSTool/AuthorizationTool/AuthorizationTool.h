//
//  AuthorizationTool.h
//  YasiClub
//
//  Created by wang on 2018/3/8.
//  Copyright © 2018年 qigge. All rights reserved.
//

#import <Foundation/Foundation.h>

/// Asset 授权的状态
typedef NS_ENUM(NSUInteger, ACSAssetAuthorizationStatus) {
    ACSAssetAuthorizationStatusNotDetermined,      // 还不确定有没有授权
    ACSAssetAuthorizationStatusAuthorized,         // 已经授权
    ACSAssetAuthorizationStatusNotAuthorized       // 手动禁止了授权
};

typedef void(^ACSAuthorizationBlock)(ACSAssetAuthorizationStatus status);

@interface AuthorizationTool : NSObject

/**
 检查相册权限
 */
+ (void)hasPhotoAuthrizationWithBlock:(ACSAuthorizationBlock)block;
/**
 检查相机权限
 */
+ (void)hasVideoAuthrizationWithBlock:(ACSAuthorizationBlock)block;
/**
 检查麦克风权限
 */
+ (void)hasAudioAuthrizationWithBlock:(ACSAuthorizationBlock)block;
/**
 检查定位权限
 */
+ (BOOL)hasLocationAuthrization;

/**
 检查推送权限
 */
+ (BOOL)hasNotificationAuthrization;
/**
 通讯录权限
 */
//+ (BOOL)hasAddressBookAuthrization;

@end
