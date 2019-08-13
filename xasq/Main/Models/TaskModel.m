//
//  TaskModel.m
//  xasq
//
//  Created by dssj on 2019/8/13.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "TaskModel.h"
#import <YYModel/YYModel.h>

@implementation TaskModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dict {
    return [TaskModel yy_modelWithDictionary:dict];
}

+ (NSArray *)modelWithArray:(NSArray *)array {
    return [NSArray yy_modelArrayWithClass:[TaskModel class] json:array];
}

@end
