//
//  CalendarModel.m
//  xasq
//
//  Created by dssj888@163.com on 2019/9/9.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "CalendarModel.h"

@implementation CalendarModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dict {
    if (dict && [dict isKindOfClass:[NSDictionary class]]) {
        return [CalendarModel yy_modelWithDictionary:dict];
    }
    return nil;
}

+ (NSArray *)modelWithArray:(NSArray *)array {
    if (array && [array isKindOfClass:[NSArray class]]) {
        return [NSArray yy_modelArrayWithClass:[CalendarModel class] json:array];
    }
    return nil;
}

@end
