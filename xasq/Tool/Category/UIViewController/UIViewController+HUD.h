//
//  UIViewController+HUD.h
//  xasq
//
//  Created by dssj on 2019/7/29.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^HideCompleteBlock)(void);

@interface UIViewController (HUD)

///加载
- (void)loading;
- (void)loadingWithText:(NSString *)text;

///自动消失的HUD
- (void)showMessage:(NSString *)text complete:(nullable HideCompleteBlock)complete;
- (void)showErrow:(NSError *)error complete:(nullable HideCompleteBlock)complete;

- (void)showMessage:(NSString *)text;
- (void)showErrow:(NSError *)error;

///自动消失的HUD
- (void)showMessageToWindow:(NSString *)text;

///隐藏HUD
- (void)hideHUD;

@end

NS_ASSUME_NONNULL_END
