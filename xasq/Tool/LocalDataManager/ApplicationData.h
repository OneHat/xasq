//
//  ApplicationData.h
//  xasq
//
//  Created by dssj on 2019/8/6.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ApplicationData : NSObject

///存储新版本号到本地
+ (void)saveNewVersion;

///检查新版本，如果是新版本，返回YES，否则返回NO
+ (BOOL)checkVersion;

@end

NS_ASSUME_NONNULL_END
