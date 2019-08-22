//
//  FriendsViewController.m
//  xasq
//
//  Created by dssj on 2019/8/14.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "FriendsViewController.h"
#import "FriendsRankViewCell.h"
#import "FriendsHeaderView.h"
#import "ContactsViewController.h"
#import "FriendMainViewController.h"

#import "UITableView+Refresh.h"

@interface FriendsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) FriendsHeaderView *headerView;

@property (nonatomic, strong) NSMutableArray *friends;

@property (nonatomic, assign) NSInteger page;//页数
@property (nonatomic, assign) NSInteger totalPage;//页数

@end

@implementation FriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"好友排行";
    self.view.backgroundColor = ThemeColorBackground;
    
    self.friends = [NSMutableArray array];
    
    CGRect frame = CGRectMake(0, NavHeight, ScreenWidth, ScreenHeight - NavHeight - BottomHeight);
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    [self.tableView registerNib:[UINib nibWithNibName:@"FriendsRankViewCell" bundle:nil] forCellReuseIdentifier:@"FriendsRankViewCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 55;
    self.tableView.backgroundColor = ThemeColorBackground;
    FriendsHeaderView *headerView = [[FriendsHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 65)];
    self.tableView.tableHeaderView = headerView;
    [self.view addSubview:self.tableView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nextController)];
    [headerView addGestureRecognizer:tap];
    
    
    [self.tableView pullHeaderRefresh:^{
        self.page = 1;
        [self getFriendList];
    }];
    
    [self.tableView pullFooterRefresh:^{
        
        if (self.page < self.totalPage) {
            self.page++;
            [self getFriendList];
        } else {
            [self.tableView endRefresh];
        }
        
    }];
    
    self.page = 1;
    [self getFriendList];
}

///获取好友列表
- (void)getFriendList {
    
    NSDictionary *parameters = @{@"pageNo":@(self.page),@"pageSize":@(20),@"order":@"desc"};
    [[NetworkManager sharedManager] getRequest:UserInviteRankPower parameters:parameters success:^(NSDictionary * _Nonnull data) {
        [self.tableView endRefresh];
        
        self.totalPage = [data[@"data"][@"totalPage"] integerValue];
        
        NSArray *dateList = data[@"data"][@"rows"];
        if (!dateList || ![dateList isKindOfClass:[NSArray class]] || dateList.count == 0) {
            [self.tableView endRefresh];
            self.page--;
            return;
        }
        
        
        
        if (self.page == 1) {
            [self.friends removeAllObjects];
        }
        
        [self.friends addObjectsFromArray:[UserRankModel modelWithArray:dateList]];
        [self.tableView reloadData];
        
    } failure:^(NSError * _Nonnull error) {
        [self.tableView endRefresh];
        
    }];
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.friends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendsRankViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsRankViewCell"];
    
    cell.friendInfo = self.friends[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UserRankModel *model = self.friends[indexPath.row];
    if (model.userId == [UserDataManager shareManager].userId.integerValue) {
        return;
    }
    
    FriendMainViewController *friendVC = [[FriendMainViewController alloc] init];
    friendVC.userId = model.userId;
    [self.navigationController pushViewController:friendVC animated:YES];
}

#pragma mark -
- (void)nextController {
    ContactsViewController *inviteVC = [[ContactsViewController alloc] init];
    [self.navigationController pushViewController:inviteVC animated:YES];
}

@end
