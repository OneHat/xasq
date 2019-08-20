//
//  CurrencyModel.h
//  xasq
//
//  Created by dssj888@163.com on 2019/8/20.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CurrencyModel : NSObject

@property (nonatomic, strong) NSString *currencyCode; // 货币编码
@property (nonatomic, strong) NSString *name; // 货币名称
@property (nonatomic, strong) NSString *icon; // 货币图标

+ (instancetype)modelWithDictionary:(NSDictionary *)dict;
+ (NSArray *)modelWithArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
