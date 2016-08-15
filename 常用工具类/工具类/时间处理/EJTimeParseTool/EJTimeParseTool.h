//
//  EJTimeParseTool.h
//  DaDaGo
//
//  Created by xiacheng on 16/5/27.
//  Copyright © 2016年 xiacheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EJTimeParseTool : NSObject



+ (void)test;


/**
 *  //将timeStamp按系统时区并按照 yyyy-MM-dd HH:mm:ss 格式时间输出（24小时制）
 *
 *  @param timeStamp 时间戳（1970）
 *
 *  @return 格式化后的时间字符串
 */
+ (NSString *)fullTimeStringFromTimeStamp:(long)timeStamp;

/**
 *  返回日期，不包括年:M月dd号(周几)
 *
 *  @param timeStamp 时间戳
 *
 *  @return string
 */
+ (NSString *)dateOnlyStringFromTimeStamp:(long)timeStamp;

/**
 *  返回时间：HH:mm
 *
 *  @param timeStamp 时间戳
 *
 *  @return string
 */
+ (NSString *)timeOnlyStringFromTimeStamp:(long)timeStamp;


+ (NSString *)fullDateStringFromTimeStamp:(long)timeStamp;

#pragma -mark 常用方法
/**
 *  将NSDate 按照 yyyy-MM-dd HH:mm:ss（24小时制） 格式时间输出
 *
 *  @param date NSDate对象
 *
 *  @return 格式化后的时间字符串
 */
+ (NSString*)nsDateToString:(NSDate *)date;
/**
 *  把 yyyy-MM-dd HH:mm:ss(24) 格式的时间转化为时间戳
 *
 *  @param timeStr 时间字符串
 *
 *  @return 时间戳
 */
+ (long)changeTimeToTimeSp:(NSString *)timeStr;

/**
 *  把yyyy-MM-dd 格式日期转化为时间戳
 *
 *  @param dateStr 时间
 *
 *  @return long类型时间戳
 */
+ (long)changeDateToTimeSp:(NSString *)dateStr;

@end
