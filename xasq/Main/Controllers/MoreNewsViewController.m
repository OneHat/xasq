//
//  MoreNewsViewController.m
//  xasq
//
//  Created by dssj on 2019/8/1.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "MoreNewsViewController.h"
#import "HomeNewsViewCell.h"

static NSString *NewsCellIdentifier = @"NewsCellIdentifier";

@interface MoreNewsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *newsArray;

@end

@implementation MoreNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我";
    self.view.backgroundColor = ThemeColorBackground;
    
    CGRect rect = CGRectMake(0, NavHeight + 10, ScreenWidth, ScreenHeight - NavHeight - BottomHeight);
    self.tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = ThemeColorBackground;
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeNewsViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NewsCellIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 46;
    self.tableView.sectionHeaderHeight = 30;
    self.tableView.sectionFooterHeight = 0;
    [self.view addSubview:self.tableView];
    
    [self initRightBtnWithTitle:@"只看好友" color:ThemeColorBlue];
}

#pragma mark-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth, 30)];
    titleLabel.text = @"昨天";
    [headerView addSubview:titleLabel];
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeNewsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NewsCellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


@end
