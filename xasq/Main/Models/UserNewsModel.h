//
//  UserNewsModel.h
//  xasq
//
//  Created by dssj on 2019/8/21.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserNewsModel : NSObject

///用户ID
@property (nonatomic, assign) NSInteger userId;

///偷取用户名称
@property (nonatomic, strong) NSString *userName;

///币种编码
@property (nonatomic, strong) NSString *currencyCode;

///货币数量
@property (nonatomic, strong) NSString *quantity;

///偷取时间
@property (nonatomic, assign) NSString *createdOn;

///偷取时间
@property (nonatomic, assign) long time;

//////////前端自己处理的时间
@property (nonatomic, strong) NSString *showTime;//显示时间
@property (nonatomic, strong) NSString *showDate;//显示日期

+ (instancetype)modelWithDictionary:(NSDictionary *)dict;
+ (NSArray *)modelWithArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
