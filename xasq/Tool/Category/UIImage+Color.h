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
+ (UIImage *)imageFromColor:(UIColor *)color;

/**
 *  拉伸图片
 */
- (UIImage *)resizeImageInCenter;
/**
 *  base64转图片
 */
+ (UIImage *)base64ChangeiImageWithStr:(NSString *)imageStr;

@end

NS_ASSUME_NONNULL_END
