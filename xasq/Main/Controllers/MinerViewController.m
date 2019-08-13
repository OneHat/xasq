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
@property (nonatomic, assign) NSInteger currentIndex;//

@end

@implementation MinerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //title
    [self initTitle];

    CGRect rect = CGRectMake(0, NavHeight + 10, ScreenWidth, ScreenHeight - NavHeight - 10);
    _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    [_tableView registerNib:[UINib nibWithNibName:@"InviteHistoryViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 56;
    _tableView.tableHeaderView = [self headerView];
    [self.view addSubview:_tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)initTitle {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 100)];
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

- (UIView *)headerView {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 300)];
//    headerView.backgroundColor = RGBColor(36, 69, 104);
    
    UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(0, -ScreenHeight, ScreenWidth, ScreenHeight + 80)];
    colorView.backgroundColor = RGBColor(36, 69, 104);
    [headerView addSubview:colorView];
    
    MinerInfomationView *infomationView = [[MinerInfomationView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 160)];
    infomationView.backgroundColor = [UIColor clearColor];
    [headerView addSubview:infomationView];
    
    InviteCodeView *inviteCodeView = [[InviteCodeView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(infomationView.frame), ScreenWidth, 140)];
    [headerView addSubview:inviteCodeView];
    
    
    return headerView;
}

#pragma mark-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    InviteHistoryViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 66;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 66)];
    headerView.backgroundColor = ThemeColorBackground;
    
    UIView *indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 54, 44, 2)];
    indicatorView.backgroundColor = ThemeColorBlue;
    [headerView addSubview:indicatorView];
    
    CGSize size = [@"累计助力" sizeWithAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16]}];
    CGFloat width = ceil(size.width);
    
    for (int i = 0; i < 3; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10 + (width+10) * i, 10, width, 20)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = ThemeFontText;
        label.text = @"累计助力";
        [headerView addSubview:label];
        
        UILabel *numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(10 + (width+10) * i, 30, width, 20)];
        numberLabel.textAlignment = NSTextAlignmentCenter;
        numberLabel.font = ThemeFontSmallText;
        numberLabel.text = @"+666";
        [headerView addSubview:numberLabel];
        
        if (_currentIndex == i) {
            indicatorView.center = CGPointMake(label.center.x, indicatorView.center.y);
            label.textColor = [UIColor blackColor ];
            numberLabel.textColor = ThemeColorBlue;
            
        } else {
            label.textColor = ThemeColorTextGray;
            numberLabel.textColor = ThemeColorTextGray;
        }
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(10 + (width+10) * i, 10, width, 46)];
        button.tag = i;
        [button addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:button];
    }
    
    return headerView;
}

#pragma mark-
- (void)backButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)changeAction:(UIButton *)sender {
    _currentIndex = sender.tag;
    [self.tableView reloadData];
}

@end
