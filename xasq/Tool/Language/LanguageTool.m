//
//  LanguageTool.m
//  xasq
//
//  Created by dssj on 2019/7/26.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "LanguageTool.h"

static NSString *LanguageCacheKey = @"xasqLanguageCacheKey";

static NSString *LanguageZhHans = @"zh-Hans";
static NSString *LanguageEn = @"en";

@implementation LanguageTool
    
+ (void)initializeLanguage {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
//    //第一次进入，没有设置过语言
//    if (![userDefaults objectForKey:@"LanguageCacheKey"]) {
//        NSArray *languages = [userDefaults objectForKey:@"AppleLanguages"];
//        NSString *localLanguge = [languages objectAtIndex:0];
//
//        if ([localLanguge isEqualToString:LanguageZhHans]) {
//            [userDefaults setObject:localLanguge forKey:LanguageCacheKey];
//        } else {
//            [userDefaults setObject:LanguageEn forKey:LanguageCacheKey];
//        }
//    }
    
    [userDefaults setObject:LanguageZhHans forKey:LanguageCacheKey];
}

+ (NSString *)languageWithKey:(NSString *)key {
    
    NSString *localLanguge = [[NSUserDefaults standardUserDefaults] objectForKey:LanguageCacheKey];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:localLanguge ofType:@"lproj"];
    NSString *result = [[NSBundle bundleWithPath:path] localizedStringForKey:key value:nil table:nil];
    
    return result;
}

+ (LanguageType)currentLanguageType {
    LanguageType type = LanguageTypeZhHans;
    
    NSString *localLanguge = [[NSUserDefaults standardUserDefaults] objectForKey:LanguageCacheKey];
    
    if ([localLanguge isEqualToString:LanguageZhHans]) {
        type = LanguageTypeZhHans;
    } else if ([localLanguge isEqualToString:LanguageEn]) {
        type = LanguageTypeEn;
    }
    
    return type;
}

+(NSString *)currentLanguage {
    return [[NSUserDefaults standardUserDefaults] objectForKey:LanguageCacheKey];
}
    
@end
