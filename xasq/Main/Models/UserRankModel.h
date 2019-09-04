//
//  UserRankModel.h
//  xasq
//
//  Created by dssj on 2019/8/20.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserRankModel : NSObject

///
@property (nonatomic, assign) NSInteger userId;

///
@property (nonatomic, strong) NSString *headImg;

///昵称
@property (nonatomic, strong) NSString *nickName;

///地区名称
@property (nonatomic, strong) NSString *countryName;


///排序号
@property (nonatomic, assign) NSInteger rank;

///用户算力
@property (nonatomic, assign) NSInteger power;

///用户等级
@property (nonatomic, strong) NSString *levelName;

///邀请人数
@property (nonatomic, assign) NSInteger inviteNum;

//+ (instancetype)modelWithDictionary:(NSDictionary *)dict;
+ (NSArray *)modelWithArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
