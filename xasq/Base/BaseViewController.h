//
//  BaseViewController.h
//  xasq
//
//  Created by dssj888@163.com on 2019/7/29.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseViewController : UIViewController

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
- (void)setNavBarColor;
/**
 *  去掉tableView 多余行线
 */
- (void)setExtraCellLineHidden:(UITableView *)tableView ;
/**
 *  导航左方法
 */
- (void)leftBtnAction;
/**
 *  导航右方法
 */
- (void)rightBtnAction;

@end

NS_ASSUME_NONNULL_END
