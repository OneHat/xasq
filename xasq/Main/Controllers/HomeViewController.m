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

static NSString *HomeBannerADCacheKey = @"HomeBannerADCacheKey";
static NSString *HomeNewsCacheKey = @"HomeNewsCacheKey";

@interface HomeViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

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

//@property (weak, nonatomic) IBOutlet UIView *stepRewardView;
//@property (weak, nonatomic) IBOutlet UIImageView *footerImageView;
//@property (weak, nonatomic) IBOutlet UILabel *stepsLabel;

@property (weak, nonatomic) IBOutlet UIImageView *userHeaderImageView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;

@property (weak, nonatomic) IBOutlet UIImageView *mineNameImageView;
@property (weak, nonatomic) IBOutlet UILabel *mineNameLabel;

///这几个页面，没有登录时，需要隐藏
@property (weak, nonatomic) IBOutlet UIImageView *userLevelImageView;
@property (weak, nonatomic) IBOutlet UILabel *userLevelLabel;
@property (weak, nonatomic) IBOutlet UIImageView *powerImageView;
@property (weak, nonatomic) IBOutlet UILabel *powerLabel;

@property (weak, nonatomic) IBOutlet UILabel *msgCountLB; // 消息未读显示

//隐藏导航栏时，是否需要动画
//从子页面需要，防止右滑返回时navbar不协调
//tabbar选择过来，不需要动画，否则会有阴影上移的效果
@property (assign, nonatomic) BOOL hideNavBarAnimation;
@property (assign, nonatomic) BOOL hideNavBarWhenDisappear;//页面消失，是否需要隐藏导航栏，默认NO

@property (nonatomic, strong) UIView *unLoginNewsMaskView;//没有登录时，动态页面的遮挡

@property (strong, nonatomic) UIView *customerBarView;//自定义的bar

@property (strong, nonatomic) NSMutableArray *rewardArray;//当奖励大于5个时，缓存起来，领取后再显示


@end

@implementation HomeViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

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
    _msgCountLB.layer.cornerRadius = 9;
    _msgCountLB.layer.masksToBounds = YES;
                                 
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11.0, *)) {
        self.rankBackViewBottom.constant = 0;
    }
    
    self.headerImageTop.constant = StatusBarHeight + 10;
    
    self.scrollView.delegate = self;
    
//    self.customerBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, NavHeight)];
//    self.customerBarView.userInteractionEnabled = NO;
//    self.customerBarView.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:self.customerBarView];
    
    //动态
    self.newsView = [[HomeNewsView alloc] initWithFrame:CGRectMake(0, 40, ScreenWidth, 90)];
    [self.newsBackView addSubview:self.newsView];
//    NSArray *cacheNewsList = [[NSUserDefaults standardUserDefaults] objectForKey:HomeNewsCacheKey];
//    NSArray *newsList = [UserNewsModel modelWithArray:cacheNewsList];
//    if (newsList.count > 0) {
//        self.newsView.newsArray = newsList;
//    }
    
    //广告banner
    self.bannerView = [[HomeBannerView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth * 26 / 75)];
    [self.bannerBackView addSubview:self.bannerView];
    
    NSArray *cacheBannerList = [[NSUserDefaults standardUserDefaults] objectForKey:HomeBannerADCacheKey];
    NSArray *bannerList = [BannerObject modelWithArray:cacheBannerList];
    if (bannerList.count > 0) {
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

    //用户算力奖励
    [self getUserPowerReward];
    
    //最新动态
    [self getUserCurrentNews];
    
    //当前算力、等级
    [self getUserLevelAndPower];
    
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
    
    //退出功
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(userLogout)
                                                 name:DSSJUserLogoutNotification
                                               object:nil];
    
    self.mineNameLabel.text = @"西岸社区";
    self.mineNameImageView.image = [[UIImage imageNamed:@"mineName_background"] resizeImageInCenter];
    self.mineNameLabel.textColor = HexColor(@"ededed");
    
    self.userLevelLabel.layer.cornerRadius = 2;
    self.userLevelLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    self.userLevelLabel.layer.borderWidth = 0.5;
    self.userLevelLabel.layer.masksToBounds = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:_hideNavBarAnimation];
    _hideNavBarAnimation = YES;
    
    [self reloadHomeView];
    [self getMessageSysUnreadNum];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:self.hideNavBarWhenDisappear animated:YES];
    self.hideNavBarWhenDisappear = NO;
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
            self.bannerView.imageArray = bannerList;
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
        if (rewards.count > count) {
            NSArray *leftArray = [rewards subarrayWithRange:NSMakeRange(count, rewards.count - count)];
            self.rewardArray = [NSMutableArray arrayWithArray:leftArray];
        }
        
        NSMutableArray *frames = [self frameForRewardBallView:count];
        
        for (int i = 0; i < count; i++) {
            NSValue *rectValue = frames[i];
            
            RewardBallView *ballView = [[RewardBallView alloc] initWithFrame:rectValue.CGRectValue];
            ballView.rewardModel = rewards[i];
            ballView.ballStyle = RewardBallViewStylePower;
            [self.topView insertSubview:ballView belowSubview:self.userHeaderImageView];
            
            __weak RewardBallView *weakBall = ballView;
            ballView.RewardBallClick = ^(RewardBallView * _Nonnull ballView) {
                [self userTakeRewardWithBallView:weakBall];
            };
        }
        
    } failure:^(NSError * _Nonnull error) {
    }];
}

