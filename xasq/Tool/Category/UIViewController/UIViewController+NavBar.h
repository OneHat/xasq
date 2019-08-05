//
//  UIViewController+NavBar.h
//  xasq
//
//  Created by dssj888@163.com on 2019/7/29.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (NavBar)

/**
 *  设置导航左键图片
 */
- (void)initLeftBtnWithImage:(UIImage *)image;
/**
 *  设置导航左键title
 */
- (void)initLeftBtnWithTitle:(NSString *)title color:(UIColor *)color;
/**
 *  设置导航右键图片
 */
- (void)initRightBtnWithImage:(UIImage *)image;
/**
 *  设置导航右键title
 */
- (void)initRightBtnWithTitle:(NSString *)title color:(UIColor *)color;
/**
 *  设置导航title颜色
 */
- (void)setNavBarTitleColor:(UIColor *)color;
/**
 *  导航左方法
 */
- (void)leftBtnAction;
/**
 *  导航右方法
 */
- (void)rightBtnAction;

/**
 *  导航栏颜色
 */
- (void)setNavBarBackGroundColor:(UIColor *)color;


/**
 *  返回按钮图片(如果传nil,则显示默认图片)
 */
- (void)setNavBarBackIndicatorImage:(nullable UIImage *)image;


@end

NS_ASSUME_NONNULL_END
