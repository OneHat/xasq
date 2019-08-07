//
//  MinerViewController.m
//  xasq
//
//  Created by dssj on 2019/8/1.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "MinerViewController.h"
#import "MinerInfomationView.h"
#import "InviteCodeView.h"
#import "InviteHistoryViewCell.h"

@interface MinerViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MinerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //title
    [self initTitle];
    
    MinerInfomationView *infomationView = [[MinerInfomationView alloc] initWithFrame:CGRectMake(0, NavHeight + 10, ScreenWidth, 160)];
    [self.view addSubview:infomationView];
    
    InviteCodeView *inviteCodeView = [[InviteCodeView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(infomationView.frame), ScreenWidth, 140)];
//    [self.view addSubview:inviteCodeView];
    
    CGRect rect = CGRectMake(0, 10 + CGRectGetMaxY(infomationView.frame), ScreenWidth, ScreenHeight - 10 - CGRectGetMaxY(infomationView.frame));
    _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    [_tableView registerNib:[UINib nibWithNibName:@"InviteHistoryViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 50;
    _tableView.tableHeaderView = inviteCodeView;
    [self.view addSubview:_tableView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)initTitle {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 160)];
    topView.backgroundColor = RGBColor(36, 69, 104);
    [self.view addSubview:topView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, StatusBarHeight, ScreenWidth, 44)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"矿工";
    titleLabel.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:titleLabel];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, StatusBarHeight, 44, 44)];
    [backButton setImage:[UIImage imageNamed:@"leftBar_back_white"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
}

#pragma mark-

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InviteHistoryViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    return cell;
}

#pragma mark-
- (void)backButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
