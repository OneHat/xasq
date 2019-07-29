//
//  UIImage+Color.h
//  xasq
//
//  Created by dssj888@163.com on 2019/7/29.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Color)

/**
 *  生成纯色片
 */
+ (UIImage *)buttonImageFromColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
