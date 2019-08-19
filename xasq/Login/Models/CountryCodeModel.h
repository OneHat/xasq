//
//  CountryCodeModel.h
//  xasq
//
//  Created by dssj888@163.com on 2019/8/19.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CountryCodeModel : NSObject

@property (nonatomic, copy) NSString *name; // 国家中文名称
@property (nonatomic, copy) NSString *areaCode; // 国家电话区号
@property (nonatomic, copy) NSString *code; // 区域

+ (instancetype)modelWithDictionary:(NSDictionary *)dict;
+ (NSArray *)modelWithArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
