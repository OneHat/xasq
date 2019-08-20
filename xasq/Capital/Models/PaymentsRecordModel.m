//
//  PaymentsRecordModel.m
//  xasq
//
//  Created by dssj888@163.com on 2019/8/20.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "PaymentsRecordModel.h"

@implementation PaymentsRecordModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dict {
    if (dict && [dict isKindOfClass:[NSDictionary class]]) {
        return [PaymentsRecordModel yy_modelWithDictionary:dict];
    }
    return nil;
}

+ (NSArray *)modelWithArray:(NSArray *)array {
    if (array && [array isKindOfClass:[NSArray class]]) {
        return [NSArray yy_modelArrayWithClass:[PaymentsRecordModel class] json:array];
    }
    return nil;
}

@end
