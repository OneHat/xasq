//
//  CalculateRecordViewController.m
//  xasq
//
//  Created by dssj888@163.com on 2019/8/14.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "CalculateRecordViewController.h"
#import "CalculateRecordTableViewCell.h"

@interface CalculateRecordViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *rewards;

@end

@implementation CalculateRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"算力记录";
    self.view.backgroundColor = ThemeColorBackground;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavHeight, ScreenWidth, ScreenHeight - NavHeight) style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = ThemeColorBackground;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    _tableView.rowHeight = 60;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    
    if (![UserDataManager shareManager].userId) {
        return;
    }
    [[NetworkManager sharedManager] getRequest:CommunityPowerRecord parameters:@{@"userId":[UserDataManager shareManager].userId} success:^(NSDictionary * _Nonnull data) {
        
        NSArray *rewards = data[@"data"];
        if (rewards && [rewards isKindOfClass:[NSArray class]]) {
            self.rewards = data[@"data"];
            [self.tableView reloadData];
        }
        
    } failure:^(NSError * _Nonnull error) {
        [self showErrow:error];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return self.rewards.count;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    headerView.backgroundColor = ThemeColorBackground;
    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CalculateRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CalculateRecordTableViewCell"];
    if (cell == nil) {
        cell = [[[UINib nibWithNibName:@"CalculateRecordTableViewCell" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSDictionary *reward = self.rewards[indexPath.row];
    
    cell.nameLabel.text = reward[@"taskName"];
    cell.timeLabel.text = reward[@"createdOn"];
    cell.numberLabel.text = [NSString stringWithFormat:@"+%@",reward[@"rewardPower"]];
    
    return cell;
}

@end
