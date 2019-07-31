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

#define Language(key)    [LanguageTool languageWithKey:key]

/// 颜色
#define HexColor(color)    [UIColor colorWithHexString:color]
#define RGBColor(r,g,b)    [UIColor colorWithRed:(r / 255.0f) green:(g / 255.0f) blue:(b / 255.0f) alpha:1.0];
#define RGBColorA(r,g,b,a)    [UIColor colorWithRed:(r / 255.0f) green:(g / 255.0f) blue:(b / 255.0f) alpha:a];


/// 主题颜色
#define ThemeColorBlue        HexColor(@"#4687CA")
#define ThemeColorGray        HexColor(@"#D8D8D8")
#define ThemeColorTextGray    HexColor(@"#C8C8C8")
#define ThemeColorBackground    HexColor(@"#C8C8C8")


/// 字体
#define ThemeFontButtonTitle  [UIFont systemFontOfSize:15]
#define ThemeFontNormalText   [UIFont systemFontOfSize:15]
#define ThemeFontTipText      [UIFont systemFontOfSize:12]


#endif /* AppMarco_h */
