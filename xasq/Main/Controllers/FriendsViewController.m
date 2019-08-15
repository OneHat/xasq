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
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 50;
    _tableView.backgroundColor = ThemeColorBackground;
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 80)];
    _headerView = [[[UINib nibWithNibName:@"FriendsHeaderView" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
    _headerView.frame = CGRectMake(0, 0, ScreenWidth, 80);
    [header addSubview:_headerView];
    _tableView.tableHeaderView = header;
    [self.view addSubview:_tableView];
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendsRankViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsRankViewCell"];
    if (cell == nil) {
        cell = [[[UINib nibWithNibName:@"FriendsRankViewCell" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

@end
