//
//  BannerObject.m
//  xasq
//
//  Created by dssj on 2019/8/12.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "BannerObject.h"
#import <YYModel/YYModel.h>

@implementation BannerObject

+ (instancetype)modelWithDictionary:(NSDictionary *)dict {
    if (dict && [dict isKindOfClass:[NSDictionary class]]) {
        return [BannerObject yy_modelWithDictionary:dict];
    }
    return nil;
}

+ (NSArray *)modelWithArray:(NSArray *)array {
    if (array && [array isKindOfClass:[NSArray class]]) {
        return [NSArray yy_modelArrayWithClass:[BannerObject class] json:array];
    }
    return nil;
}

@end
