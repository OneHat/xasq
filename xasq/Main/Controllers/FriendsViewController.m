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

@interface FriendsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) FriendsHeaderView *headerView;

@property (nonatomic, strong) NSArray *friends;

@end

@implementation FriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"好友排行";
    self.view.backgroundColor = ThemeColorBackground;
    
    CGRect frame = CGRectMake(0, NavHeight, ScreenWidth, ScreenHeight - NavHeight - BottomHeight);
    _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    [_tableView registerNib:[UINib nibWithNibName:@"FriendsRankViewCell" bundle:nil] forCellReuseIdentifier:@"FriendsRankViewCell"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 55;
    _tableView.backgroundColor = ThemeColorBackground;
    FriendsHeaderView *headerView = [[FriendsHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 65)];
    _tableView.tableHeaderView = headerView;
    [self.view addSubview:_tableView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nextController)];
    [headerView addGestureRecognizer:tap];
    
    NSDictionary *parameters = @{@"pageNo":@(0),@"pageSize":@(10),@"order":@"desc"};
    [[NetworkManager sharedManager] getRequest:UserInvitePower parameters:parameters success:^(NSDictionary * _Nonnull data) {
        NSArray *dateList = data[@"data"][@"rows"];
        if (!dateList || ![dateList isKindOfClass:[NSArray class]] || dateList.count == 0) {
            return;
        }
        
        self.friends = [UserRankModel modelWithArray:dateList];
        [self.tableView reloadData];
        
    } failure:^(NSError * _Nonnull error) {
        
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
