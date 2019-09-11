//
//  NSDate+Change.m
//  xasq
//
//  Created by dssj888@163.com on 2019/9/3.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "NSDate+Change.h"

@implementation NSDate (Change)

#pragma mark - 判断是不是今天
+ (BOOL)compareDate:(NSDate *)date {
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    NSDate *today = [[NSDate alloc] init];
    NSDate *tomorrow, *yesterday;
    
    tomorrow = [today dateByAddingTimeInterval:secondsPerDay];
    yesterday = [today dateByAddingTimeInterval:-secondsPerDay];
    
    // 10 first characters of description is the calendar date:
    NSString * todayString = [[today description] substringToIndex:10];
    NSString * dateString = [[date description] substringToIndex:10];
    
    if ([dateString isEqualToString:todayString]) {
        return YES;
    }else {
        return NO;
    }
}

#pragma mark - 获取当前时间（标准格式）
+ (NSString *)getStandardTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
//    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
//    [formatter setTimeZone:timeZone];
    NSDate *datenow = [NSDate date];
    NSString *nowtimeStr = [formatter stringFromDate:datenow];
    return nowtimeStr;
}

#pragma mark 年月日转换成Date
+ (NSDate *)stringTransferToDate:(NSString *)string {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YY-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:string];
    return date;
}

#pragma mark YYYY-MM-DD hh:mm:ss 返回 hh:mm:ss
+ (NSString *)timeTransferWithString:(NSString *)string {
    NSString *time = @"";
    if (string.length >= 17) {
        time = [string substringFromIndex:11];
    }
    return time;
}

/**
 *YYYY-MM-DD hh:mm:ss 返回 DD
 *
 */
+ (NSString *)dayTransferWithString:(NSString *)string {
    NSString *day = @"";
    if (string.length >= 17) {
        day = [string substringWithRange:NSMakeRange(8, 2)];
    }
    return day;
}

/**
 *YYYY-MM-DD hh:mm:ss 返回 MM
 *
 */
+ (NSString *)monthTransferWithString:(NSString *)string {
    NSString *month = @"";
    if (string.length >= 17) {
        month = [string substringWithRange:NSMakeRange(5, 2)];
    }
    return month;
}

@end
