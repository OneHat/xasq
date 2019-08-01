//
//  MainViewController.m
//  xasq
//
//  Created by dssj on 2019/7/26.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "MainViewController.h"
#import "InviteUserViewController.h"
#import "HomeMoreNewsViewController.h"

#import "HomeNewsView.h"
#import "HomeChartsView.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *friendNewsHeight;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chartViewHeight;

@property (weak, nonatomic) IBOutlet UIView *newsView;
@property (weak, nonatomic) IBOutlet UIView *chartView;

@end

@implementation MainViewController
    
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _scrollView.bounces = NO;
    
//    _friendNewsHeight.constant = 0;
    
    HomeNewsView *newsView = [[HomeNewsView alloc] initWithFrame:_newsView.bounds];
    newsView.newsArray = @[@{@"content":@"领取了256",@"time":@"30小时之前"},
                           @{@"content":@"偷取你的",@"time":@"2小时之前"},
                           @{@"content":@"2424234234234",@"time":@"3分钟之前"}];
    [_newsView addSubview:newsView];
    
    
    HomeChartsView *chartsView = [[HomeChartsView alloc] initWithFrame:_chartView.bounds];
    chartsView.HomeChartsDataComplete = ^(CGFloat viewHeight) {
        self.chartViewHeight.constant = viewHeight;
    };
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


#pragma mark-本页面按钮事件

- (IBAction)messageAction:(UIButton *)sender {
}

- (IBAction)helpAction:(UIButton *)sender {
}

- (IBAction)inviteAction:(UIButton *)sender {
    
    InviteUserViewController *inviteUserVC = [[InviteUserViewController alloc] init];
    inviteUserVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:inviteUserVC animated:YES];
    
}

- (IBAction)friendsAction:(UIButton *)sender {
}


- (IBAction)taskAction:(UIButton *)sender {
}


- (IBAction)moreNewsAction:(UIButton *)sender {
    HomeMoreNewsViewController *moreNewsVC = [[HomeMoreNewsViewController alloc] init];
    moreNewsVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:moreNewsVC animated:YES];
}

@end
