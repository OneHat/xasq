//
//  messageInformViewController.m
//  xasq
//
//  Created by dssj888@163.com on 2019/8/2.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "messageInformViewController.h"
#import "AssetDynamicTableViewCell.h"
#import "AccountUpgradeTableViewCell.h"
#import "CommunityDynamicTableViewCell.h"

@interface messageInformViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;


@end

@implementation messageInformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息通知";
    self.view.backgroundColor = ThemeColorBackground;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavHeight, ScreenWidth, ScreenHeight - NavHeight) style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.rowHeight = 180;
    _tableView.backgroundColor = ThemeColorBackground;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    headerView.backgroundColor = ThemeColorBackground;
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 12, 15, 15)];
    icon.image = [UIImage imageNamed:@"message_time"];
    [headerView addSubview:icon];
    UILabel *timeLB = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, ScreenWidth - 45, 20)];
    timeLB.textColor = ThemeColorTextGray;
    timeLB.font = ThemeFontTipText;
    if (section == 0) {
        timeLB.text = @"昨天";
    } else {
        timeLB.text = @"2019-05-26";
    }
    [headerView addSubview:timeLB];

    return headerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            AssetDynamicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AssetDynamicTableViewCell"];
            if (cell == nil) {
                cell = [[[UINib nibWithNibName:@"AssetDynamicTableViewCell" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return cell;
        } else {
            AccountUpgradeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccountUpgradeTableViewCell"];
            if (cell == nil) {
                cell = [[[UINib nibWithNibName:@"AccountUpgradeTableViewCell" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return cell;
        }
    } else {
        if (indexPath.row == 0) {
            CommunityDynamicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommunityDynamicTableViewCell"];
            if (cell == nil) {
                cell = [[[UINib nibWithNibName:@"CommunityDynamicTableViewCell" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return cell;
        } else {
            AccountUpgradeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccountUpgradeTableViewCell"];
            if (cell == nil) {
                cell = [[[UINib nibWithNibName:@"AccountUpgradeTableViewCell" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            return cell;
        }
    }
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
