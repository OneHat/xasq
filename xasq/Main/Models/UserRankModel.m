//
//  UserRankModel.m
//  xasq
//
//  Created by dssj on 2019/8/20.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "UserRankModel.h"
#import <YYModel/YYModel.h>

@implementation UserRankModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dict {
    if (dict && [dict isKindOfClass:[NSDictionary class]]) {
        return [UserRankModel yy_modelWithDictionary:dict];
    }
    return nil;
}

+ (NSArray *)modelWithArray:(NSArray *)array {
    
    return [NSArray yy_modelArrayWithClass:[UserRankModel class] json:array];
}

@end
