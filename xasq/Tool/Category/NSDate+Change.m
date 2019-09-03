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

#pragma mark 年月日转换成Date
+ (NSDate *)stringTransferToDate:(NSString *)string{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YY-MM-dd HH:mm:ss"];
    NSDate *date = [dateFormatter dateFromString:string];
    return date;
}


@end
