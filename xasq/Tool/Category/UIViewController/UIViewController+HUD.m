//
//  UIViewController+HUD.m
//  xasq
//
//  Created by dssj on 2019/7/29.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "UIViewController+HUD.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <objc/runtime.h>

static char HUDBlockKey;

const NSTimeInterval HideDuration = 1.0;

@implementation UIViewController (HUD)

- (void)loading {
    [self showMessage:nil toView:nil hide:NO];
}

- (void)loadingWithText:(NSString *)text {
    [self showMessage:text toView:nil hide:NO];
}

- (void)showMessage:(NSString *)text complete:(nullable HideCompleteBlock)complete {
    [self showMessage:text toView:nil hide:YES];
    if (complete) {
        objc_setAssociatedObject(self, &HUDBlockKey, complete, OBJC_ASSOCIATION_RETAIN);
    }
}

- (void)showMessage:(NSString *)text {
    [self showMessage:text complete:nil];
}

- (void)showErrow:(NSError *)error complete:(nullable HideCompleteBlock)complete {
    NSString *text = error.userInfo[ErrorMessageKeyXasq];
    [self showMessage:text toView:nil hide:YES];
}

- (void)showErrow:(NSError *)error {
    [self showErrow:error complete:nil];
}

- (void)hideHUD {
    [self hideHUDForView:nil animated:YES];
}

#pragma mark-
- (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view hide:(BOOL)hide {
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    view = [UIApplication sharedApplication].keyWindow;
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
        [hud hideAnimated:YES afterDelay:HideDuration];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(HideDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            HideCompleteBlock block = objc_getAssociatedObject(self, &HUDBlockKey);
            if (block) {
                block();
            }
        });
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
    return ThemeFontText;
//    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
//    UIFont *textFont;
//    if (screenW == 320.0) {
//        textFont = [UIFont boldSystemFontOfSize:15];
//    } else if (screenW == 375.0) {
//        textFont = [UIFont boldSystemFontOfSize:16];
//    } else {
//        textFont = [UIFont boldSystemFontOfSize:17];
//    }
//
//    return textFont;
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
