//
//  CapitalModel.h
//  xasq
//
//  Created by dssj888@163.com on 2019/8/19.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CapitalModel : NSObject
/// 币种名称
@property (nonatomic, strong) NSString *currency;
/// 币种图片
@property (nonatomic, strong) NSString *icon;
/// 余额
@property (nonatomic, strong) NSString *amount;
/// 该币种资产折合人名币
@property (nonatomic, strong) NSString *toCNY;
/// 该币种资产折合比特币
@property (nonatomic, strong) NSString *toBTC;


+ (instancetype)modelWithDictionary:(NSDictionary *)dict;
+ (NSArray *)modelWithArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
