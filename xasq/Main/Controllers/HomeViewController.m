//
//  HomeViewController.m
//  xasq
//
//  Created by dssj on 2019/7/26.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "HomeViewController.h"
#import "FriendsViewController.h"
#import "MoreNewsViewController.h"
#import "MinerViewController.h"
#import "TaskViewController.h"
#import "LoginViewController.h"
#import "InviteFriendViewController.h"
#import "WebViewController.h"
#import "MessageViewController.h"

#import "HomeNewsView.h"
#import "HomeBannerView.h"
#import "HomeRankView.h"
#import "RewardBallView.h"

#import "ApplicationData.h"
#import "BannerObject.h"
#import "UIViewController+ActionSheet.h"

#import "UserStepManager.h"

static NSString *HomeBannerADCacheKey = @"HomeBannerADCacheKey";
static NSString *HomeNewsCacheKey = @"HomeNewsCacheKey";

@interface HomeViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bannerViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rankViewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerImageTop;

@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UIView *newsBackView;//动态View
@property (strong, nonatomic) HomeNewsView *newsView;

@property (weak, nonatomic) IBOutlet UIView *bannerBackView;//广告view
@property (nonatomic, strong) HomeBannerView *bannerView;

@property (weak, nonatomic) IBOutlet UIView *rankBackView;//排行View
@property (strong, nonatomic) HomeRankView *rankView;//排行View
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rankBackViewBottom;

@property (weak, nonatomic) IBOutlet UIView *stepRewardView;
@property (weak, nonatomic) IBOutlet UIImageView *footerImageView;
@property (weak, nonatomic) IBOutlet UILabel *stepsLabel;

@property (weak, nonatomic) IBOutlet UIImageView *userHeaderImageView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *mineNameImageView;
@property (weak, nonatomic) IBOutlet UILabel *mineNameLabel;

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


