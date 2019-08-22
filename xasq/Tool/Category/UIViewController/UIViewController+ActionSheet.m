//
//  UIViewController+ActionSheet.m
//  xasq
//
//  Created by dssj on 2019/7/31.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "UIViewController+ActionSheet.h"
#import <objc/runtime.h>
#import "XLPasswordInputView.h"

///********  ActionSheet
const CGFloat SheetTitleHeight = 30.0;
const CGFloat SheetItemsHeight = 50.0;
const CGFloat SheetCloseHeight = 50.0;
const CGFloat SheetSpaceHeight = 10.0;

static char ActionSheetBlockKey;

///********  Alert
const CGFloat AlertTitleHeight = 55.0;
const CGFloat AlertActionHeight = 42.0;
const CGFloat AlertSpaceWidth = 10.0;

static char AlertBlockKey;

@implementation UIViewController (ActionSheet)

- (UIViewController *)customerController {
    //弹出controller
    UIViewController *contentViewController = [[UIViewController alloc] init];
    contentViewController.view.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
    contentViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    
    return contentViewController;
}

#pragma mark -
/// 没有标题，关闭按钮默认“关闭”
- (void)actionSheetWithItems:(NSArray<NSString *> *)items complete:(nonnull ActionSheetSelect)complete {
    [self actionSheetWithTitle:nil close:nil items:items complete:complete];
}

- (void)actionSheetWithTitle:(NSString *)title
                       close:(NSString *)close
                       items:(NSArray<NSString *> *)items
                    complete:(nonnull ActionSheetSelect)complete {
    if (items.count == 0) {
        return;
    }
    
    //弹出controller
    UIViewController *contentViewController = [self customerController];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:contentViewController action:@selector(sheetCloseAction:)];
    [contentViewController.view addGestureRecognizer:tap];
    
    //标题高度
    title = [title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    BOOL titleExist = title.length > 0;
    CGFloat titleHeight = titleExist ? SheetTitleHeight :0.0;
    
    //items最多显示8个
    if (items.count > 8) {
        items = [items subarrayWithRange:NSMakeRange(0, 8)];
    }
    
    CGFloat actionSheetHeight = items.count * SheetItemsHeight + titleHeight + SheetCloseHeight + SheetSpaceHeight;
    CGFloat actionSheetY = ScreenHeight - BottomHeight - actionSheetHeight;
    
    UIView *actionSheet = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight, ScreenWidth, actionSheetHeight)];
    actionSheet.backgroundColor = ThemeColorBackground;
    [contentViewController.view addSubview:actionSheet];
    
    if (titleExist) {
        //标题
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, titleHeight)];
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = title;
        titleLabel.font = ThemeFontTipText;
        [actionSheet addSubview:titleLabel];
    }
    
    //按钮
    for (int i = 0; i < items.count; i++) {
        CGFloat buttonY = titleHeight + i * SheetItemsHeight + 1.0 * (i + 1);
        UIButton *actionButon = [[UIButton alloc] initWithFrame:CGRectMake(0, buttonY , ScreenWidth, SheetItemsHeight)];
        actionButon.tag = i;
        actionButon.backgroundColor = [UIColor whiteColor];
        actionButon.titleLabel.font = ThemeFontText;
        [actionButon setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [actionButon setTitle:items[i] forState:UIControlStateNormal];
        [actionButon addTarget:self action:@selector(sheetButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [actionSheet addSubview:actionButon];
    }
    
    //关闭按钮
    UIButton *closeButon = [[UIButton alloc] initWithFrame:CGRectMake(0, actionSheetHeight - SheetCloseHeight , ScreenWidth, SheetCloseHeight)];
    closeButon.backgroundColor = [UIColor whiteColor];
    closeButon.titleLabel.font = ThemeFontText;
    [closeButon setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (close) {
        [closeButon setTitle:close forState:UIControlStateNormal];
    } else {
        [closeButon setTitle:@"关闭" forState:UIControlStateNormal];
    }
    [closeButon addTarget:self action:@selector(sheetCloseAction:) forControlEvents:UIControlEventTouchUpInside];
    [actionSheet addSubview:closeButon];
    
    objc_setAssociatedObject(self, &ActionSheetBlockKey, complete, OBJC_ASSOCIATION_COPY);
    
    [self presentViewController:contentViewController animated:NO completion:^{
        [UIView animateWithDuration:0.2 animations:^{
            actionSheet.frame = CGRectMake(0, actionSheetY, ScreenWidth, actionSheetHeight);
        }];
    }];
}

//关闭
- (void)sheetCloseAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

//点击item
- (void)sheetButtonAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
    
    ActionSheetSelect block = objc_getAssociatedObject(self, &ActionSheetBlockKey);
    if (block) {
        block(sender.tag);
    }
}

#pragma mark ------    Alert
- (void)alertWithMessage:(NSString *)message
                   items:(NSArray<NSString *> *)items
                  action:(AlertActionClick)action {
    [self alertWithTitle:nil message:message items:items action:action];
}

- (void)alertWithTitle:(nullable NSString *)title message:(NSString *)message items:(NSArray<NSString *> *)items action:(AlertActionClick)action {
    
    [self alertWithTitle:title message:message items:items action:action input:NO];
}

- (void)alertInputWithTitle:(nullable NSString *)title items:(NSArray<NSString *> *)items action:(AlertActionClick)action {
    
    [self alertWithTitle:title message:nil items:items action:action input:YES];
}

///私有方法
- (void)alertWithTitle:(nullable NSString *)title message:(NSString *)message items:(NSArray<NSString *> *)items action:(AlertActionClick)action input:(BOOL)input {
    
    if (items.count == 0) {
        return;
    }
    
    CGFloat AlertMessageHeight = ScreenWidth / 375.0 * 100.0;
    if (input) {
        AlertMessageHeight = 100;
    }
    
    //弹出controller
    UIViewController *contentViewController = [self customerController];
    
    //标题高度
    title = [title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    BOOL titleExist = title.length > 0;
    CGFloat titleHeight = titleExist ? AlertTitleHeight :10.0;
    
    //items最多显示3个
    if (items.count > 3) {
        items = [items subarrayWithRange:NSMakeRange(0, 3)];
    }
    
    CGFloat alertHeight = titleHeight + AlertMessageHeight + AlertActionHeight + 25;
    CGFloat alertWidth = ScreenWidth - 30 * 2;
    CGFloat actionSheetY = (ScreenHeight - BottomHeight - alertHeight) * 0.5;
    if (input) {
        actionSheetY = ScreenHeight - alertHeight - 258 - 44;
    }
    
    UIView *alertView = [[UIView alloc] initWithFrame:CGRectMake(30, actionSheetY, alertWidth, alertHeight)];
    alertView.layer.cornerRadius = 5;
    alertView.layer.masksToBounds = YES;
    alertView.backgroundColor = [UIColor whiteColor];
    [contentViewController.view addSubview:alertView];
    
    if (titleExist) {
        //标题
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, alertWidth, titleHeight)];
        titleLabel.backgroundColor = [UIColor whiteColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.text = title;
        titleLabel.font = ThemeFontText;
        [alertView addSubview:titleLabel];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLabel.frame), alertWidth, 1)];
        lineView.backgroundColor = ThemeColorLine;
        [alertView addSubview:lineView];
    }
    
    if (input) {
        XLPasswordInputView *passwordInputView = [XLPasswordInputView passwordInputViewWithPasswordLength:6];
        passwordInputView.gridLineColor = [UIColor colorWithHexString:@"ccccce"];
        passwordInputView.gridLineWidth = 1;
        passwordInputView.dotColor = [UIColor colorWithHexString:@"ccccce"];
        passwordInputView.dotWidth = 20;
        passwordInputView.secureTextEntry = NO;
        passwordInputView.keyboardType = UIKeyboardTypeASCIICapable;
        passwordInputView.delegate = self;
        CGFloat gridWidth = 54 * (alertWidth / 375.0);
        CGRect frame = CGRectMake((alertWidth - 6 * gridWidth) * 0.5, titleHeight + (AlertMessageHeight - gridWidth) * 0.5, 6 * gridWidth, gridWidth);
        passwordInputView.frame = frame;
        [alertView addSubview:passwordInputView];
        
    } else {
        UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(AlertSpaceWidth,  titleHeight, alertWidth - AlertSpaceWidth * 2, AlertMessageHeight)];
        messageLabel.numberOfLines = 0;
        messageLabel.text = message;
        messageLabel.font = ThemeFontText;
        messageLabel.textAlignment = NSTextAlignmentCenter;
        [alertView addSubview:messageLabel];
    }
    
    //***********
