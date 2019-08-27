//
//  FriendMainViewController.m
//  xasq
//
//  Created by dssj on 2019/8/16.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "FriendMainViewController.h"
#import "HomeNewsViewCell.h"
#import "RewardBallView.h"
#import "UITableView+Refresh.h"

@interface FriendMainViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableDictionary *newsInfo;

@property (nonatomic, strong) RewardModel *stepReward;
@property (nonatomic, strong) NSArray *powRewardArray;

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger totalPage;

@property (strong, nonatomic) UIButton *backButton;//自定义的bar
@property (strong, nonatomic) UIView *customerBarView;//自定义的bar

@end

@implementation FriendMainViewController
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
//    //背景
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth * 1.25)];
//    imageView.image = [UIImage imageNamed:@"home_topBackground"];
//    imageView.contentMode = UIViewContentModeScaleAspectFill;
//    [self.view addSubview:imageView];
    
    //title
//    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, StatusBarHeight, ScreenWidth, 44)];
//    titleLabel.textAlignment = NSTextAlignmentCenter;
//    titleLabel.textColor = [UIColor whiteColor];
//    titleLabel.text = @ore"任务";
//    titleLabel.font = [UIFont systemFontOfSize:17];
//    [self.view addSubview:titleLabel];
    
    CGRect rect = CGRectMake(0, 0, ScreenWidth, ScreenHeight - BottomHeight);
    self.tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeNewsViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"HomeNewsViewCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = self.headerView;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 46;
    self.tableView.sectionHeaderHeight = 30.0;
    self.tableView.sectionFooterHeight = 0.0;
    [self.view addSubview:self.tableView];
    
//    self.customerBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, NavHeight)];
//    self.customerBarView.userInteractionEnabled = NO;
//    self.customerBarView.backgroundColor = [UIColor clearColor];
//    [self.view addSubview:self.customerBarView];
    
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, StatusBarHeight, 44, 44)];
    [backButton setImage:[UIImage imageNamed:@"leftBar_back_white"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    _backButton = backButton;
    
    self.titles = [NSMutableArray array];
    self.newsInfo = [NSMutableDictionary dictionary];
    
    
    [self.tableView pullHeaderRefresh:^{
        self.page = 1;
        [self getUserMessageInfo];
    }];
    
    [self.tableView pullFooterRefresh:^{
        
        if (self.page < self.totalPage) {
            self.page++;
            [self getUserMessageInfo];
            return;
        }
        [self.tableView endRefresh];
        
    }];
    
    self.page = 1;
    [self getUserMessageInfo];
    
    [self getUserRewrad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth * 1.25)];
        _headerView.clipsToBounds = YES;
        
        //背景
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth * 1.25)];
        imageView.clipsToBounds = YES;
        imageView.image = [UIImage imageNamed:@"home_topBackground"];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [_headerView addSubview:imageView];
        
        UILabel *lastNewsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(imageView.frame), ScreenWidth, 44)];
        lastNewsLabel.text = @"最新动态";
        lastNewsLabel.font = [UIFont systemFontOfSize:17];
        [_headerView addSubview:lastNewsLabel];
    }
    return _headerView;
}

#pragma mark -
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titles.count;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.newsInfo[self.titles[section]];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeNewsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeNewsViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *key = self.titles[indexPath.section];
    NSArray *array = self.newsInfo[key];
    
    UserNewsModel *model = array[indexPath.row];
    
    cell.newsModel = model;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth, 30)];
    titleLabel.text = self.titles[section];
    [headerView addSubview:titleLabel];
    
    return headerView;
}


#pragma mark -
- (void)getUserRewrad {
    if (self.userId == 0) {
        return;
    }
    
    ////////
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        
        [[NetworkManager sharedManager] getRequest:CommunitySendPower parameters:@{@"targetId":@(self.userId)} success:^(NSDictionary * _Nonnull data) {
            dispatch_group_leave(group);
            
            NSArray *dateList = data[@"data"];
            if (dateList && [dateList isKindOfClass:[NSArray class]] && dateList.count) {
                
                self.powRewardArray = [RewardModel modelWithArray:dateList];
            }
            
        } failure:^(NSError * _Nonnull error) {
            dispatch_group_leave(group);
        }];
    });
    
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        [[NetworkManager sharedManager] getRequest:CommunitySendWalk parameters:@{@"targetId":@(self.userId)} success:^(NSDictionary * _Nonnull data) {
            dispatch_group_leave(group);
            NSArray *dateList = data[@"data"];
            if (dateList && [dateList isKindOfClass:[NSArray class]] && dateList.count) {
                NSDictionary *stepReward = dateList.firstObject;
                
                self.stepReward = [RewardModel modelWithDictionary:stepReward];
            }
            
        } failure:^(NSError * _Nonnull error) {
            dispatch_group_leave(group);
        }];
    });
    
    ////////////
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self loadRewardView];
    });
    
}

- (void)getUserMessageInfo {
    NSDictionary *parameters = @{@"targetId":@(self.userId),@"pageNo":@(self.page)};
    
    [[NetworkManager sharedManager] postRequest:CommunityStealFlow parameters:parameters success:^(NSDictionary * _Nonnull data) {
        [self.tableView endRefresh];
        
        self.totalPage = [data[@"data"][@"totalPage"] integerValue];
        NSArray *dateList = data[@"data"][@"rows"];
        if (!dateList || ![dateList isKindOfClass:[NSArray class]] || dateList.count == 0) {
            return;
        }
        
        if (self.page == 1) {
            [self.titles removeAllObjects];
            [self.newsInfo removeAllObjects];
        }
        
        [self handleData:dateList];
        [self.tableView reloadData];
        
    } failure:^(NSError * _Nonnull error) {
        [self.tableView endRefresh];
    }];
}

