//
//  CalendarModel.h
//  xasq
//
//  Created by dssj888@163.com on 2019/9/9.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CalendarModel : NSObject

@property (nonatomic, assign) long recordId; // 资讯id
@property (nonatomic, strong) NSString *title; // 标题
@property (nonatomic, strong) NSString *holidayName; // 节日名
@property (nonatomic, strong) NSString *country; // 国家
@property (nonatomic, strong) NSString *preVal; // 前值
@property (nonatomic, strong) NSString *expectVal; // 预期值
@property (nonatomic, strong) NSString *publishVal; // 公布值
@property (nonatomic, strong) NSString *time; // 时间

@property (nonatomic, assign) NSInteger important; // 重要度

+ (instancetype)modelWithDictionary:(NSDictionary *)dict;
+ (NSArray *)modelWithArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
