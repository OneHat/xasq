//
//  MyTaskModel.h
//  xasq
//
//  Created by dssj on 2019/8/13.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyTaskModel : NSObject

//@property (nonatomic, assign) NSInteger ID;

/////算力加成系数
//@property (nonatomic, strong) NSDecimalNumber *addRatio;

///任务奖励币种
@property (nonatomic, strong) NSString *currencyCode;

///货币数量
@property (nonatomic, strong) NSDecimalNumber *currencyQuantity;

///奖励算力
@property (nonatomic, assign) NSInteger rewardPower;

///状态：0、未成熟 1、未收币可被偷取 10、未收币，不可偷取（已达到偷取上限）2、已收币 3、任务进行中 4、任务已完成
@property (nonatomic, assign) NSInteger status;

///任务编码
@property (nonatomic, strong) NSString *taskCode;

///类型： 1、步行送币 2、算力送币 3、活动奖励 5、偷币
@property (nonatomic, assign) NSInteger type;

///用户ID
@property (nonatomic, assign) NSInteger userId;

///用户等级
@property (nonatomic, strong) NSString *userLev;

///用户算力
@property (nonatomic, assign) NSInteger userPower;
///用户步行数
@property (nonatomic, assign) NSInteger walkNum;

+ (instancetype)modelWithDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
