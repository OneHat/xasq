//
//  ProceedAccountViewController.m
//  xasq
//
//  Created by dssj888@163.com on 2019/8/5.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "ProceedAccountViewController.h"
#import "ProceedAccountTableViewCell.h"

@interface ProceedAccountViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ProceedAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收款账户";
    self.view.backgroundColor = ThemeColorBackground;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - NavHeight) style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = ThemeColorBackground;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    _tableView.separatorColor = ThemeColorLine;
    _tableView.rowHeight = 50;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    headerView.backgroundColor = ThemeColorBackground;
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProceedAccountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProceedAccountTableViewCell"];
    if (cell == nil) {
        cell = [[[UINib nibWithNibName:@"ProceedAccountTableViewCell" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