@property (strong, nonatomic) UIView *customerBarView;

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
        self.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.rankBackViewBottom.constant = 0;
    }
    
    if (IphoneX) {
        self.headerImageTop.constant = 40;
    }
    
    self.scrollView.delegate = self;
    
    self.customerBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, NavHeight)];
    self.customerBarView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.customerBarView];
    
    //动态
    self.newsView = [[HomeNewsView alloc] initWithFrame:CGRectMake(0, 40, ScreenWidth, 90)];
    [self.newsBackView addSubview:self.newsView];
    NSArray *cacheNewsList = [[NSUserDefaults standardUserDefaults] objectForKey:HomeNewsCacheKey];
    NSArray *newsList = [UserNewsModel modelWithArray:cacheNewsList];
    if (newsList.count > 0) {
        self.newsView.newsArray = newsList;
    }
    
    //广告banner
    self.bannerView = [[HomeBannerView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
    [self.bannerBackView addSubview:self.bannerView];
    self.bannerViewHeight.constant = 0.0;
    
    NSArray *cacheBannerList = [[NSUserDefaults standardUserDefaults] objectForKey:HomeBannerADCacheKey];
    NSArray *bannerList = [BannerObject modelWithArray:cacheBannerList];
    if (bannerList.count > 0) {
        self.bannerViewHeight.constant = 100.0;
        self.bannerView.imageArray = bannerList;
    }
    
    WeakObject
    self.bannerView.ImageClickBlock = ^(NSString * _Nonnull linkPath) {
        WebViewController *webVC = [[WebViewController alloc] init];
        webVC.urlString = linkPath;
        webVC.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:webVC animated:YES];
    };
    
    //排行
    self.rankView = [[HomeRankView alloc] initWithFrame:self.rankBackView.bounds];
    self.rankView.HomeRankDataComplete = ^(CGFloat viewHeight) {
        weakSelf.rankViewHeight.constant = viewHeight;
    };
    [self.rankBackView addSubview:self.rankView];
    
    //获取banner
    [self getHomeBannerData];
    
    //用户步行奖励
    [self getUserStepReward];

    //用户算力奖励
    [self getUserPowerReward];
    
    //最新动态
    [self getUserNews];
    
    //当前算力、等级
    [self getUserLevelAndPower];
    
    if ([UserDataManager shareManager].userId) {
        [self postUserSteps];
    }
    
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
    
    
    
    self.mineNameLabel.text = @"西岸社区";
    self.mineNameImageView.image = [[UIImage imageNamed:@"mineName_background"] resizeImageInCenter ];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:_hideNavBarAnimation];
    _hideNavBarAnimation = YES;
    
    [self reloadHomeView];
    
    /**
    if ([ApplicationData shareData].showNewVersion) {
        UpdateInfoObject *updateInfo = [ApplicationData shareData].updateInfo;
        NSArray *items = (updateInfo.upgradeDesc ? @[@"确定"] : @[@"取消",@"确定"]);
        
        [self alertWithTitle:@"提示"
                     message:updateInfo.upgradeDesc
                       items:items
                      action:^(NSInteger index) {
                          if (index == 0 && !updateInfo.forceUpgrade) {
                              [self dismissViewControllerAnimated:NO completion:nil];
                              return;
                          }
                          
//                          NSURL *url = [NSURL URLWithString:updateInfo.download];
                          NSURL *url = [NSURL URLWithString:@"https://www.baidu.com"];
                          [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:^(BOOL success) {
                          }];
                          
                      }];
    }
    */
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
    [[NetworkManager sharedManager] getRequest:CommunitySendWalk parameters:nil success:^(NSDictionary * _Nonnull data) {
        
        [self.stepRewardView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        
        NSArray *dateList = data[@"data"];
        if (dateList && [dateList isKindOfClass:[NSArray class]] && dateList.count) {
            NSDictionary *stepReward = dateList.firstObject;
            
            RewardModel *model = [RewardModel modelWithDictionary:stepReward];
            
            RewardBallView *ballView = [[RewardBallView alloc] initWithFrame:self.stepRewardView.bounds];
            ballView.rewardModel = model;
            ballView.ballStyle = RewardBallViewStyleStep;
            
            __weak RewardBallView *weakBall = ballView;
            ballView.RewardBallClick = ^(NSInteger rewardId, RewardBallView * _Nonnull ballView) {
                [self userTakeReward:rewardId ballView:weakBall];
            };
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
    
    [[NetworkManager sharedManager] getRequest:CommunitySendPower parameters:nil success:^(NSDictionary * _Nonnull data) {
        
        NSArray *dateList = data[@"data"];
        if (!dateList || ![dateList isKindOfClass:[NSArray class]] || dateList.count == 0) {
            return;
        }
        
        //清除可能存在的view
        for (UIView *view in self.topView.subviews) {
            if ([view isKindOfClass:[RewardBallView class]]) {
                [view removeFromSuperview];
            }
        }
        
        NSArray *rewards = [RewardModel modelWithArray:dateList];
        //能量球
        NSInteger count = MIN(5, rewards.count);//个数
        NSMutableArray *frames = [self frameForRewardBallView:count];
        
        for (int i = 0; i < count; i++) {
            NSValue *rectValue = frames[i];
            
            RewardBallView *ballView = [[RewardBallView alloc] initWithFrame:rectValue.CGRectValue];
            ballView.rewardModel = rewards[i];
            ballView.ballStyle = RewardBallViewStylePower;
            [self.topView insertSubview:ballView belowSubview:self.userHeaderImageView];
            
            __weak RewardBallView *weakBall = ballView;
            ballView.RewardBallClick = ^(NSInteger rewardId, RewardBallView * _Nonnull ballView) {
                [self userTakeReward:rewardId ballView:weakBall];
            };
        }
        
    } failure:^(NSError * _Nonnull error) {
    }];
}

- (NSMutableArray *)frameForRewardBallView:(NSInteger)count {
    NSMutableArray *frames = [NSMutableArray arrayWithCapacity:count];
    CGFloat width = 60;
    
    for (int i = 0; i < count; i++) {
        
        CGFloat viewX = 10 + (arc4random() % 240);
        CGFloat viewY = 90 + (arc4random() % 100);
        
        BOOL flag = NO;
        CGRect rect = CGRectMake(viewX, viewY, width, width);
        
        do {
            flag = NO;
            
            for (NSValue *temp in frames) {
                CGRect tempRect = temp.CGRectValue;
                
                CGPoint center1 = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
                CGPoint center2 = CGPointMake(CGRectGetMidX(tempRect), CGRectGetMidY(tempRect));
                
                CGFloat distance = sqrt(pow(center1.x - center2.x, 2) + pow(center1.y - center2.y, 2));
                if (distance < width) {
                    flag = YES;
                }
            }
            
            if (flag) {
                viewX = 20 + (arc4random() % 240);
                viewY = 90 + (arc4random() % 100);
                
                rect = CGRectMake(viewX, viewY, width, width);
                
            } else {
                [frames addObject:[NSValue valueWithCGRect:rect]];
            }
        } while (flag);
        
    }
    
    return frames;
}

///上传用户步数
- (void)postUserStepCount:(NSInteger)steps {
    if (![UserDataManager shareManager].userId) {
        return;
    }
    
//    NSDictionary *parameters = @{@"userId":[UserDataManager shareManager].userId,
//                                 @"userWalk":[NSString stringWithFormat:@"%ld",steps]};
    NSDictionary *parameters = @{@"userWalk":[NSString stringWithFormat:@"%d",6666]};
    [[NetworkManager sharedManager] postRequest:UserSyncWalk parameters:parameters success:^(NSDictionary * _Nonnull data) {
    } failure:^(NSError * _Nonnull error) {
    }];
}

///用户收取奖励
- (void)userTakeReward:(NSInteger)rewardId ballView:(RewardBallView *)ballView {
    
    NSDictionary *parameters = @{@"bId":[NSString stringWithFormat:@"%ld",rewardId]};
    [[NetworkManager sharedManager] postRequest:CommunityAreaTakeCurrency parameters:parameters success:^(NSDictionary * _Nonnull data) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            CGPoint p = self.userHeaderImageView.center;
            CGAffineTransform t = CGAffineTransformMakeTranslation(p.x - ballView.center.x, p.y - ballView.center.y);
            ballView.transform = CGAffineTransformScale(t, 0.1, 0.1);
            
        } completion:^(BOOL finished) {
            [ballView removeFromSuperview];
        }];
        
    } failure:^(NSError * _Nonnull error) {
        [ballView resetButtonEnable];
    }];
}

