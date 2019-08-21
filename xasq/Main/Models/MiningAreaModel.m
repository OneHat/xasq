//
//  MiningAreaObject.m
//  xasq
//
//  Created by dssj on 2019/8/12.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "MiningAreaModel.h"
#import <YYModel/YYModel.h>

@implementation MiningAreaModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dict {
    MiningAreaModel *obj = [MiningAreaModel yy_modelWithDictionary:dict];
    obj.ID = [dict[@"id"] integerValue];
    
    return obj;
}

+ (NSArray *)modelWithArray:(NSArray *)array {
    
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary *dict in array) {
        MiningAreaModel *miningAreaObj = [MiningAreaModel modelWithDictionary:dict];
        [result addObject:miningAreaObj];
    }
    
    return [NSArray arrayWithArray:result];
}

@end
