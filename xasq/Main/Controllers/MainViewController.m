//
//  MainViewController.m
//  xasq
//
//  Created by dssj on 2019/7/26.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "MainViewController.h"
#import "InviteUserViewController.h"

#import "HomeNewsView.h"
#import "HomeChartsView.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *friendNewsHeight;

@property (weak, nonatomic) IBOutlet UIView *newsView;
@property (weak, nonatomic) IBOutlet UIView *chartView;

@end

@implementation MainViewController
    
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _friendNewsHeight.constant = 0;
    
    
    HomeNewsView *newsView = [[HomeNewsView alloc] initWithFrame:_newsView.bounds];
    newsView.newsArray = @[@{@"content":@"领取了256",@"time":@"30小时之前"},
                           @{@"content":@"偷取你的",@"time":@"2小时之前"},
                           @{@"content":@"2424234234234",@"time":@"3分钟之前"}];
    [_newsView addSubview:newsView];
    
    
    HomeChartsView *chartsView = [[HomeChartsView alloc] initWithFrame:_chartView.bounds];
    [_chartView addSubview:chartsView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (IBAction)inviteAction:(UIButton *)sender {
    
    InviteUserViewController *cc = [[InviteUserViewController alloc] init];
    cc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:cc animated:YES];
    
}


@end
