//
//  NSString+Size.m
//  xasq
//
//  Created by dssj on 2019/7/31.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "NSString+Size.h"

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

@end
