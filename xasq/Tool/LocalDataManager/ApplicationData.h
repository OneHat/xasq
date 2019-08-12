//
//  ApplicationData.h
//  xasq
//
//  Created by dssj on 2019/8/6.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UpdateInfoObject : NSObject

@property (nonatomic, strong) NSString *site;//站点 ios/android/pc

///下载地址
@property (nonatomic, strong) NSString *download;
///升级描述
@property (nonatomic, strong) NSString *upgradeDesc;
///最新版本号
@property (nonatomic, strong) NSString *appVersion;
///是否强制升级(后台返回值：0，不强制升级 1，强制升级)
@property (nonatomic, assign) BOOL forceUpgrade;

+ (instancetype)modelWithDictionary:(NSDictionary *)dict;

@end


@interface ApplicationData : NSObject

+ (instancetype)shareData;

///存储新版本号到本地（新版本第一次启动后）
- (void)saveNewVersion;

///是不是新版本第一次启动，如果是，返回YES，否则返回NO
- (BOOL)isFirstLanuch;

/// 是否有新版本(服务器返回)
@property (nonatomic, assign) BOOL showNewVersion;

//新版本更新信息
@property (nonatomic, strong) UpdateInfoObject *updateInfo;

@end

NS_ASSUME_NONNULL_END
