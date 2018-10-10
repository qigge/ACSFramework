//
//  TimeTool.m
//  Passeasily
//
//  Created by wang on 2017/2/8.
//  Copyright © 2017年 qigge. All rights reserved.
//

#import "TimeTool.h"

@implementation TimeTool

/**
 时间戳转时间
 @param timeStamp 时间戳 字符串类型
 @param formatterStr 时间格式 默认 yyyy-MM-dd HH:mm:ss
 @return 返回格式化的时间
 */
+ (NSString *)timeStampIntervalToStringWithTimeStamp:(NSTimeInterval)timeStamp formatter:(NSString *)formatterStr {
    return [TimeTool timeStampStringToStringWithTimeStamp:[NSString stringWithFormat:@"%f",timeStamp] formatter:formatterStr];
}

/**
 时间戳转时间
 @param timeStamp 时间戳 字符串类型
 @param formatterStr 时间格式 默认 yyyy-MM-dd HH:mm:ss
 @return 返回格式化的时间
 */
+ (NSString *)timeStampStringToStringWithTimeStamp:(NSString *)timeStamp formatter:(NSString *)formatterStr {
    NSTimeInterval interval = [timeStamp doubleValue];
    // iOS 生成的时间戳是10位
    if (timeStamp.length == 13) {  // 若是返回的13位时间戳，将其变为10位的
        interval = interval / 1000.0;
    }
    
    NSDate *date               = [NSDate dateWithTimeIntervalSince1970:interval];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (formatterStr) {
        [formatter setDateFormat:formatterStr];
    }else {
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    
    return [formatter stringFromDate:date];
}

/**
 获取当前时间字符串
 @param formatterStr 时间格式 默认 yyyy-MM-dd HH:mm:ss
 @return 格式化的时间字符串
 */
+ (NSString *)currentDateWithFormatter:(NSString *)formatterStr {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    //设置时区,这个对于时间的处理有时很重要
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    if (formatterStr) {
        [formatter setDateFormat:formatterStr];
    }else {
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    return [formatter stringFromDate:[NSDate date]];
}

/**
 获取当前时间戳
 @return 格式化的时间字符串
 */
+ (NSTimeInterval)currentTimeStamp {
    return [[NSDate date] timeIntervalSince1970];
}

@end
