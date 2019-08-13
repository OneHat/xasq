//
//  TaskModel.h
//  xasq
//
//  Created by dssj on 2019/8/13.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TaskModel : NSObject


//beginTime = "";
//code = chongfu1;
//comments = "";
//createdOn = "";
//currencyCode = "";
//endTime = "";
//id = 1;
//maxPower = "";
//maxQuantity = "";
//minPower = "";
//minQuantity = "";
//name = "\U91cd\U590d\U4efb\U52a1";
//power = 20;
//quantity = "";
//randomPower = "";
//randomQuantity = "";
//status = 0;
//type = 0;
//unit = 1;


@property (nonatomic, assign) NSInteger ID;
///活动名称
@property (nonatomic, strong) NSString *name;

///状态： 0:开启 1:关闭
@property (nonatomic, assign) NSInteger status;
///类型 0：重复任务，1：单次任务
@property (nonatomic, assign) NSInteger type;
///货币数量单位
@property (nonatomic, assign) NSInteger unit;

///任务开始时间
//@property (nonatomic, assign) NSInteger beginTime;

///任务结束时间
//@property (nonatomic, assign) NSInteger endTime;

///任务奖励币种
@property (nonatomic, strong) NSString *currencyCode;
///任务编码
@property (nonatomic, strong) NSString *code;

///是否随机算力 0 是 1 否
@property (nonatomic, assign) NSInteger randomPower;
///奖励算力
@property (nonatomic, assign) NSInteger power;
///最大奖励算力
@property (nonatomic, assign) NSInteger maxPower;
///最小奖励算力
@property (nonatomic, assign) NSInteger minPower;
///是否随机数量 0 是 1 否
@property (nonatomic, assign) NSInteger randomQuantity;

///奖励币种数量
@property (nonatomic, strong) NSDecimalNumber *quantity;
///最小奖励数量
@property (nonatomic, strong) NSDecimalNumber *minQuantity;
///最大奖励数量
@property (nonatomic, strong) NSDecimalNumber *maxQuantity;

+ (instancetype)modelWithDictionary:(NSDictionary *)dict;
+ (NSArray *)modelWithArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
