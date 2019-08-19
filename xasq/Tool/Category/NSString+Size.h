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

@end

NS_ASSUME_NONNULL_END
