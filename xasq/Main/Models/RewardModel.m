//
//  RewardModel.m
//  xasq
//
//  Created by dssj on 2019/8/14.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "RewardModel.h"
#import <YYModel/YYModel.h>

@implementation RewardModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dict {
    
    RewardModel *obj = [RewardModel yy_modelWithDictionary:dict];
    obj.ID = [dict[@"id"] integerValue];
    
    return obj;
}

+ (NSArray *)modelWithArray:(NSArray *)array {
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary *dict in array) {
        RewardModel *obj = [RewardModel modelWithDictionary:dict];
        [result addObject:obj];
    }
    
    return [NSArray arrayWithArray:result];
}

@end
