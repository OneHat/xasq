//
//  TaskRecordViewController.m
//  xasq
//
//  Created by dssj888@163.com on 2019/8/14.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "TaskRecordViewController.h"
#import "TaskRecordViewCell.h"

@interface TaskRecordViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *rewards;

@end

@implementation TaskRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"算力记录";
    self.view.backgroundColor = ThemeColorBackground;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20 + NavHeight, ScreenWidth, ScreenHeight - NavHeight - BottomHeight - 30) style:UITableViewStylePlain];
    [_tableView registerNib:[UINib nibWithNibName:@"TaskRecordViewCell" bundle:nil] forCellReuseIdentifier:@"TaskRecordViewCell"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = ThemeColorBackground;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    _tableView.rowHeight = 60;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    
    [[NetworkManager sharedManager] getRequest:CommunityPowerRecord parameters:nil success:^(NSDictionary * _Nonnull data) {
        
        NSArray *rewards = data[@"data"];
        if (rewards && [rewards isKindOfClass:[NSArray class]] && rewards.count > 0) {
            self.rewards = data[@"data"];
            [self.tableView reloadData];
            return;
        }
        
        
    } failure:^(NSError * _Nonnull error) {
        [self showErrow:error];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.rewards.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TaskRecordViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskRecordViewCell"];
    
    NSDictionary *reward = self.rewards[indexPath.row];
    
    cell.nameLabel.text = reward[@"taskName"];
    cell.timeLabel.text = reward[@"createdOn"];
    cell.numberLabel.text = [NSString stringWithFormat:@"+%@",reward[@"rewardPower"]];
    
    return cell;
}

@end
