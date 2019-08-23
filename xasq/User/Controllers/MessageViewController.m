//
//  MessageViewController.m
//  xasq
//
//  Created by dssj888@163.com on 2019/8/2.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "MessageViewController.h"
#import "AssetDynamicTableViewCell.h"
#import "AccountUpgradeTableViewCell.h"
#import "CommunityDynamicTableViewCell.h"
#import "UITableView+Refresh.h"

@interface MessageViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *messages;

@property (nonatomic, assign) NSInteger totalPage;//总页数
@property (nonatomic, assign) NSInteger page;//页数

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息通知";
    self.view.backgroundColor = ThemeColorBackground;
    
    self.messages = [NSMutableArray array];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavHeight, ScreenWidth, ScreenHeight - NavHeight - BottomHeight - 10) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.estimatedRowHeight = 180;
    _tableView.backgroundColor = HexColor(@"#F3F3F3");
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    [self.tableView pullHeaderRefresh:^{
        self.page = 1;
        [self getMessages];
    }];
    
    [self.tableView pullFooterRefresh:^{
        
        if (self.page < self.totalPage) {
            self.page++;
            [self getMessages];
            return;
        }
        [self.tableView endRefresh];
        
    }];
    
    self.page = 1;
    [self getMessages];
}

#pragma mark -
- (void)getMessages {
    NSDictionary *parameters = @{@"pageNo":@(1)};
    [[NetworkManager sharedManager] postRequest:MessageSysList parameters:parameters success:^(NSDictionary * _Nonnull data) {
        [self.tableView endRefresh];
        
        NSArray *array = data[@"data"][@"rows"];
        self.totalPage = [data[@"data"][@"totalPage"] integerValue];
        
        if (array && [array isKindOfClass:[NSArray class]] && array.count > 0) {
            
            if (self.page == 1) {
                [self.messages removeAllObjects];
            }
            [self.messages addObjectsFromArray:array];
            [self.tableView reloadData];
            return;
        }
        
        [self.tableView endRefresh];
        if (self.messages.count == 0) {
            [self.view showEmptyView:EmptyViewReasonNoData refreshBlock:nil];
        }
        
    } failure:^(NSError * _Nonnull error) {
        [self.tableView endRefresh];
        if (self.messages.count == 0) {
            [self.view showEmptyView:EmptyViewReasonNoData refreshBlock:nil];
        }
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
