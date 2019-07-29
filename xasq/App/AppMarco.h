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

#define Language(key) [LanguageTool languageWithKey:key]

//NSLocalizedString(key, nil)

/// 颜色
#define setColor(color) [UIColor colorWithHexString:color]

#endif /* AppMarco_h */
