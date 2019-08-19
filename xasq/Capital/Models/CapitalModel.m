//
//  CapitalModel.m
//  xasq
//
//  Created by dssj888@163.com on 2019/8/19.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "CapitalModel.h"

@implementation CapitalModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dict {
    if (dict && [dict isKindOfClass:[NSDictionary class]]) {
        return [CapitalModel yy_modelWithDictionary:dict];
    }
    return nil;
}

+ (NSArray *)modelWithArray:(NSArray *)array {
    if (array && [array isKindOfClass:[NSArray class]]) {
        return [NSArray yy_modelArrayWithClass:[CapitalModel class] json:array];
    }
    return nil;
}

@end
