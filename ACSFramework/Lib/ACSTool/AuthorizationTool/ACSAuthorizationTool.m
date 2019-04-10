//
//  AuthorizationTool.m
//  YasiClub
//
//  Created by wang on 2018/3/8.
//  Copyright © 2018年 qigge. All rights reserved.
//

#import "ACSAuthorizationTool.h"

#import <Photos/Photos.h>
#import <UserNotifications/UserNotifications.h>
//#import <AddressBook/AddressBook.h>

@implementation ACSAuthorizationTool

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
    NSAssert([ACSAuthorizationTool InfoDicHasKey:@"NSPhotoLibraryUsageDescription"],@"Info.plist must add NSPhotoLibraryUsageDescription");
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
    NSAssert([ACSAuthorizationTool InfoDicHasKey:@"NSCameraUsageDescription"],@"Info.plist must add NSCameraUsageDescription");
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
    NSAssert([ACSAuthorizationTool InfoDicHasKey:@"NSMicrophoneUsageDescription"],@"Info.plist must add NSMicrophoneUsageDescription");
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
+ (void)hasLocationAuthrizationWithBlock:(ACSAuthorizationBlock)block {
    NSAssert([ACSAuthorizationTool InfoDicHasKey:@"NSLocationWhenInUseUsageDescription"] ||
             [ACSAuthorizationTool InfoDicHasKey:@"NSLocationUsageDescription"],
             @"Info.plist must add NSLocationWhenInUseUsageDescription || NSLocationUsageDescription");
    BOOL isLocation = [CLLocationManager locationServicesEnabled];
    ACSAssetAuthorizationStatus status = ACSAssetAuthorizationStatusAuthorized;
    if (!isLocation) {
        status = ACSAssetAuthorizationStatusNotAuthorized;
    }else {
        CLAuthorizationStatus CLstatus = [CLLocationManager authorizationStatus];
        if (CLstatus == kCLAuthorizationStatusDenied ||
            CLstatus == kCLAuthorizationStatusRestricted) {
            status = ACSAssetAuthorizationStatusNotAuthorized;
        }else if (CLstatus == kCLAuthorizationStatusNotDetermined) {
            status = ACSAssetAuthorizationStatusNotDetermined;
        }
    }
    if (block) {
        block(status);
    }
}

/**
 检查推送权限
 */
+ (void)hasNotificationAuthrizationWithBlock:(ACSAuthorizationBlock)block {
    if (@available(iOS 10 , *)) {
        [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
            ACSAssetAuthorizationStatus status = ACSAssetAuthorizationStatusAuthorized;
            if (settings.authorizationStatus == UNAuthorizationStatusDenied) {
                // 没权限
                status = ACSAssetAuthorizationStatusNotAuthorized;
            }else if (settings.authorizationStatus == UNAuthorizationStatusNotDetermined) {
                status = ACSAssetAuthorizationStatusNotDetermined;
            }
            if (block) {
                block(status);
            }
        }];
    }
    else if (@available(iOS 8 , *)) {
        UIUserNotificationSettings * setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
        ACSAssetAuthorizationStatus status = ACSAssetAuthorizationStatusAuthorized;
        if (setting.types == UIUserNotificationTypeNone) {
            // 没权限
            status = ACSAssetAuthorizationStatusNotAuthorized;
        }
        if (block) {
            block(status);
        }
    }
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
