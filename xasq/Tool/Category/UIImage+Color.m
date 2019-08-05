//
//  UIImage+Color.m
//  xasq
//
//  Created by dssj888@163.com on 2019/7/29.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "UIImage+Color.h"

@implementation UIImage (Color)

#pragma mark - 生产纯色片
+ (UIImage *)imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

/**
 *  拉伸图片
 */
- (UIImage *)resizeImageInCenter {
    CGFloat width = self.size.width * 0.5;
    CGFloat height = self.size.height * 0.5;
    
    UIEdgeInsets insets = UIEdgeInsetsMake(height, width, height, width);
    UIImage *result = [self resizableImageWithCapInsets:insets];
    
    return result;
}


@end
