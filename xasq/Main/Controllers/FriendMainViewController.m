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

@interface FriendMainViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UIView *headerView;
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation FriendMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //背景
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth)];
    imageView.image = [UIImage imageNamed:@"home_topBackground"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
    
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
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, StatusBarHeight, 44, 44)];
    [backButton setImage:[UIImage imageNamed:@"leftBar_back_white"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    
//    [self getUserStepReward];
    [self getUserPowerReward];
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
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth + 44)];
        _headerView.clipsToBounds = YES;
        
        //背景
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth)];
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
    return 3;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeNewsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeNewsViewCell"];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth, 30)];
    titleLabel.text = @"昨天";
    [headerView addSubview:titleLabel];
    
    return headerView;
}


#pragma mark -
///用户步行奖励
- (void)getUserStepReward {
    if (self.userId == 0) {
        return;
    }
    [[NetworkManager sharedManager] getRequest:CommunitySendWalk parameters:@{@"userId":@(self.userId)} success:^(NSDictionary * _Nonnull data) {
        
//        [self.stepRewardView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

        NSArray *dateList = data[@"data"];
//        if (dateList && [dateList isKindOfClass:[NSArray class]] && dateList.count) {
//            NSDictionary *stepReward = dateList.firstObject;
//
//            RewardModel *model = [RewardModel modelWithDictionary:stepReward];
//
//            RewardBallView *ballView = [[RewardBallView alloc] initWithFrame:self.stepRewardView.bounds];
//            ballView.rewardModel = model;
//            [self.stepRewardView addSubview:ballView];
//        }
        
    } failure:^(NSError * _Nonnull error) {
    }];
}

///用户算力奖励
- (void)getUserPowerReward {
    if (self.userId == 0) {
        return;
    }
    
    [[NetworkManager sharedManager] getRequest:CommunitySendPower parameters:@{@"userId":@(self.userId)} success:^(NSDictionary * _Nonnull data) {
        
        NSArray *dateList = data[@"data"];
        if (dateList && [dateList isKindOfClass:[NSArray class]] && dateList.count) {
            
            //清除可能存在的view
            for (UIView *view in self.view.subviews) {
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
                [self.view addSubview:ballView];
                
//                __weak RewardBallView *weakBall = ballView;
//                ballView.RewardBallClick = ^(NSInteger rewardId) {
//                    [self userTakeReward:rewardId ballView:weakBall];
//                };
            }
            
        }
        
    } failure:^(NSError * _Nonnull error) {
    }];
}

- (NSMutableArray *)frameForRewardBallView:(NSInteger)count {
    NSMutableArray *frames = [NSMutableArray arrayWithCapacity:count];
    CGFloat width = 60;
    
    for (int i = 0; i < count; i++) {
        
        CGFloat viewX = 20 + (arc4random() % 240);
        CGFloat viewY = 44 + (arc4random() % 150);
        
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
                viewY = 44 + (arc4random() % 150);
                
                rect = CGRectMake(viewX, viewY, width, width);
                
            } else {
                [frames addObject:[NSValue valueWithCGRect:rect]];
            }
        } while (flag);
        
    }
    
    return frames;
}


@end