//处理数据，分组
- (void)handleData:(NSArray *)array {
    NSArray *originalArray = [UserNewsModel modelWithArray:array];
    
    for (UserNewsModel *model in originalArray) {
        NSString *key = self.titles.lastObject;
        if (![key isEqualToString:model.showDate]) {
            key = model.showDate;
            [self.titles addObject:key];
        }
        
        NSMutableArray *temp = self.newsInfo[key];
        if (!temp) {
            temp = [NSMutableArray array];
            [self.newsInfo setObject:temp forKey:key];
        }
        
        [temp addObject:model];
    }
}

//
- (void)stealCurrencyWithBallView:(RewardBallView *)ballView {
    if (ballView.rewardModel.ID == 0) {
        return;
    }
    
    NSDictionary *parameters = @{@"bId":@(ballView.rewardModel.ID),@"sourceUserId":@(self.userId)};
    [[NetworkManager sharedManager] postRequest:CommunityAreaStealCurrency parameters:parameters success:^(NSDictionary * _Nonnull data) {

        NSDictionary *info = data[@"data"];
        if (info && [info isKindOfClass:[NSDictionary class]]) {
            NSString *stealNum = info[@"quantity"];
            
            UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 32)];
            tipLabel.numberOfLines = 0;
            tipLabel.textAlignment = NSTextAlignmentCenter;
            tipLabel.textColor = [UIColor whiteColor];
            tipLabel.center = ballView.center;
            tipLabel.font = [UIFont boldSystemFontOfSize:11];
            tipLabel.text = [NSString stringWithFormat:@"%.8f",stealNum.doubleValue];
            [self.headerView addSubview:tipLabel];

            [UIView animateWithDuration:1.0 animations:^{

                tipLabel.transform = CGAffineTransformMakeTranslation(0, -50);

            } completion:^(BOOL finished) {
                [tipLabel removeFromSuperview];
                
                RewardModel *model = ballView.rewardModel;
                NSDecimalNumber *originalNum = [NSDecimalNumber decimalNumberWithString:model.currencyQuantity];
                NSDecimalNumber *stealDecimalNumber = [NSDecimalNumber decimalNumberWithString:stealNum];
                originalNum = [originalNum decimalNumberBySubtracting:stealDecimalNumber];
                model.currencyQuantity = originalNum.stringValue;//修改数量
                model.status = 10;//状态改为已偷
                ballView.rewardModel = model;
                
            }];
            
        }

    } failure:^(NSError * _Nonnull error) {
        [ballView resetButtonEnable];
    }];
}

#pragma mark -
- (void)loadRewardView {
    //            //清除可能存在的view
    //            for (UIView *view in self.headerView.subviews) {
    //                if ([view isKindOfClass:[RewardBallView class]]) {
    //                    [view removeFromSuperview];
    //                }
    //            }
    //
    
    NSMutableArray *rewards = [NSMutableArray arrayWithArray:self.powRewardArray];
    if (self.stepReward) {
        [rewards addObject:self.stepReward];
    }
    
    //能量球
    NSInteger count = MIN(5, rewards.count);//个数
    NSMutableArray *frames = [self frameForRewardBallView:count];
    
    for (int i = 0; i < count; i++) {
        NSValue *rectValue = frames[i];
        
        RewardBallView *ballView = [[RewardBallView alloc] initWithFrame:rectValue.CGRectValue];
        ballView.rewardModel = rewards[i];
        ballView.ballStyle = RewardBallViewStylePower;
        [self.headerView addSubview:ballView];
        
        ballView.RewardBallClick = ^(RewardBallView * _Nonnull ballView) {
            [self stealCurrencyWithBallView:ballView];
        };
    }
}

- (NSMutableArray *)frameForRewardBallView:(NSInteger)count {
    NSMutableArray *frames = [NSMutableArray arrayWithCapacity:count];
    CGFloat width = 60;
    NSInteger xWidth = ScreenWidth - 100;
    NSInteger yHeight = ScreenWidth * 1.25 - NavHeight - 80;
    
    for (int i = 0; i < count; i++) {
        
        CGFloat viewX = 20 + (arc4random() % xWidth);
        CGFloat viewY = NavHeight + (arc4random() % yHeight);
        
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
                viewY = NavHeight + (arc4random() % yHeight);
                
                rect = CGRectMake(viewX, viewY, width, width);
                
            } else {
                [frames addObject:[NSValue valueWithCGRect:rect]];
            }
        } while (flag);
        
    }
    
    return frames;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat rate = (scrollView.contentOffset.y) / NavHeight;
    self.customerBarView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:rate];
    
    if (scrollView.contentOffset.y > NavHeight * 0.5) {
        [self.backButton setImage:[UIImage imageNamed:@"leftBar_back"] forState:UIControlStateNormal];
    } else {
        [self.backButton setImage:[UIImage imageNamed:@"leftBar_back_white"] forState:UIControlStateNormal];
    }
}

@end
