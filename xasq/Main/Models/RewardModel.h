//
//  RewardModel.h
//  xasq
//
//  Created by dssj on 2019/8/14.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RewardModel : NSObject

///用户ID
@property (nonatomic, assign) NSInteger userId;

///币块id
@property (nonatomic, assign) NSInteger ID;

///状态 0、未成熟 1、未收币可被偷取 2、已收币 10、未收币，不可偷取（已达到偷取上限）
@property (nonatomic, assign) NSInteger status;

///货币编码
@property (nonatomic, strong) NSString *currencyCode;

///货币数量
@property (nonatomic, strong) NSString *currencyQuantity;

///送币类型 ： 1、步行送币 2、算力送币 3、活动奖励 5、偷币
@property (nonatomic, assign) NSInteger type;

///步行步数
@property (nonatomic, assign) NSInteger walkNum;

///成熟时间
@property (nonatomic, assign) long generateTime;

+ (instancetype)modelWithDictionary:(NSDictionary *)dict;
+ (NSArray *)modelWithArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
