//
//  AuthorizationTool.h
//  YasiClub
//
//  Created by wang on 2018/3/8.
//  Copyright © 2018年 qigge. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

/// Asset 授权的状态
typedef NS_ENUM(NSUInteger, ACSAssetAuthorizationStatus) {
    ACSAssetAuthorizationStatusNotDetermined,      // 还不确定有没有授权
    ACSAssetAuthorizationStatusAuthorized,         // 已经授权
    ACSAssetAuthorizationStatusNotAuthorized       // 手动禁止了授权
};

typedef void(^ACSAuthorizationBlock)(ACSAssetAuthorizationStatus status);


@interface ACSAuthorizationTool : NSObject

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
+ (void)hasLocationAuthrizationWithBlock:(ACSAuthorizationBlock)block;

/**
 检查推送权限
 */
+ (void)hasNotificationAuthrizationWithBlock:(ACSAuthorizationBlock)block;

/**
 通讯录权限
 */
//+ (BOOL)hasAddressBookAuthrization;

@end
