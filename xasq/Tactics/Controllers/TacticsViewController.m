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

static NSString *TacticsIdentifier = @"TacticsViewCell";

@implementation TacticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"策略";
    
    CGRect rect = CGRectMake(0, NavHeight, ScreenWidth, ScreenHeight - NavHeight - BottomHeight);
    _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    [_tableView registerNib:[UINib nibWithNibName:@"TacticsViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:TacticsIdentifier];
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    [self.tableView showEmptyView:EmptyViewReasonNoNetwork refreshBlock:^{
        [self.tableView hideEmptyView];
    }];
    
}
#pragma mark-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TacticsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TacticsIdentifier];
    
    return cell;
}

@end
