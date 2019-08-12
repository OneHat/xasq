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
    return [BannerObject yy_modelWithDictionary:dict];
}

@end
