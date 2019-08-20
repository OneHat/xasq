//
//  PaymentsRecordModel.h
//  xasq
//
//  Created by dssj888@163.com on 2019/8/20.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PaymentsRecordModel : NSObject

@property (nonatomic, strong) NSString *outAccountId;   // 对方账户ID
@property (nonatomic, strong) NSString *businessCode;  // 流水号
@property (nonatomic, strong) NSString *causeType;    // 类型
@property (nonatomic, strong) NSString *currency;    // 币种
@property (nonatomic, strong) NSString *nameStr;    // 奖励名称
@property (nonatomic, strong) NSString *amount;    // 数量
@property (nonatomic, strong) NSString *time;     // 发生时间
+ (instancetype)modelWithDictionary:(NSDictionary *)dict;
+ (NSArray *)modelWithArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
