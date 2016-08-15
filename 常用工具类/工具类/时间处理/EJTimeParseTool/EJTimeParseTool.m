//
//  EJTimeParseTool.m
//  DaDaGo
//
//  Created by xiacheng on 16/5/27.
//  Copyright © 2016年 xiacheng. All rights reserved.
//

#import "EJTimeParseTool.h"

@implementation EJTimeParseTool


+ (void)test
{
    NSString *dateStr = [self dateOnlyStringFromTimeStamp:[NSDate date].timeIntervalSince1970];
    NSLog(@"%@",dateStr);
    
}

+ (NSString *)fullTimeStringFromTimeStamp:(long)timeStamp
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    NSString *timeStr = [self nsDateToString:date];
    return timeStr;
}

+ (NSString *)dateOnlyStringFromTimeStamp:(long)timeStamp
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"M月dd号"];
    NSString* dateStr=[dateFormat stringFromDate:date];
    NSString *weekStr = [self weekdayStringFromDate:date];
    NSString *full = [NSString stringWithFormat:@"%@(%@)",dateStr,weekStr];
    return full;
}

+ (NSString *)timeOnlyStringFromTimeStamp:(long)timeStamp
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"HH:mm"];
    NSString* timeStr = [dateFormat stringFromDate:date];
    return timeStr;
}

//获取完整的年月日信息
+ (NSString *)fullDateStringFromTimeStamp:(long)timeStamp
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy年MM月dd日"];
    NSString* dateStr=[dateFormat stringFromDate:date];
    return dateStr;
}



+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
//    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: [NSTimeZone systemTimeZone]];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

+ (NSDate*)timeStampToDateWithSystemZone:(NSTimeInterval)timeStamp{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:confromTimesp];
    NSDate *localeDate = [confromTimesp  dateByAddingTimeInterval: interval];
    return localeDate;
}

//将yyyy-MM-dd HH:mm:ss格式时间转换成时间戳（HH24小时制）
+ (long)changeTimeToTimeSp:(NSString *)timeStr{
    long time;
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *fromdate=[format dateFromString:timeStr];
    time= (long)[fromdate timeIntervalSince1970];
    return time;
}

//将yyyy年MM月dd日 HH:mm:ss 转化为时间戳
+ (long)changeTimeToStamp:(NSString *)timeStr
{
    long time;
    NSDateFormatter *format=[[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
    NSDate *fromdate=[format dateFromString:timeStr];
    time= (long)[fromdate timeIntervalSince1970];
    return time;
}

//把日期转化为时间戳:@"yyyy年MM月dd日"
+ (long)changeDateToTimeSp:(NSString *)dateStr
{
    NSString *fullTimeStr = [NSString stringWithFormat:@"%@ 00:00:00",dateStr];
    long result = [self changeTimeToStamp:fullTimeStr];
    return result;
}

//将NSDate按yyyy-MM-dd HH:mm:ss格式时间输出
+ (NSString*)nsDateToString:(NSDate *)date{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* string=[dateFormat stringFromDate:date];
    return string;
}







@end
