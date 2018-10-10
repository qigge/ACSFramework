//
//  AuthorizationTool.m
//  YasiClub
//
//  Created by wang on 2018/3/8.
//  Copyright © 2018年 qigge. All rights reserved.
//

#import "AuthorizationTool.h"
#import <Photos/Photos.h>

@implementation AuthorizationTool

+ (BOOL)InfoDicHasKey:(NSString *)key {
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    if ([[info allKeys] containsObject:key]) {
        return YES;
    }
    return NO;
}

/**
 检查相册权限
 */
+ (void)hasPhotoAuthrizationWithBlock:(ACSAuthorizationBlock)block {
    NSAssert([AuthorizationTool InfoDicHasKey:@"NSPhotoLibraryUsageDescription"],@"Info.plist must add NSPhotoLibraryUsageDescription");
    PHAuthorizationStatus photoAuthorStatus = [PHPhotoLibrary authorizationStatus];
    if (photoAuthorStatus == PHAuthorizationStatusRestricted ||
        photoAuthorStatus == PHAuthorizationStatusDenied) {
        if (block) {
            block(ACSAssetAuthorizationStatusNotAuthorized);
        }
    }else if (photoAuthorStatus == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus phStatus) {
            ACSAssetAuthorizationStatus status = ACSAssetAuthorizationStatusAuthorized;
            if (phStatus == PHAuthorizationStatusRestricted || phStatus == PHAuthorizationStatusDenied) {
                status = ACSAssetAuthorizationStatusNotAuthorized;
            } else if (phStatus == PHAuthorizationStatusNotDetermined) {
                status = ACSAssetAuthorizationStatusNotDetermined;
            }
            if (block) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    block(status);
                });
            }
        }];
    }else {
        if (block) {
            block(ACSAssetAuthorizationStatusAuthorized);
        }
    }
}

/**
 检查相机权限
 */
+ (void)hasVideoAuthrizationWithBlock:(ACSAuthorizationBlock)block {
    NSAssert([AuthorizationTool InfoDicHasKey:@"NSCameraUsageDescription"],@"Info.plist must add NSCameraUsageDescription");
    AVAuthorizationStatus AVstatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];//相机权限
    if (AVstatus == AVAuthorizationStatusDenied ||
        AVstatus == AVAuthorizationStatusRestricted) {
        if (block) {
            block(ACSAssetAuthorizationStatusNotAuthorized);
        }
    }else if (AVstatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            ACSAssetAuthorizationStatus status = ACSAssetAuthorizationStatusAuthorized;
            if (!granted) {
                status = ACSAssetAuthorizationStatusNotAuthorized;
            }
            if (block) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    block(status);
                });
            }
        }];
    }
    else {
        if (block) {
            block(ACSAssetAuthorizationStatusAuthorized);
        }
    }
}
/**
 检查麦克风权限
 */
+ (void)hasAudioAuthrizationWithBlock:(ACSAuthorizationBlock)block  {
    NSAssert([AuthorizationTool InfoDicHasKey:@"NSMicrophoneUsageDescription"],@"Info.plist must add NSMicrophoneUsageDescription");
    AVAuthorizationStatus AVstatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];//麦克风权限
    if (AVstatus == AVAuthorizationStatusDenied ||
        AVstatus == AVAuthorizationStatusRestricted) {
        if (block) {
            block(ACSAssetAuthorizationStatusNotAuthorized);
        }
    }else if (AVstatus == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
            ACSAssetAuthorizationStatus status = ACSAssetAuthorizationStatusAuthorized;
            if (!granted) {
                status = ACSAssetAuthorizationStatusNotAuthorized;
            }
            if (block) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    block(status);
                });
            }
        }];
    }
    else {
        if (block) {
            block(ACSAssetAuthorizationStatusAuthorized);
        }
    }
}
/**
 检查定位权限
 */
+ (BOOL)hasLocationAuthrization {
    NSAssert([AuthorizationTool InfoDicHasKey:@"NSLocationWhenInUseUsageDescription"] ||
             [AuthorizationTool InfoDicHasKey:@"NSLocationUsageDescription"],
             @"Info.plist must add NSLocationWhenInUseUsageDescription || NSLocationUsageDescription");
    BOOL isLocation = [CLLocationManager locationServicesEnabled];
    if (!isLocation) {
        return NO;
    }
    CLAuthorizationStatus CLstatus = [CLLocationManager authorizationStatus];
    if (CLstatus == kCLAuthorizationStatusDenied ||
        CLstatus == kCLAuthorizationStatusRestricted) {
        return NO;
    }
    return YES;
}

/**
 检查推送权限
 */
+ (BOOL)hasNotificationAuthrization {
    UIUserNotificationSettings *settings = [[UIApplication sharedApplication] currentUserNotificationSettings];
    if (settings.types == UIUserNotificationTypeNone) {
        return NO;
    }
    return YES;
}
/**
 通讯录权限
 */
//+ (BOOL)hasAddressBookAuthrization {
//    NSAssert([AuthorizationTool InfoDicHasKey:@"NSContactsUsageDescription"],@"Info.plist must add NSContactsUsageDescription");
//    ABAuthorizationStatus ABstatus = ABAddressBookGetAuthorizationStatus();
//    if (ABstatus == kABAuthorizationStatusDenied ||
//        ABstatus == kABAuthorizationStatusRestricted) {
//        return NO;
//    }
//    return YES;
//}

@end
