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

@end
