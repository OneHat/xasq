//
//  HomeViewController.m
//  xasq
//
//  Created by dssj on 2019/7/26.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "HomeViewController.h"
#import "FriendsViewController.h"
#import "HomeMoreNewsViewController.h"
#import "MinerViewController.h"
#import "TaskViewController.h"
#import "LoginViewController.h"
#import "WebViewController.h"

#import "HomeNewsView.h"
#import "HomeBannerView.h"
#import "HomeRankView.h"
#import "RewardBallView.h"

#import "ApplicationData.h"
#import "BannerObject.h"
#import "HomeBannerView.h"
#import "UIViewController+ActionSheet.h"

#import "UserStepManager.h"

static NSString *HomeBannerADCacheKey = @"HomeBannerADCacheKey";

@interface HomeViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bannerViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rankViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerImageTop;

@property (weak, nonatomic) IBOutlet UIView *newsView;//动态View
@property (weak, nonatomic) IBOutlet UIView *bannerBackView;//广告view
@property (nonatomic, strong) HomeBannerView *bannerView;

@property (weak, nonatomic) IBOutlet UIView *rankView;//排行View
@property (weak, nonatomic) IBOutlet UIView *stepRewardView;


@property (weak, nonatomic) IBOutlet UIImageView *userHeaderImageView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;

///这几个页面，没有登录时，需要隐藏
@property (weak, nonatomic) IBOutlet UIImageView *userLevelImageView;
@property (weak, nonatomic) IBOutlet UILabel *userLevelLabel;
@property (weak, nonatomic) IBOutlet UIImageView *powerImageView;
@property (weak, nonatomic) IBOutlet UILabel *powerLabel;


//隐藏导航栏时，是否需要动画
//从子页面需要，防止右滑返回时navbar不协调
//tabbar选择过来，不需要动画，否则会有阴影上移的效果
@property (assign, nonatomic) BOOL hideNavBarAnimation;

@property (nonatomic, strong) UIView *unLoginNewsMaskView;//没有登录时，动态页面的遮挡

@end

@implementation HomeViewController

- (UIView *)unLoginNewsMaskView {
    if (!_unLoginNewsMaskView) {
        _unLoginNewsMaskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 195)];
        _unLoginNewsMaskView.backgroundColor = [UIColor whiteColor];
        
        UIButton *loginButton = [[UIButton alloc] initWithFrame:_unLoginNewsMaskView.bounds];
        [loginButton setTitle:@"请登录查看" forState:UIControlStateNormal];
        [loginButton setTitleColor:ThemeColorBlue forState:UIControlStateNormal];
        [loginButton addTarget:self action:@selector(toLoginController) forControlEvents:UIControlEventTouchUpInside];
        [_unLoginNewsMaskView addSubview:loginButton];
    }
    
    return _unLoginNewsMaskView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11.0, *)) {
        _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    if (IphoneX) {
        self.headerImageTop.constant = 40;
    }
    
    //动态
    HomeNewsView *newsView = [[HomeNewsView alloc] initWithFrame:CGRectMake(0, 40, ScreenWidth, 90)];
//    newsView.newsArray = @[@{@"content":@"领取了256",@"time":@"30小时之前"},
//                           @{@"content":@"偷取你的",@"time":@"2小时之前"},
//                           @{@"content":@"2424234234234",@"time":@"3分钟之前"}];
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
    
    WeakObject
    _bannerView.ImageClickBlock = ^(NSString * _Nonnull linkPath) {
        WebViewController *webVC = [[WebViewController alloc] init];
        webVC.urlString = linkPath;
        webVC.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:webVC animated:YES];
    };
    
    //排行
    HomeRankView *rankView = [[HomeRankView alloc] initWithFrame:_rankView.bounds];
    rankView.HomeRankDataComplete = ^(CGFloat viewHeight) {
        self.rankViewHeight.constant = viewHeight;
    };
    [_rankView addSubview:rankView];
    
    //获取banner
    [self getHomeBannerData];
    
//    //用户步行奖励
//    [self getUserStepReward];
//
//    //用户算力奖励
//    [self getUserPowerReward];
    
    [[UserStepManager manager] getTodayStepsCompletion:^(NSInteger steps) {
    }];
    
    ////////
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(changeMainHideAnimation)
                                                 name:DSSJTabBarSelectHomeNotification
                                               object:nil];
    //登录成功
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(userLoginSuccess)
                                                 name:DSSJUserLoginSuccessNotification
                                               object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:_hideNavBarAnimation];
    _hideNavBarAnimation = YES;
    
    [self reloadHomeView];
    
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

#pragma mark - 网络请求
///获取banner
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

