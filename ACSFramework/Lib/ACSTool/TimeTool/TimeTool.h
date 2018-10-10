//
//  TimeTool.h
//  Passeasily
//
//  Created by wang on 2017/2/8.
//  Copyright © 2017年 qigge. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeTool : NSObject
/**
 时间戳转时间
 @param timeStamp 时间戳 字符串类型
 @param formatterStr 时间格式 默认 yyyy-MM-dd HH:mm:ss
 @return 返回格式化的时间
 */
+ (NSString *)timeStampIntervalToStringWithTimeStamp:(NSTimeInterval)timeStamp formatter:(NSString *)formatterStr;
/**
 时间戳转时间
 @param timeStamp 时间戳 字符串类型
 @param formatterStr 时间格式 默认 yyyy-MM-dd HH:mm:ss
 @return 返回格式化的时间
 */
+ (NSString *)timeStampStringToStringWithTimeStamp:(NSString *)timeStamp formatter:(NSString *)formatterStr ;

/**
 获取当前时间字符串
 @param formatterStr 时间格式 默认 yyyy-MM-dd HH:mm:ss
 @return 格式化的时间字符串
 */
+ (NSString *)currentDateWithFormatter:(NSString *)formatterStr;

/**
 获取当前时间戳
 @return 格式化的时间字符串
 */
+ (NSTimeInterval)currentTimeStamp;

@end
