//
//  TacticsViewController.m
//  xasq
//
//  Created by dssj on 2019/7/29.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "TacticsViewController.h"
#import "TacticsViewCell.h"

@interface TacticsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

static NSString *tacticsIdentifier = @"TacticsViewCell";

@implementation TacticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"策略";
    
    CGRect rect = CGRectMake(0, StatusBar_H + NavBar_H, Screen_W, Screen_H - StatusBar_H - NavBar_H - Bottom_H);
    _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    [_tableView registerNib:[UINib nibWithNibName:@"TacticsViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:tacticsIdentifier];
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

#pragma mark-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TacticsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tacticsIdentifier];
    
    return cell;
}

@end
