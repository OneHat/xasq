//
//  NSDate+Change.h
//  xasq
//
//  Created by dssj888@163.com on 2019/9/3.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Change)

/**
 *  判断是不是今天
 */
+ (BOOL)compareDate:(NSDate *)date;
/**
 *  获取当前时间（标准格式）
 */
+ (NSString *)getStandardTime;
/**
 *年月日转换成Date
 *
 */
+ (NSDate *)stringTransferToDate:(NSString *)string;
/**
 *YYYY-MM-DD hh:mm:ss 返回 hh:mm:ss
 *
 */
+ (NSString *)timeTransferWithString:(NSString *)string;
/**
 *YYYY-MM-DD hh:mm:ss 返回 DD
 *
 */
+ (NSString *)dayTransferWithString:(NSString *)string;
/**
 *YYYY-MM-DD hh:mm:ss 返回 MM
 *
 */
+ (NSString *)monthTransferWithString:(NSString *)string;
@end

NS_ASSUME_NONNULL_END
