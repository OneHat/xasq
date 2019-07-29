//
//  BaseTool.h
//  xasq
//
//  Created by dssj888@163.com on 2019/7/29.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseTool : NSObject

/**
 *  生成纯色片
 */
+ (UIImage *)buttonImageFromColor:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
