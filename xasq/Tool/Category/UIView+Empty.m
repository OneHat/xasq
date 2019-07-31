//
//  UIView+Empty.m
//  xasq
//
//  Created by dssj on 2019/7/30.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "UIView+Empty.h"
#import <objc/runtime.h>

static char emptyViewKey;
static char emptyBlockKey;

@implementation UIView (Empty)

- (void)showEmptyView:(EmptyViewReason)reason refreshBlock:(nullable RefreshBlock)block; {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    ///背景view
    UIView *backView = [[UIView alloc] initWithFrame:self.bounds];
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];
    
    ///中间内容
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth)];
    contentView.center = backView.center;
    [backView addSubview:contentView];
    
    UIFont *font = [UIFont systemFontOfSize:13];
    
    if (reason == EmptyViewReasonNoData) {
        //没有数据
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, contentView.frame.size.width, 50)];
        imageView.backgroundColor = [UIColor lightGrayColor];
        [contentView addSubview:imageView];
        
        UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame), contentView.frame.size.width, 60)];
        tipLabel.numberOfLines = 0;
        tipLabel.font = font;
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.text = @"抱歉，您访问的页面不存在\n\n去看看别的吧~";
        [contentView addSubview:tipLabel];
        
    } else if (reason == EmptyViewReasonNoNetwork) {
        //没有网络
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, contentView.frame.size.width, 50)];
        imageView.backgroundColor = [UIColor lightGrayColor];
        [contentView addSubview:imageView];
        
        UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame), contentView.frame.size.width, 30)];
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.text = @"网络出问题了";
        tipLabel.font = font;
        [contentView addSubview:tipLabel];
        
        UIButton *refreshButton = [[UIButton alloc] initWithFrame:CGRectMake((ScreenWidth - 100)*0.5, CGRectGetMaxY(tipLabel.frame), 100, 40)];
        [refreshButton setTitle:@"点击刷新" forState:UIControlStateNormal];
        refreshButton.titleLabel.font = font;
        [refreshButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [refreshButton addTarget:self action:@selector(refreshAction:) forControlEvents:UIControlEventTouchUpInside];
        [contentView addSubview:refreshButton];
    }
    
    objc_setAssociatedObject(self, &emptyViewKey, backView, OBJC_ASSOCIATION_RETAIN);
    if (block) {
        objc_setAssociatedObject(self, &emptyBlockKey, block, OBJC_ASSOCIATION_RETAIN);
    }
}

- (void)hideEmptyView {
    UIView *emptyView = objc_getAssociatedObject(self, &emptyViewKey);
    [emptyView removeFromSuperview];
}

#pragma mark-
- (void)refreshAction:(UIButton *)sender {
    RefreshBlock block = objc_getAssociatedObject(self, &emptyBlockKey);
    if (block) {
        block();
    }
}

@end
