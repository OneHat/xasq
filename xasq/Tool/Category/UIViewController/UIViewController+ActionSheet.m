//
//  UIViewController+ActionSheet.m
//  xasq
//
//  Created by dssj on 2019/7/31.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "UIViewController+ActionSheet.h"
#import <objc/runtime.h>

const CGFloat TitleHeight = 30.0;
const CGFloat ItemsHeight = 44.0;
const CGFloat CloseHeight = 44.0;
const CGFloat SpaceHeight = 10.0;

static char ActionSheetBlockKey;

@implementation UIViewController (ActionSheet)

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
    UIViewController *contentViewController = [[UIViewController alloc] init];
    contentViewController.view.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
    contentViewController.modalPresentationStyle = UIModalPresentationOverFullScreen;
    
    
    //标题高度
    title = [title stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    BOOL titleExist = title.length > 0;
    CGFloat titleHeight = titleExist ? TitleHeight :0.0;
    
    //items最多显示8个
    if (items.count > 8) {
        items = [items subarrayWithRange:NSMakeRange(0, 8)];
    }
    
    CGFloat actionSheetHeight = items.count * ItemsHeight + titleHeight + CloseHeight + SpaceHeight;
    CGFloat actionSheetY = ScreenHeight - BottomHeight - actionSheetHeight;
    
    UIView *actionSheet = [[UIView alloc] initWithFrame:CGRectMake(0, actionSheetY, ScreenWidth, actionSheetHeight)];
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
        CGFloat buttonY = titleHeight + i * ItemsHeight + 0.5 * (i + 1);
        UIButton *actionButon = [[UIButton alloc] initWithFrame:CGRectMake(0, buttonY , ScreenWidth, ItemsHeight)];
        actionButon.tag = i;
        actionButon.backgroundColor = [UIColor whiteColor];
        actionButon.titleLabel.font = ThemeFontTipText;
        [actionButon setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [actionButon setTitle:items[i] forState:UIControlStateNormal];
        [actionButon addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [actionSheet addSubview:actionButon];
    }
    
    //关闭按钮
    UIButton *closeButon = [[UIButton alloc] initWithFrame:CGRectMake(0, actionSheetHeight - CloseHeight , ScreenWidth, CloseHeight)];
    closeButon.backgroundColor = [UIColor whiteColor];
    closeButon.titleLabel.font = ThemeFontNormalText;
    [closeButon setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    if (close) {
        [closeButon setTitle:close forState:UIControlStateNormal];
    } else {
        [closeButon setTitle:@"关闭" forState:UIControlStateNormal];
    }
    [closeButon addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    [actionSheet addSubview:closeButon];
    
    objc_setAssociatedObject(self, &ActionSheetBlockKey, complete, OBJC_ASSOCIATION_RETAIN);
    
    
    [self presentViewController:contentViewController animated:NO completion:^{
    }];
}

#pragma mark-
//关闭
- (void)closeAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

//点击item
- (void)buttonAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
    
    ActionSheetSelect block = objc_getAssociatedObject(self, &ActionSheetBlockKey);
    if (block) {
        block(sender.tag);
    }
}

@end
