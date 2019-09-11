//
//  DiscoveryModel.m
//  xasq
//
//  Created by dssj888@163.com on 2019/9/10.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "DiscoveryModel.h"

@implementation DiscoveryModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dict {
    if (dict && [dict isKindOfClass:[NSDictionary class]]) {
        return [DiscoveryModel yy_modelWithDictionary:dict];
    }
    return nil;
}

+ (NSArray *)modelWithArray:(NSArray *)array {
    if (array && [array isKindOfClass:[NSArray class]]) {
        return [NSArray yy_modelArrayWithClass:[DiscoveryModel class] json:array];
    }
    return nil;
}

@end
