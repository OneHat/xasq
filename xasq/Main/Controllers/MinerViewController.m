//
//  MinerViewController.m
//  xasq
//
//  Created by dssj on 2019/8/1.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "MinerViewController.h"
#import "InviteCodeView.h"

@interface MinerViewController ()

@end

@implementation MinerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //title
    [self initTitle];
    
    InviteCodeView *inviteCodeView = [[InviteCodeView alloc] initWithFrame:CGRectMake(0, 100, ScreenWidth, 140)];
    [self.view addSubview:inviteCodeView];
}

- (void)initTitle {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 150)];
    topView.backgroundColor = RGBColor(36, 69, 104);
    [self.view addSubview:topView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, StatusBarHeight, ScreenWidth, 44)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"矿工";
    titleLabel.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:titleLabel];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, StatusBarHeight, 44, 44)];
    [backButton setImage:[UIImage imageNamed:@"leftBar_back_white"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

#pragma mark-
- (void)backButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