//    CGFloat spaceWidth = 10;
//    CGFloat alertActionWidth = (alertWidth - (items.count + 1) * spaceWidth) / items.count;
//    alertActionWidth = ceil(alertActionWidth);
//    if (items.count == 1) {
//        ///只有一个按钮的时候
//        alertActionWidth = 120;
//        spaceWidth = (alertWidth - alertActionWidth) * 0.5;
//    }
    
    //************
    CGFloat alertActionWidth = 130;
    CGFloat spaceWidth = (alertWidth - alertActionWidth * (items.count)) / (items.count + 1);
    if (spaceWidth < 10) {
        spaceWidth = 10;
        alertActionWidth = (alertWidth - spaceWidth * (items.count + 1)) / items.count;
    }
    
    CGFloat buttonY = titleHeight + AlertMessageHeight;
    
    //按钮
    for (int i = 0; i < items.count; i++) {
        CGFloat buttonX = (spaceWidth + alertActionWidth) * i + spaceWidth;
        UIButton *actionButon = [[UIButton alloc] initWithFrame:CGRectMake(buttonX, buttonY, alertActionWidth, AlertActionHeight)];
        actionButon.tag = i;
        actionButon.backgroundColor = [UIColor whiteColor];
        actionButon.titleLabel.font = ThemeFontText;
        [actionButon setTitle:items[i] forState:UIControlStateNormal];
        
        actionButon.layer.masksToBounds = YES;
        actionButon.layer.cornerRadius = AlertActionHeight * 0.5;
        actionButon.layer.borderColor = ThemeColorBlue.CGColor;
        actionButon.layer.borderWidth = 0.5;
        [actionButon addTarget:self action:@selector(alertButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [alertView addSubview:actionButon];
        
        if (i == items.count - 1) {
            [actionButon setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [actionButon setBackgroundColor:ThemeColorBlue];
        } else {
            [actionButon setTitleColor:ThemeColorBlue forState:UIControlStateNormal];
            [actionButon setBackgroundColor:[UIColor whiteColor]];
            
        }
    }
    
    objc_setAssociatedObject(self, &AlertBlockKey, action, OBJC_ASSOCIATION_COPY);
    
    [self presentViewController:contentViewController animated:NO completion:^{
    }];
}

- (void)alertButtonAction:(UIButton *)sender {
//    [self dismissViewControllerAnimated:NO completion:nil];
    
    AlertActionClick block = objc_getAssociatedObject(self, &AlertBlockKey);
    if (block) {
        block(sender.tag);
    }
}

@end
