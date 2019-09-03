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
 *年月日转换成Date
 *
 */
+ (NSDate *)stringTransferToDate:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
