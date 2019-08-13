//
//  HomeViewController.m
//  xasq
//
//  Created by dssj on 2019/7/26.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "HomeViewController.h"
#import "InviteUserViewController.h"
#import "HomeMoreNewsViewController.h"
#import "MinerViewController.h"
#import "TaskViewController.h"
#import "LoginViewController.h"

#import "HomeNewsView.h"
#import "HomeBannerView.h"
#import "HomeRankView.h"
#import "RewardBallView.h"

#import "ApplicationData.h"
#import "BannerObject.h"
#import "HomeBannerView.h"
#import "UIViewController+ActionSheet.h"

NSString * const DSSJTabBarSelectHome = @"DSSJTabBarSelectHomeViewController";

static NSString *HomeBannerADCacheKey = @"HomeBannerADCacheKey";

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bannerViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rankViewHeight;

@property (weak, nonatomic) IBOutlet UIView *newsView;//动态View

@property (weak, nonatomic) IBOutlet UIView *bannerBackView;//广告view
@property (nonatomic, strong) HomeBannerView *bannerView;

@property (weak, nonatomic) IBOutlet UIView *rankView;//排行View

//隐藏导航栏时，是否需要动画
//从子页面需要，防止右滑返回时navbar不协调
//tabbar选择过来，不需要动画，否则会有阴影上移的效果
@property (assign, nonatomic) BOOL hideNavBarAnimation;

@end

@implementation HomeViewController
    
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11.0, *)) {
        _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    //动态
    HomeNewsView *newsView = [[HomeNewsView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 90)];
    newsView.newsArray = @[@{@"content":@"领取了256",@"time":@"30小时之前"},
                           @{@"content":@"偷取你的",@"time":@"2小时之前"},
                           @{@"content":@"2424234234234",@"time":@"3分钟之前"}];
    [_newsView addSubview:newsView];
    
    //广告banner
    _bannerView = [[HomeBannerView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    [_bannerBackView addSubview:_bannerView];
    _bannerViewHeight.constant = 0.0;
    
    NSArray *cacheBannerList = [[NSUserDefaults standardUserDefaults] objectForKey:HomeBannerADCacheKey];
    NSArray *bannerList = [BannerObject modelWithArray:cacheBannerList];
    if (bannerList.count > 0) {
        _bannerViewHeight.constant = 0.0;
        _bannerView.imageArray = bannerList;
    }
    
    //排行
    HomeRankView *rankView = [[HomeRankView alloc] initWithFrame:_rankView.bounds];
    rankView.HomeRankDataComplete = ^(CGFloat viewHeight) {
        self.rankViewHeight.constant = viewHeight;
    };
    [_rankView addSubview:rankView];
    
    //
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeMainHideAnimation)
                                                 name:DSSJTabBarSelectHome object:nil];
//    //能量球
//    NSInteger count = 5;//个数
//    CGFloat viewX = (ScreenWidth - 40 * count) * 0.5;
//    for (int i = 0; i < count; i++) {
//        
//        CGRect rect = CGRectMake(viewX + 40 * i, 150 + (arc4random() % 30) * pow(-1, i), 0, 0);
//        RewardBallView *ballView = [[RewardBallView alloc] initWithFrame:rect];
//        [self.view addSubview:ballView];
//    }
    
    
    //获取banner
    [self getHomeBannerData];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:_hideNavBarAnimation];
    _hideNavBarAnimation = YES;
    
//    if ([ApplicationData shareData].showNewVersion) {
//        [self showMessage:[ApplicationData shareData].updateInfo.upgradeDesc];
//    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)changeMainHideAnimation {
    _hideNavBarAnimation = NO;
}

- (void)getHomeBannerData {
    [[NetworkManager sharedManager] getRequest:OperationBanner parameters:@{@"type":@"2"} success:^(NSDictionary * _Nonnull data) {
        
        NSArray *dataList = data[@"data"];
        if (dataList && [dataList isKindOfClass:[NSArray class]] && dataList.count > 0) {
            [[NSUserDefaults standardUserDefaults] setObject:dataList forKey:HomeBannerADCacheKey];
            
            NSArray *bannerList = [BannerObject modelWithArray:dataList];
            
            self.bannerViewHeight.constant = 100;
            self.bannerView.imageArray = bannerList;
        }
        
    } failure:^(NSError * _Nonnull error) {
    }];
}

#pragma mark - 本页面按钮事件

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
    if ([UserDataManager shareManager].userId) {
        TaskViewController *taskVC = [[TaskViewController alloc] init];
        taskVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:taskVC animated:YES];
        
    } else {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        loginVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:loginVC animated:YES];
    }
}

- (IBAction)minerAction:(id)sender {
    MinerViewController *minerVC = [[MinerViewController alloc] init];
    minerVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:minerVC animated:YES];
}

- (IBAction)moreNewsAction:(UIButton *)sender {
    HomeMoreNewsViewController *moreNewsVC = [[HomeMoreNewsViewController alloc] init];
    moreNewsVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:moreNewsVC animated:YES];
    
}

@end