///最新动态
- (void)getUserNews {
    [[NetworkManager sharedManager] postRequest:CommunityStealFlow parameters:nil success:^(NSDictionary * _Nonnull data) {
        
        NSArray *dateList = data[@"data"][@"rows"];
        if (!dateList || ![dateList isKindOfClass:[NSArray class]] || dateList.count == 0) {
            return;
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:dateList forKey:HomeNewsCacheKey];
        
        NSArray *newsList = [UserNewsModel modelWithArray:dateList];
        self.newsView.newsArray = newsList;
        
    } failure:^(NSError * _Nonnull error) {
    }];
}

///用户等级算力
- (void)getUserLevelAndPower {
    [[NetworkManager sharedManager] getRequest:CommunityPowerUpinfo parameters:nil success:^(NSDictionary * _Nonnull data) {
        
        NSDictionary *powInfo = data[@"data"];
        if (powInfo && [powInfo isKindOfClass:[NSDictionary class]]) {
            self.powerLabel.text = [NSString stringWithFormat:@"算力%@",powInfo[@"userPower"]];
        }
    } failure:^(NSError * _Nonnull error) {
    }];
    
}

#pragma mark - 本页面按钮事件

- (IBAction)messageAction:(UIButton *)sender {
    if (![UserDataManager shareManager].userId) {
        [self showMessage:@"请先登录"];
        return;
    }
    
    MessageViewController *messageVC = [[MessageViewController alloc] init];
    messageVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:messageVC animated:YES];
}

