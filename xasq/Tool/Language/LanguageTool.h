//
//  LanguageTool.h
//  xasq
//
//  Created by dssj on 2019/7/26.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, LanguageType) {
    ///中文简体
    LanguageTypeZhHans,
    ///英文
    LanguageTypeEn,
};

@interface LanguageTool : NSObject

///初始化语言
+ (void)initializeLanguage;

///根据不同的Key取对应语言的显示值
+ (NSString *)languageWithKey:(NSString *)key;

///当前语言类型
+ (LanguageType)currentLanguageType;

///当前语言
+ (NSString *)currentLanguage;

@end

NS_ASSUME_NONNULL_END
