//
//  UIColor+FX.h
//  SesameFX
//
//  Created by qianluo on 17/2/28.
//  Copyright © 2017年 qianluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (FX)

+ (UIColor *)colorWithHexString:(NSString *)color;
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
