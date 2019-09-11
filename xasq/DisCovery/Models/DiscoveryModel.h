//
//  DiscoveryModel.h
//  xasq
//
//  Created by dssj888@163.com on 2019/9/10.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DiscoveryModel : NSObject

@property (nonatomic, assign) long recordId; // 资讯id
@property (nonatomic, assign) long categoryId; // 分类id
@property (nonatomic, strong) NSString *title; // 标题
@property (nonatomic, strong) NSString *digest; // 简介
@property (nonatomic, strong) NSString *releaseTime; // 发布时间
@property (nonatomic, strong) NSString *author; // 作者
@property (nonatomic, strong) NSString *source; // 来源
@property (nonatomic, strong) NSString *tags; // 标签
@property (nonatomic, strong) NSString *link; // 链接地址
@property (nonatomic, strong) NSString *img; // 广告图
@property (nonatomic, strong) NSString *preVal; // 前值
@property (nonatomic, strong) NSString *expectVal; // 预期值
@property (nonatomic, strong) NSString *publishVal; // 公布值
@property (nonatomic, assign) NSInteger important; // 重要度
@property (nonatomic, assign) NSInteger hot; // 热门度
@property (nonatomic, assign) NSInteger type; // 类型 1：简讯 2：长讯 3：广告 4：数据
@property (nonatomic, assign) NSInteger rank; // 0 代表置顶
@property (nonatomic, assign) NSInteger cellHeight; // cell高度


+ (instancetype)modelWithDictionary:(NSDictionary *)dict;
+ (NSArray *)modelWithArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
