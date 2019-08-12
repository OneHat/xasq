//
//  MiningAreaObject.m
//  xasq
//
//  Created by dssj on 2019/8/12.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "MiningAreaObject.h"
#import <YYModel/YYModel.h>

@implementation MiningAreaObject

+ (instancetype)modelWithDictionary:(NSDictionary *)dict {
    MiningAreaObject *obj = [MiningAreaObject yy_modelWithDictionary:dict];
    obj.ID = [dict[@"id"] integerValue];
    
    return obj;
}

+ (NSArray *)modelWithArray:(NSArray *)array {
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary *dict in array) {
        MiningAreaObject *miningAreaObj = [MiningAreaObject modelWithDictionary:dict];
        [result addObject:miningAreaObj];
    }
    
    return [NSArray arrayWithArray:result];
}

@end
