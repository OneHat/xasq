//
//  NSString+Size.h
//  xasq
//
//  Created by dssj on 2019/7/31.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Size)

- (CGFloat)getWidthWithFont:(UIFont *)font;
/**
 *  汉字转拼音
 */
+ (NSString *)transform:(NSString *)chinese;
/**
 *  MD5加密
 */
+ (NSString *)md5:(NSString *)str;
/**
 *  字符串高度计算
 *  title  字符串
 *  width  字符串宽度
 *  font   字符串大小
 *  defaultHeight 字符串默认高度
 */
+ (NSInteger)stringHeightCalculateWithTitle:(NSString *)title width:(NSInteger)width font:(UIFont *)font defaultHeight:(NSInteger)defaultHeight;

@end

NS_ASSUME_NONNULL_END
