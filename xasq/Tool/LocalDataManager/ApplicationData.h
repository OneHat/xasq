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
@property (nonatomic, strong) NSString *download;//下载地址
@property (nonatomic, strong) NSString *upgradeDesc;//升级描述
@property (nonatomic, strong) NSString *appVersion;//最新版本号
@property (nonatomic, assign) BOOL forceUpgrade;//是否强制升级(后台返回值：0，不强制升级 1，强制升级)

+ (instancetype)modelWithDictionary:(NSDictionary *)dict;

@end


@interface ApplicationData : NSObject

+ (instancetype)shareData;

///存储新版本号到本地
- (void)saveNewVersion;

///是不是新版本第一次启动，如果是，返回YES，否则返回NO
- (BOOL)isFirstLanuch;

/// 是否有新版本
@property (nonatomic, assign) BOOL showNewVersion;

/**
 appVersion = 1005;
 download = ss;
 forceUpgrade = 1;
 site = ios;
 upgradeDesc = ss;
 */
@property (nonatomic, strong) UpdateInfoObject *updateInfo;

@end

NS_ASSUME_NONNULL_END
