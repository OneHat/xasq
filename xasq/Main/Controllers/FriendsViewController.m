//
//  FriendsViewController.m
//  xasq
//
//  Created by dssj on 2019/8/14.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "FriendsViewController.h"
#import "FriendsRankViewCell.h"
#import "FriendsHeaderView.h"
#import "ContactsViewController.h"
#import "FriendMainViewController.h"
#import "UIViewController+ActionSheet.h"
#import "UITableView+Refresh.h"

#import <Contacts/Contacts.h>

@interface FriendsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) FriendsHeaderView *headerView;

@property (nonatomic, strong) NSMutableArray *friends;

@property (nonatomic, assign) NSInteger page;//页数
@property (nonatomic, assign) NSInteger totalPage;//总页数

@end

@implementation FriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"好友排行";
    self.view.backgroundColor = ThemeColorBackground;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.friends = [NSMutableArray array];
    
    CGRect frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight - NavHeight - BottomHeight);
    self.tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    [self.tableView registerNib:[UINib nibWithNibName:@"FriendsRankViewCell" bundle:nil] forCellReuseIdentifier:@"FriendsRankViewCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 55;
    self.tableView.backgroundColor = ThemeColorBackground;
    FriendsHeaderView *headerView = [[FriendsHeaderView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 85)];
    self.tableView.tableHeaderView = headerView;
    [self.view addSubview:self.tableView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(nextController)];
    [headerView addGestureRecognizer:tap];
    
    WeakObject
    [self.tableView pullHeaderRefresh:^{
        weakSelf.page = 1;
        [weakSelf getFriendList];
    }];
    
    [self.tableView pullFooterRefresh:^{
        
        if (weakSelf.page < weakSelf.totalPage) {
            weakSelf.page++;
            [weakSelf getFriendList];
        } else {
            [weakSelf.tableView endRefresh];
        }
        
    }];
    
    self.page = 1;
    [self getFriendList];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

///获取好友列表
- (void)getFriendList {
    
    NSDictionary *parameters = @{@"pageNo":@(self.page)};
    [[NetworkManager sharedManager] postRequest:UserRankFriends parameters:parameters success:^(NSDictionary * _Nonnull data) {
        [self.tableView endRefresh];
        
        self.totalPage = [data[@"data"][@"totalPage"] integerValue];
        
        NSArray *dateList = data[@"data"][@"rows"];
        if (!dateList || ![dateList isKindOfClass:[NSArray class]] || dateList.count == 0) {
            self.page--;
            return;
        }
        
        if (self.page == 1) {
            [self.friends removeAllObjects];
        }
        
        [self.friends addObjectsFromArray:[UserRankModel modelWithArray:dateList]];
        [self.tableView reloadData];
        
    } failure:^(NSError * _Nonnull error) {
        [self.tableView endRefresh];
        
    }];
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.friends.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FriendsRankViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendsRankViewCell"];
    
    cell.friendInfo = self.friends[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UserRankModel *model = self.friends[indexPath.row];
    if (model.userId == [UserDataManager shareManager].userId.integerValue) {
        return;
    }
    
    FriendMainViewController *friendVC = [[FriendMainViewController alloc] init];
    friendVC.userId = model.userId;
    [self.navigationController pushViewController:friendVC animated:YES];
}

#pragma mark -
- (void)nextController {
    
    //是否有权限
    CNAuthorizationStatus authorizationStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (authorizationStatus == CNAuthorizationStatusDenied || authorizationStatus == CNAuthorizationStatusRestricted) {
        //拒绝访问
        [self showDeniedAlert];
    } else {
        ContactsViewController *inviteVC = [[ContactsViewController alloc] init];
        [self.navigationController pushViewController:inviteVC animated:YES];
    }
    
}

///拒绝访问提示信息
- (void)showDeniedAlert {
    
    [self alertWithTitle:@"提示" message:@"无法获取通讯录，请到\"设置->隐私\"中打开通讯录权限" items:@[@"取消",@"确认"] action:^(NSInteger index) {
        
        if (index == 0) {
            [self dismissViewControllerAnimated:NO completion:nil];
            
        } else {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
        }
    }];
}

@end
