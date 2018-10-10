//
//  EncryptionTool.h
//  EarlyFramework
//
//  Created by wang on 2017/1/23.
//  Copyright © 2017年 wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>

@interface EncryptionTool : NSObject

/**
 32位 md5加密
 */
+ (NSString *)getMD5_32BIT_String:(NSString *)srcStirng;

/**
 40位 sha1加密
 */
+ (NSString *)getSHA1_40BIT_String:(NSString *)srcString;

/**
 DES加密
 */
+ (NSString*)encryptWithContent:(NSString*)content type:(CCOperation)type key:(NSString*)aKey;


@end