- (NSMutableArray *)frameForRewardBallView:(NSInteger)count {
    NSMutableArray *frames = [NSMutableArray arrayWithCapacity:count];
    CGFloat width = 60;
    NSInteger xWidth = ScreenWidth - 150;
    NSInteger yHeight = ScreenWidth * 1.25 - NavHeight - 200;
    
    for (int i = 0; i < count; i++) {
        
        CGFloat viewX = 20 + (arc4random() % xWidth);
        CGFloat viewY = 20 + NavHeight + (arc4random() % yHeight);
        
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
                viewX = 20 + (arc4random() % xWidth);
                viewY = 20 + NavHeight + (arc4random() % yHeight);
                
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
    
    NSDictionary *parameters = @{@"userWalk":@(steps)};
    [[NetworkManager sharedManager] postRequest:UserSyncWalk parameters:parameters success:^(NSDictionary * _Nonnull data) {
    } failure:^(NSError * _Nonnull error) {
    }];
}

///用户收取奖励
- (void)userTakeRewardWithBallView:(RewardBallView *)ballView {
    if (ballView.rewardModel.ID == 0) {
        return;
    }
    
    NSDictionary *parameters = @{@"bId":@(ballView.rewardModel.ID)};
    [[NetworkManager sharedManager] postRequest:CommunityAreaTakeCurrency parameters:parameters success:^(NSDictionary * _Nonnull data) {
        
        NSDictionary *info = data[@"data"];
        if (!info || ![info isKindOfClass:[NSDictionary class]] || info.allKeys.count == 0) {
            return;
        }
        if ([info[@"code"] integerValue] != 200) {
            [self showMessage:info[@"msg"]];
            return;
        }
        
        CGRect frame = ballView.frame;
        
        [UIView animateWithDuration:0.5 animations:^{
            
            CGPoint p = self.userHeaderImageView.center;
            CGAffineTransform t = CGAffineTransformMakeTranslation(p.x - ballView.center.x, p.y - ballView.center.y);
            ballView.transform = CGAffineTransformScale(t, 0.1, 0.1);
            
        } completion:^(BOOL finished) {
            
            [ballView removeFromSuperview];
            
            if (ballView.rewardModel.type == 1) {
                return;
            }
            
            if (self.rewardArray.count > 0) {
                RewardModel *model = self.rewardArray.firstObject;

                RewardBallView *otherView = [[RewardBallView alloc] initWithFrame:frame];
                otherView.rewardModel = model;
                otherView.ballStyle = RewardBallViewStylePower;
                [self.topView insertSubview:otherView belowSubview:self.userHeaderImageView];
                
                __weak RewardBallView *weakBall = otherView;
                otherView.RewardBallClick = ^(RewardBallView * _Nonnull ballView) {
                    [self userTakeRewardWithBallView:weakBall];
                };
                
                [self.rewardArray removeObjectAtIndex:0];
            }
        }];
        
    } failure:^(NSError * _Nonnull error) {
        [ballView resetButtonEnable];
        [self showErrow:error];
    }];
}

///最新动态
- (void)getUserCurrentNews {
    NSDictionary *parameters = @{@"pageSize":@(3),@"pageNo":@(1)};
    
    [[NetworkManager sharedManager] postRequest:CommunityStealFlow parameters:parameters success:^(NSDictionary * _Nonnull data) {
        
        NSArray *dateList = data[@"data"][@"rows"];
        if (!dateList || ![dateList isKindOfClass:[NSArray class]] || dateList.count == 0) {
            return;
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:dateList forKey:HomeNewsCacheKey];
        
        NSArray *newsList = [UserNewsModel modelWithArray:dateList];
        if (newsList.count > 3) {
            self.newsView.newsArray = [newsList subarrayWithRange:NSMakeRange(0, 3)];
        } else {
            self.newsView.newsArray = newsList;
        }
        
    } failure:^(NSError * _Nonnull error) {
    }];
}

///用户等级算力
- (void)getUserLevelAndPower {
    [[NetworkManager sharedManager] getRequest:CommunityPowerUpinfo parameters:nil success:^(NSDictionary * _Nonnull data) {
        
        NSDictionary *powInfo = data[@"data"];
        if (powInfo && [powInfo isKindOfClass:[NSDictionary class]]) {
            self.powerLabel.text = [NSString stringWithFormat:@"算力%@",powInfo[@"userPower"]];
            self.userLevelLabel.text = powInfo[@"userLevelName"];
        }
    } failure:^(NSError * _Nonnull error) {
    }];
    
}

// 获取消息未读数量
- (void)getMessageSysUnreadNum {
    [[NetworkManager sharedManager] getRequest:MessageSysUnreadNum parameters:nil success:^(NSDictionary * _Nonnull data) {
        NSDictionary *dict = data[@"data"];
        if ([dict isKindOfClass:[NSDictionary class]]) {
            NSInteger num = [dict[@"num"] integerValue];
            if (num > 0) {
                self.msgCountLB.hidden = NO;
                self.msgCountLB.text = [NSString stringWithFormat:@"%@",dict[@"num"]];
            } else {
                self.msgCountLB.hidden = YES;
            }
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
#pragma mark - 邀请好友界面
- (IBAction)inviteAction:(UIButton *)sender {
    if (![UserDataManager shareManager].userId) {
        [self showMessage:@"请先登录"];
        return;
    }
    
    InviteFriendViewController *inviteFriendsVC = [[InviteFriendViewController alloc] init];
    inviteFriendsVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:inviteFriendsVC animated:YES];
}
#pragma mark - 好友排行界面
- (IBAction)friendsAction:(UIButton *)sender {
    if (![UserDataManager shareManager].userId) {
        [self showMessage:@"请先登录"];
        return;
    }
    
    FriendsViewController *friendsVC = [[FriendsViewController alloc] init];
    friendsVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:friendsVC animated:YES];
    
}
#pragma mark - 任务界面
- (IBAction)taskAction:(UIButton *)sender {
    if (![UserDataManager shareManager].userId) {
        [self showMessage:@"请先登录"];
        return;
    }
    
    self.hideNavBarWhenDisappear = YES;
    
    TaskViewController *taskVC = [[TaskViewController alloc] init];
    taskVC.requestPow = ^{
        [self getUserLevelAndPower];
    };
    taskVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:taskVC animated:YES];
}
#pragma mark - 矿工界面
- (IBAction)minerAction:(id)sender {
    if (![UserDataManager shareManager].userId) {
        [self showMessage:@"请先登录"];
        return;
    }
    
    self.hideNavBarWhenDisappear = YES;
    MinerViewController *minerVC = [[MinerViewController alloc] init];
    minerVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:minerVC animated:YES];
}
#pragma mark - 最新动态界面
- (IBAction)moreNewsAction:(UIButton *)sender {
    
    MoreNewsViewController *moreNewsVC = [[MoreNewsViewController alloc] init];
    moreNewsVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:moreNewsVC animated:YES];
}

