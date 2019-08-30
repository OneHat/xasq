//
//  AppConfigure.h
//  xasq
//
//  Created by dssj on 2019/7/26.
//  Copyright © 2019 dssj. All rights reserved.
//

#ifndef AppConfigure_h
#define AppConfigure_h

#pragma mark -

#define ScreenWidth         [UIScreen mainScreen].bounds.size.width
#define ScreenHeight        [UIScreen mainScreen].bounds.size.height

#define IphoneX             (ScreenHeight / ScreenWidth  > 2.0 ? YES : NO)

#define StatusBarHeight     [UIApplication sharedApplication].statusBarFrame.size.height
#define NavBarHeight        44.0
#define BottomHeight        (IphoneX ? 34.0 : 0.0)
#define NavHeight           (NavBarHeight + StatusBarHeight)

#pragma mark -
/// 主题颜色
#define ThemeColorBlue        HexColor(@"#2688D0")
#define ThemeColorBackground  HexColor(@"#F7F7F7")
#define ThemeColorTextGray    HexColor(@"#999999")
#define ThemeColorText        HexColor(@"#333333")
#define ThemeColorLine        HexColor(@"#EEEEEE")
#define ThemeColorNavLine     HexColor(@"#DDDDDD")

/// 字体
#define ThemeFontText         [UIFont systemFontOfSize:15]
#define ThemeFontMiddleText   [UIFont systemFontOfSize:14]
#define ThemeFontSmallText    [UIFont systemFontOfSize:13]
#define ThemeFontTipText      [UIFont systemFontOfSize:12]

#pragma mark -
//BTC最小单位
#define BTCRate               100000000

#endif /* AppConfigure_h */