- (IBAction)helpAction:(UIButton *)sender {
    
}

- (IBAction)inviteAction:(UIButton *)sender {
    if (![UserDataManager shareManager].userId) {
        [self showMessage:@"请先登录"];
        return;
    }
    
    InviteFriendViewController *inviteFriendsVC = [[InviteFriendViewController alloc] init];
    inviteFriendsVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:inviteFriendsVC animated:YES];
}

- (IBAction)friendsAction:(UIButton *)sender {
    if (![UserDataManager shareManager].userId) {
        [self showMessage:@"请先登录"];
        return;
    }
    
    FriendsViewController *friendsVC = [[FriendsViewController alloc] init];
    friendsVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:friendsVC animated:YES];
    
}

- (IBAction)taskAction:(UIButton *)sender {
    if (![UserDataManager shareManager].userId) {
        [self showMessage:@"请先登录"];
        return;
    }
    
    TaskViewController *taskVC = [[TaskViewController alloc] init];
    taskVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:taskVC animated:YES];
}

- (IBAction)minerAction:(id)sender {
    if (![UserDataManager shareManager].userId) {
        [self showMessage:@"请先登录"];
        return;
    }
    
    MinerViewController *minerVC = [[MinerViewController alloc] init];
    minerVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:minerVC animated:YES];
}

- (IBAction)moreNewsAction:(UIButton *)sender {
    
    MoreNewsViewController *moreNewsVC = [[MoreNewsViewController alloc] init];
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
    
    [self postUserSteps];
    
    [self getUserStepReward];
    [self getUserPowerReward];
    
    self.newsView.newsArray = @[];
    [self getUserNews];
}

- (void)reloadHomeView {
    [self.rankView reloadViewData];
    
    if ([UserDataManager shareManager].userId) {
        //已经登录
        [self.unLoginNewsMaskView removeFromSuperview];
        self.unLoginNewsMaskView = nil;
        
        NSString *headerImage = [UserDataManager shareManager].usermodel.headImg;
        [self.userHeaderImageView sd_setImageWithURL:[NSURL URLWithString:headerImage]];
        
        self.userLevelImageView.hidden = NO;
        self.userLevelLabel.hidden = NO;
        self.powerImageView.hidden = NO;
        self.powerLabel.hidden = NO;
        
        self.nicknameLabel.text = [UserDataManager shareManager].usermodel.nickName;
        self.userLevelLabel.text = [UserDataManager shareManager].usermodel.level;
        return;
    }
    
    //尚未登录
    [self.newsBackView addSubview:self.unLoginNewsMaskView];
    
         self.userHeaderImageView.image = [UIImage imageNamed:@"head_portrait"];
    self.nicknameLabel.text = @"请登录";
    
    self.userLevelImageView.hidden = YES;
    self.userLevelLabel.hidden = YES;
    self.powerImageView.hidden = YES;
    self.powerLabel.hidden = YES;
    
    [self.stepRewardView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    for (UIView *view in self.topView.subviews) {
        if ([view isKindOfClass:[RewardBallView class]]) {
            [view removeFromSuperview];
        }
    }
}

///获取用户步数，并上传到服务器
- (void)postUserSteps {
    self.footerImageView.hidden = NO;
    self.stepsLabel.hidden = NO;
    
    [[UserStepManager manager] getTodayStepsCompletion:^(NSInteger steps) {
        self.footerImageView.hidden = NO;
        self.stepsLabel.hidden = NO;
        self.stepsLabel.text = [NSString stringWithFormat:@"%ld",steps];
        [self postUserStepCount:steps];
    }];
}


#pragma mark -
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat rate = self.scrollView.contentOffset.y / NavHeight;
    self.customerBarView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:rate];
}

@end