- (IBAction)headerClick:(UIButton *)sender {
    if ([UserDataManager shareManager].userId) {
        [self minerAction:nil];
        
    } else {
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
    
    [self getUserPowerReward];//
    [self getUserLevelAndPower];//
    
    self.newsView.newsArray = @[];
    [self getUserCurrentNews];
    
}

- (void)userLogout {
    
}

- (void)reloadHomeView {
    [self.rankView reloadViewData];
    
    if ([UserDataManager shareManager].userId) {
        //已经登录
        [self.unLoginNewsMaskView removeFromSuperview];
        self.unLoginNewsMaskView = nil;
        
        NSString *headerImage = [UserDataManager shareManager].usermodel.headImg;
        [self.userHeaderImageView sd_setImageWithURL:[NSURL URLWithString:headerImage] placeholderImage:[UIImage imageNamed:@"head_portrait"]];
        
        self.userLevelImageView.hidden = NO;
        self.userLevelLabel.hidden = NO;
        self.powerImageView.hidden = NO;
        self.powerLabel.hidden = NO;
        
        self.nicknameLabel.text = [UserDataManager shareManager].usermodel.nickName;
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
    
    for (UIView *view in self.topView.subviews) {
        if ([view isKindOfClass:[RewardBallView class]]) {
            [view removeFromSuperview];
        }
    }
}


#pragma mark -
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat height = CGRectGetHeight(self.topView.frame);
    height = 0;
    CGFloat rate = (scrollView.contentOffset.y - height) / NavHeight;
    self.customerBarView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:rate];
}

@end
