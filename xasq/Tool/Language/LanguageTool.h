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
    ///简体中文
    LanguageTypeZhHans = 0,
    ///英文
    LanguageTypeEn,
    ///繁体中文
    LanguageTypeZhHk,
    ///VN
    LanguageTypeVn,
};

@interface LanguageTool : NSObject

///初始化语言
+ (void)initializeLanguage;

///根据不同的Key取对应语言的显示值
+ (NSString *)languageWithKey:(NSString *)key;

///当前语言类型
+ (LanguageType)currentLanguageType;

///设置语言类型
+ (void)setLanguageType:(LanguageType)type;

@end

NS_ASSUME_NONNULL_END
