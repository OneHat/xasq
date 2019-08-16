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
    
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendsRankViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsRankViewCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendMainViewController *friendVC = [[FriendMainViewController alloc] init];
    [self.navigationController pushViewController:friendVC animated:YES];
    
}

#pragma mark -
- (void)nextController {
    ContactsViewController *inviteVC = [[ContactsViewController alloc] init];
    [self.navigationController pushViewController:inviteVC animated:YES];
}

@end
