//
//  UserNewsModel.m
//  xasq
//
//  Created by dssj on 2019/8/21.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "UserNewsModel.h"
#import <YYModel/YYModel.h>

static NSDateFormatter *HomeNewsDateFormatter;
static NSDateFormatter *HomeNewsTimeFormatter;

@implementation UserNewsModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dict {
    
    HomeNewsDateFormatter = [[NSDateFormatter alloc] init];
    [HomeNewsDateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    [HomeNewsDateFormatter setDateFormat:@"MM-dd"];
    
    HomeNewsTimeFormatter = [[NSDateFormatter alloc] init];
    [HomeNewsTimeFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
    [HomeNewsTimeFormatter setDateFormat:@"HH:mm"];
    
    UserNewsModel *model = [UserNewsModel yy_modelWithDictionary:dict];
    
    NSDate *originalDate = [NSDate dateWithTimeIntervalSince1970:model.time / 1000];
    model.showTime = [HomeNewsTimeFormatter stringFromDate:originalDate];//时间
    
//    NSString *todatString = [HomeNewsDateFormatter stringFromDate:originalDate];//
//    NSDate *today = [HomeNewsDateFormatter dateFromString:todatString];//今天00:00
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday fromDate:[NSDate date]];
    [components setHour:0];
    [components setMinute:0];
    [components setSecond: 0];
    
    NSDate *today = [calendar dateFromComponents:components];//今天00:00
    NSDate *yesterday = [calendar dateByAddingUnit:NSCalendarUnitDay value:-1 toDate:today options:0];;//昨天00:00
    
    if (model.time >= [today timeIntervalSince1970] * 1000) {
        //今天
        model.showDate = @"今天";
        
    } else if (model.time >= [yesterday timeIntervalSince1970] * 1000) {
        //今天
        model.showDate = @"昨天";
        
    } else {
        model.showDate = [HomeNewsDateFormatter stringFromDate:originalDate];//
    }
    
    return model;
}

+ (NSArray *)modelWithArray:(NSArray *)array {
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary *dict in array) {
        UserNewsModel *newsModel = [UserNewsModel modelWithDictionary:dict];
        [result addObject:newsModel];
    }
    
    return [NSArray arrayWithArray:result];
}

@end
