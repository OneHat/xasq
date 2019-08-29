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
@property (nonatomic, strong) NSMutableArray *rewards;

@property (nonatomic, assign) NSInteger page;//页数
@property (nonatomic, assign) NSInteger totalPage;//总页数

@end

@implementation TaskRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"算力记录";
    self.view.backgroundColor = ThemeColorBackground;
    
    self.rewards = [NSMutableArray array];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20 + NavHeight, ScreenWidth, ScreenHeight - NavHeight - BottomHeight - 30) style:UITableViewStylePlain];
    [_tableView registerNib:[UINib nibWithNibName:@"TaskRecordViewCell" bundle:nil] forCellReuseIdentifier:@"TaskRecordViewCell"];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = ThemeColorBackground;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    _tableView.rowHeight = 60;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    
    WeakObject
    [self.tableView pullHeaderRefresh:^{
        weakSelf.page = 1;
        [weakSelf getRecords];
    }];
    
    [self.tableView pullFooterRefresh:^{
        
        if (weakSelf.page < weakSelf.totalPage) {
            weakSelf.page++;
            [weakSelf getRecords];
        } else {
            [weakSelf.tableView endRefresh];
        }
        
    }];
    
    self.page = 1;
    [self getRecords];
}

#pragma mark -
- (void)getRecords {
    NSDictionary *parameters = @{@"pageNo":@(self.page)};
    [[NetworkManager sharedManager] getRequest:CommunityPowerRecord parameters:parameters success:^(NSDictionary * _Nonnull data) {
        [self.tableView endRefresh];
        
        self.totalPage = [data[@"data"][@"totalPage"] integerValue];
        
        NSArray *rewards = data[@"data"][@"rows"];;
        if (!rewards || ![rewards isKindOfClass:[NSArray class]] || rewards.count == 0) {
            self.page--;
            return;
        }
        
        if (self.page == 1) {
            [self.rewards removeAllObjects];
        }
        
        [self.rewards addObjectsFromArray:rewards];
        [self.tableView reloadData];
        
        
    } failure:^(NSError * _Nonnull error) {
        [self.tableView endRefresh];
    }];
}

#pragma mark -
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
