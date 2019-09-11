//
//  NSString+Size.m
//  xasq
//
//  Created by dssj on 2019/7/31.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "NSString+Size.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Size)

- (CGFloat)getWidthWithFont:(UIFont *)font {
    NSDictionary *attribute = @{NSFontAttributeName:font};
    CGSize size = [self sizeWithAttributes:attribute];
    return ceil(size.width);
}

#pragma mark - 汉字转拼音
+ (NSString *)transform:(NSString *)chinese {
    NSMutableString *pinyin = [chinese mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    return [pinyin uppercaseString];
}

#pragma mark - MD5加密
+ (NSString *)md5:(NSString *)str {
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (unsigned int)strlen(cStr), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [hash appendFormat:@"%02X", result[i]];
    }
    return [hash lowercaseString];
}
#pragma mark - 字符串高度计算
+ (NSInteger)stringHeightCalculateWithTitle:(NSString *)title width:(NSInteger)width font:(UIFont *)font defaultHeight:(NSInteger)defaultHeight {
    // 创建字体大小的字典 (记得设置label的字体大小)
    NSDictionary *fontDic = @{NSFontAttributeName : font};
    CGRect textRect = [title boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDic context:nil];
    if (textRect.size.height > defaultHeight) {
        return textRect.size.height;
    } else {
        return defaultHeight;
    }
}

@end
