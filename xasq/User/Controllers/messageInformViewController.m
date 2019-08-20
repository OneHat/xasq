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
@property (nonatomic, strong) NSArray *messages;

@end

@implementation messageInformViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息通知";
    self.view.backgroundColor = ThemeColorBackground;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavHeight, ScreenWidth, ScreenHeight - NavHeight - BottomHeight - 10) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.estimatedRowHeight = 180;
    _tableView.backgroundColor = HexColor(@"#F3F3F3");
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    
    NSDictionary *parameters = @{@"userId":[UserDataManager shareManager].userId,@"pageNo":@"0",@"pageSize":@"10"};
    [[NetworkManager sharedManager] postRequest:MessageSysList parameters:parameters success:^(NSDictionary * _Nonnull data) {
        
        NSArray *array = data[@"data"][@"rows"];
        if (array && [array isKindOfClass:[NSArray class]] && array.count > 0) {
            self.messages = array;
            [self.tableView reloadData];
            return;
        }
        
        [self.view showEmptyView:EmptyViewReasonNoData refreshBlock:nil];
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *info = self.messages[indexPath.row];
    
    if ([info[@"type"] integerValue] == 1003) {
        CommunityDynamicTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommunityDynamicCell"];
        if (cell == nil) {
            cell = [[NSBundle mainBundle] loadNibNamed:@"CommunityDynamicTableViewCell" owner:nil options:nil].firstObject;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        cell.messageInfo = info;
        
        return cell;
        
        
    } else if ([info[@"type"] integerValue] == 1002) {
        AccountUpgradeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccountUpgradeTableViewCell"];
        if (cell == nil) {
            cell = [[[UINib nibWithNibName:@"AccountUpgradeTableViewCell" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
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

@end
