//
//  MyTaskModel.m
//  xasq
//
//  Created by dssj on 2019/8/13.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "MyTaskModel.h"
#import <YYModel/YYModel.h>

@implementation MyTaskModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dict {
    return [MyTaskModel yy_modelWithDictionary:dict];
}

@end
