//
//  TacticsObject.h
//  xasq
//
//  Created by dssj on 2019/7/29.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TacticsObject : NSObject

@property (nonatomic, strong) NSString *name;//策略名称
@property (nonatomic, strong) NSString *shortDes;//策略简介
@property (nonatomic, strong) NSString *reward;//策略收益率

@property (nonatomic, strong) NSString *desc;//策略描述

@end

NS_ASSUME_NONNULL_END
