//
//  UIViewController+HUD.m
//  xasq
//
//  Created by dssj on 2019/7/29.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "UIViewController+HUD.h"
#import <MBProgressHUD/MBProgressHUD.h>

@implementation UIViewController (HUD)

- (void)loading {
    [self showMessage:nil toView:self.view hide:NO];
}

- (void)loadingWithText:(NSString *)text {
    [self showMessage:text toView:self.view hide:NO];
}

- (void)showMessage:(NSString *)text {
    [self showMessage:text toView:self.view hide:YES];
}

- (void)showErrow:(NSError *)error {
    
}

- (void)hideHUD {
    [self hideHUDForView:self.view animated:YES];
}

#pragma mark-
- (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view hide:(BOOL)hide {
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.bezelView.color = [UIColor blackColor];
    hud.contentColor = [UIColor whiteColor];
    
    if (message.length > 0) {
        hud.mode = MBProgressHUDModeText;
        hud.label.numberOfLines = 0;
        hud.label.font = [self hudTextFont];
        hud.margin = [self hudTextMargin];
        hud.label.text = message;
    }
    if (hide) {
        [hud hideAnimated:YES afterDelay:1.5];
    }
    
    return hud;
}

- (void)hideHUDForView:(UIView *)view animated:(BOOL)animated {
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    
    [MBProgressHUD hideHUDForView:view animated:animated];
}

//字体
- (UIFont *)hudTextFont {
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    UIFont *textFont;
    if (screenW == 320.0) {
        textFont = [UIFont boldSystemFontOfSize:15];
    } else if (screenW == 375.0) {
        textFont = [UIFont boldSystemFontOfSize:16];
    } else {
        textFont = [UIFont boldSystemFontOfSize:17];
    }
    
    return textFont;
}

//边距
- (CGFloat)hudTextMargin {
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGFloat margin;
    if (screenW == 320.0) {
        margin = 13;
    } else if (screenW == 375.0) {
        margin = 15;
    } else {
        margin = 17;
    }
    return margin;
}
@end
