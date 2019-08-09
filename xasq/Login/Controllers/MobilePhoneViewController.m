//
//  MobilePhoneViewController.m
//  xasq
//
//  Created by dssj888@163.com on 2019/8/9.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "MobilePhoneViewController.h"
#import "MobilePhoneTableViewCell.h"

@interface MobilePhoneViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MobilePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手机号归属地";
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - NavHeight) style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    _tableView.rowHeight = 50;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 35)];
    headerView.backgroundColor = ThemeColorBackground;
    UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 35)];
    titleLB.text = @"常用";
    titleLB.textColor = ThemeColorTextGray;
    titleLB.font = ThemeFontText;
    [headerView addSubview:titleLB];
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MobilePhoneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MobilePhoneTableViewCell"];
    if (cell == nil) {
        cell = [[[UINib nibWithNibName:@"MobilePhoneTableViewCell" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
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
