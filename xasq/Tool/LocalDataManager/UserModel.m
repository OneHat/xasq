//
//  UserModel.m
//  xasq
//
//  Created by dssj on 2019/8/13.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "UserModel.h"
#import <YYModel/YYModel.h>

@implementation UserModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dict {
    return [UserModel yy_modelWithDictionary:dict];
}

@end