///用户步行奖励
- (void)getUserStepReward {
    if (![UserDataManager shareManager].userId) {
        return;
    }
    [[NetworkManager sharedManager] getRequest:CommunitySendWalk parameters:@{@"userId":[UserDataManager shareManager].userId,@"userWalk":@"6666"} success:^(NSDictionary * _Nonnull data) {
        
        [self.stepRewardView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        NSArray *dateList = data[@"data"];
        if (dateList && [dateList isKindOfClass:[NSArray class]] && dateList.count) {
            NSDictionary *stepReward = dateList.firstObject;
            
            RewardModel *model = [RewardModel modelWithDictionary:stepReward];
            
            RewardBallView *ballView = [[RewardBallView alloc] initWithFrame:self.stepRewardView.bounds];
            ballView.rewardModel = model;
            [self.stepRewardView addSubview:ballView];
        }
        
    } failure:^(NSError * _Nonnull error) {
    }];
}

///用户算力奖励
- (void)getUserPowerReward {
    if (![UserDataManager shareManager].userId) {
        return;
    }
    
    [[NetworkManager sharedManager] getRequest:CommunitySendPower parameters:@{@"userId":[UserDataManager shareManager].userId} success:^(NSDictionary * _Nonnull data) {
        
        NSArray *dateList = data[@"data"];
        if (dateList && [dateList isKindOfClass:[NSArray class]] && dateList.count) {
            
            //清除可能存在的view
            [self.stepRewardView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            for (UIView *view in self.scrollView.subviews) {
                if ([view isKindOfClass:[RewardBallView class]]) {
                    [view removeFromSuperview];
                }
            }
            
            NSArray *rewards = [RewardModel modelWithArray:dateList];
            
            //能量球
            NSInteger count = MIN(5, rewards.count);//个数
            CGFloat viewX = (ScreenWidth - 40 * count) * 0.5;
            for (int i = 0; i < count; i++) {
        
                CGRect rect = CGRectMake(viewX + 40 * i, 150 + (arc4random() % 30) * pow(-1, i), 0, 0);
                RewardBallView *ballView = [[RewardBallView alloc] initWithFrame:rect];
                ballView.rewardModel = rewards[i];
                [self.scrollView addSubview:ballView];
                
                __weak RewardBallView *weakBall = ballView;
                ballView.RewardTakeSuccess = ^{
                    
                    [UIView animateWithDuration:0.3 animations:^{
                        weakBall.bounds = CGRectMake(0, 0, 1, 1);
                        weakBall.center = self.userHeaderImageView.center;
                    } completion:^(BOOL finished) {
                        [weakBall removeFromSuperview];
                    }];
                };
            }
            
        }
        
    } failure:^(NSError * _Nonnull error) {
    }];
}

///上传用户步数
- (void)postUserStepCount:(NSInteger)steps {
    if (![UserDataManager shareManager].userId) {
        return;
    }
    
    NSDictionary *parameters = @{@"userId":[UserDataManager shareManager].userId,
                                 @"userWalk":[NSString stringWithFormat:@"%ld",steps]};
    [[NetworkManager sharedManager] postRequest:UserSyncWalk parameters:parameters success:^(NSDictionary * _Nonnull data) {
    } failure:^(NSError * _Nonnull error) {
    }];
}

#pragma mark - 本页面按钮事件

- (IBAction)messageAction:(UIButton *)sender {
}

- (IBAction)helpAction:(UIButton *)sender {
}

- (IBAction)inviteAction:(UIButton *)sender {
    
}

- (IBAction)friendsAction:(UIButton *)sender {
    if ([UserDataManager shareManager].userId) {
        FriendsViewController *friendsVC = [[FriendsViewController alloc] init];
        friendsVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:friendsVC animated:YES];
        
    } else {
        [self showMessage:@"请先登录"];
    }
    
}

- (IBAction)taskAction:(UIButton *)sender {
    if ([UserDataManager shareManager].userId) {
        TaskViewController *taskVC = [[TaskViewController alloc] init];
        taskVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:taskVC animated:YES];
        
    } else {
        [self showMessage:@"请先登录"];
    }
}

- (IBAction)minerAction:(id)sender {
    if ([UserDataManager shareManager].userId) {
        MinerViewController *minerVC = [[MinerViewController alloc] init];
        minerVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:minerVC animated:YES];
        
    } else {
        [self showMessage:@"请先登录"];
    }
    
}

- (IBAction)moreNewsAction:(UIButton *)sender {
    
//    NSInteger type = 2;
//    if (type == 1) {
//        [self getUserStepReward];
//    } else if (type == 2) {
//        [self getUserPowerReward];
//    } else if (type == 3) {
//        
//        NSDictionary *parameters = @{@"bId":@"929144389521117184",@"userId":@"11",@"sourceUserId":[UserDataManager shareManager].userId};
//        
//        [[NetworkManager sharedManager] postRequest:CommunityAreaStealCurrency parameters:parameters success:^(NSDictionary * _Nonnull data) {
//            
//        } failure:^(NSError * _Nonnull error) {
//            [self showErrow:error];
//        }];
//        
//    }
//    return;
    
    HomeMoreNewsViewController *moreNewsVC = [[HomeMoreNewsViewController alloc] init];
    moreNewsVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:moreNewsVC animated:YES];
}

- (IBAction)headerClick:(UIButton *)sender {
    if (![UserDataManager shareManager].userId) {
        [self toLoginController];
    }
}

#pragma mark -
- (void)toLoginController {
    
    [self alertWithMessage:@"请先登录" items:@[@"取消",@"确定"] action:^(NSInteger index) {
        [self dismissViewControllerAnimated:NO completion:^{
            if (index == 1) {
                LoginViewController *loginVC = [[LoginViewController alloc] init];
                loginVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:loginVC animated:NO];

                self.hideNavBarAnimation = NO;
            }
        }];
    }];
}

///登录成功
- (void)userLoginSuccess {
    
    [[UserStepManager manager] getTodayStepsCompletion:^(NSInteger steps) {
        [self postUserStepCount:steps];
    }];
}

- (void)reloadHomeView {
    
    if ([UserDataManager shareManager].userId) {
        //已经登录
        [self.unLoginNewsMaskView removeFromSuperview];
        self.unLoginNewsMaskView = nil;
        
        self.nicknameLabel.text = [UserDataManager shareManager].usermodel.nickName;
        
        
    } else {
        //尚未登录
        [self.newsView addSubview:self.unLoginNewsMaskView];
        
        self.nicknameLabel.text = @"请登录";
        
        self.userLevelImageView.hidden = YES;
        self.userLevelLabel.hidden = YES;
        self.powerImageView.hidden = YES;
        self.powerLabel.hidden = YES;
        
    }
}

@end
