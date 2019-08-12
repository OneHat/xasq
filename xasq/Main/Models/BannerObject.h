//
//  BannerObject.h
//  xasq
//
//  Created by dssj on 2019/8/12.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BannerObject : NSObject

@property (nonatomic, strong) NSString *site;//站点 ios/android/pc
@property (nonatomic, strong) NSString *imgPath;//图片地址
@property (nonatomic, strong) NSString *linkPath;//链接地址
@property (nonatomic, strong) NSString *title;//标题
@property (nonatomic, assign) NSInteger rank;//排序

+ (instancetype)modelWithDictionary:(NSDictionary *)dict;
+ (NSArray *)modelWithArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
