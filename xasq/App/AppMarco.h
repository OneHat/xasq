//
//  AppMarco.h
//  xasq
//
//  Created by dssj on 2019/7/26.
//  Copyright © 2019 dssj. All rights reserved.
//

#ifndef AppMarco_h
#define AppMarco_h

#import "LanguageTool.h"

//语言
#define Language(key)    [LanguageTool languageWithKey:key]

/// 颜色
#define HexColor(color)    [UIColor colorWithHexString:color]
#define RGBColor(r,g,b)    [UIColor colorWithRed:(r / 255.0f) green:(g / 255.0f) blue:(b / 255.0f) alpha:1.0];
#define RGBColorA(r,g,b,a)    [UIColor colorWithRed:(r / 255.0f) green:(g / 255.0f) blue:(b / 255.0f) alpha:a];

//weak
#define WeakObject           __weak typeof(self) weakSelf = self;

/** app版本号 */
#define AppVersion          [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define AppBuild            [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]


#pragma mark - 通知
#define DSSJTabBarSelectHomeNotification      @"DSSJTabBarSelectHomeNotification"
#define DSSJTabBarSelectCapitalNotification   @"DSSJTabBarSelectCapitalNotification"
#define DSSJTabBarSelectUserNotification      @"DSSJTabBarSelectUserNotification"

#define DSSJUserLoginSuccessNotification      @"DSSJUserLoginSuccessNotification"
#define DSSJUserLogoutNotification            @"DSSJUserLogoutNotification"



#endif /* AppMarco_h */
