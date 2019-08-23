//
//  UserViewController.m
//  xasq
//
//  Created by dssj on 2019/7/26.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "UserViewController.h"
#import "UserTableViewCell.h"
#import "CredentialsViewController.h"
#import "UnauthorizedViewController.h"
#import "AccountSetViewController.h"
#import "LanguageSetViewController.h"
#import "OurVersionViewController.h"
#import "LivingProofViewController.h"
#import "LoginViewController.h"
#import "ConfirmViewController.h"
#import "UserHeaderView.h"
#import "MessageViewController.h"
#import "FriendsViewController.h"
#import "TaskViewController.h"

@interface UserViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSDictionary *titleDict;
@property (nonatomic, strong) NSDictionary *imageTitleDict;
@property (nonatomic, strong) UserHeaderView *headerView;

//参考HomeViewController（首页）
@property (assign, nonatomic) BOOL hideNavBarAnimation;

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    _titleDict = @{@"0" : @[@"账户设置", @"语言设置",], @"1" : @[@"版本信息", @"关于我们", @"联系我们"]};
    _imageTitleDict = @{@"0" : @[@"account_settings", @"language_settings",], @"1" : @[@"version_information", @"about_us", @"contact_us"]};

    _headerView = [[[UINib nibWithNibName:@"UserHeaderView" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
    _headerView.frame = CGRectMake(0, 0, ScreenWidth, 290);
    WeakObject;
    _headerView.dwellBtnBlock = ^{
        // 用户信息界面
        LivingProofViewController *VC = [[LivingProofViewController alloc] init];
        VC.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:VC animated:YES];
    };
    _headerView.messageBtnBlock = ^{
        // 消息通知界面
        MessageViewController *VC = [[MessageViewController alloc] init];
        VC.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:VC animated:YES];
    };
    _headerView.taskBtnBlock = ^{
        // 任务界面
        TaskViewController *VC = [[TaskViewController alloc] init];
        VC.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:VC animated:YES];
    };
    _headerView.friendBtnBlock = ^{
        // 好友界面
        FriendsViewController *friendsVC = [[FriendsViewController alloc] init];
        friendsVC.hidesBottomBarWhenPushed = YES;
        [weakSelf.navigationController pushViewController:friendsVC animated:YES];
    };
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, StatusBarHeight, ScreenWidth, ScreenHeight - StatusBarHeight - BottomHeight - 49) style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorInset = UIEdgeInsetsMake(0, 55, 0, 15);
    _tableView.separatorColor = ThemeColorLine;
    _tableView.rowHeight = 50;
    _tableView.tableHeaderView = _headerView;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    //
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeUserHideAnimation) name:DSSJTabBarSelectUserNotification object:nil];
}
    
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:_hideNavBarAnimation];
    _hideNavBarAnimation = YES;
    if ([UserDataManager shareManager].userId) {
        [self getUserinfoData];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)changeUserHideAnimation {
    _hideNavBarAnimation = NO;
}

- (void)getUserinfoData {
    WeakObject;
    NSDictionary *dict = @{@"sysVersion"      :   [AppVersion stringByReplacingOccurrencesOfString:@"." withString:@""],
                           };
    [[NetworkManager sharedManager] getRequest:UserHomePageInfo parameters:dict success:^(NSDictionary * _Nonnull data) {
        NSDictionary *userData = data[@"data"];
        
        if (userData) {
            [[UserDataManager shareManager] saveUserData:userData];
            if ([UserDataManager shareManager].usermodel.nickName.length > 0) {
                weakSelf.headerView.nameLB.text = [UserDataManager shareManager].usermodel.nickName;
            } else {
                weakSelf.headerView.nameLB.text = [UserDataManager shareManager].usermodel.userName;
            }
            weakSelf.headerView.regionLB.text = [UserDataManager shareManager].usermodel.areaName;
            [weakSelf.headerView.portraitImageV sd_setImageWithURL:[NSURL URLWithString:[UserDataManager shareManager].usermodel.headImg]
                                                  placeholderImage:[UIImage imageNamed:@"head_portrait"]];
        }
    } failure:^(NSError * _Nonnull error) {
//        [self showErrow:error];
    }];
}

#pragma mark-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _titleDict.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *key = [NSString stringWithFormat:@"%ld", section];
    return [_titleDict[key] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    view.backgroundColor = ThemeColorBackground;
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserTableViewCell"];
    if (cell == nil) {
        cell = [[[UINib nibWithNibName:@"UserTableViewCell" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.rightLB.hidden = YES;
    NSString *key = [NSString stringWithFormat:@"%ld", indexPath.section];
    NSArray *titleArray = _titleDict[key];
    NSArray *imageTitleArray = _imageTitleDict[key];
    cell.titleLB.text = titleArray[indexPath.row];
    if ([titleArray[indexPath.row] isEqualToString:@"版本信息"]) {
        cell.rightLB.text = [NSString stringWithFormat:@"v%@",AppVersion];
        cell.rightLB.hidden = NO;
    }
    cell.iconImageV.image = [UIImage imageNamed:imageTitleArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [NSString stringWithFormat:@"%ld", indexPath.section];
    NSArray *titleArray = _titleDict[key];
    NSString *title = titleArray[indexPath.row];
    if ([title isEqualToString:@"账户设置"]) {
        AccountSetViewController *VC = [[AccountSetViewController alloc] init];
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    } else if ([title isEqualToString:@"语言设置"]) {
        LanguageSetViewController *VC = [[LanguageSetViewController alloc] init];
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    } else if ([title isEqualToString:@"版本信息"]) {
        OurVersionViewController *VC = [[OurVersionViewController alloc] init];
        VC.type = 0;
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    } else if ([title isEqualToString:@"关于我们"]) {
        OurVersionViewController *VC = [[OurVersionViewController alloc] init];
        VC.type = 1;
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    } else if ([title isEqualToString:@"联系我们"]) {
        ConfirmViewController *VC = [[ConfirmViewController alloc] init];
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
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
