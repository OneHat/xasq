//
//  UserGuideViewController.m
//  xasq
//
//  Created by dssj on 2019/8/6.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "UserGuideViewController.h"

@interface UserGuideViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation UserGuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.contentSize = CGSizeMake(ScreenWidth * 3, 0);
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    UIButton *startButton = [[UIButton alloc] initWithFrame:CGRectMake(0, ScreenHeight - BottomHeight - 96, 200, 36)];
    startButton.center = CGPointMake(ScreenWidth * 0.5, startButton.center.y);
    startButton.backgroundColor = ThemeColorBlue;
    startButton.layer.cornerRadius = CGRectGetHeight(startButton.frame) * 0.5;
    [startButton setTitle:@"立即体验" forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(startUse) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
    
}

- (void)startUse {
    if (self.dissmissGuide) {
        self.dissmissGuide();
    }
}

@end
