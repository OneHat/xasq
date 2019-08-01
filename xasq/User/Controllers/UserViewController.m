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
#import "AccountSetViewController.h"
#import "LanguageSetViewController.h"
#import "OurVersionViewController.h"
#import "LivingProofViewController.h"
#import "LoginViewController.h"
#import "confirmViewController.h"
#import "UserHeaderView.h"

@interface UserViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSDictionary *titleDict;
@property (nonatomic, strong) UserHeaderView *headerView;

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    _titleDict = @{@"0" : @[@"认证信息", @"账户设置", @"语言设置",], @"1" : @[@"版本信息", @"关于我们", @"联系我们"]};
    
    _headerView = [[[UINib nibWithNibName:@"UserHeaderView" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
    _headerView.frame = CGRectMake(0, 0, ScreenWidth, 290);
//    [_headerView.dwellBtn addTarget:self action:@selector(dwellBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, StatusBarHeight, ScreenWidth, ScreenHeight - StatusBarHeight - BarHeight) style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.separatorInset = UIEdgeInsetsMake(0, 55, 0, 15);
    _tableView.separatorColor = ThemeColorLine;
    _tableView.rowHeight = 50;
    _tableView.tableHeaderView = _headerView;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
}
    
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

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
    view.backgroundColor = ThemeColorView;
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserTableViewCell"];
    if (cell == nil) {
        cell = [[[UINib nibWithNibName:@"UserTableViewCell" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSString *key = [NSString stringWithFormat:@"%ld", indexPath.section];
    NSArray *titleArray = _titleDict[key];
    cell.titleLB.text = titleArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = [NSString stringWithFormat:@"%ld", indexPath.section];
    NSArray *titleArray = _titleDict[key];
    NSString *title = titleArray[indexPath.row];
    if ([title isEqualToString:@"认证信息"]) {
        CredentialsViewController *VC = [[CredentialsViewController alloc] init];
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    } else if ([title isEqualToString:@"账户设置"]) {
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
        confirmViewController *VC = [[confirmViewController alloc] init];
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    } else if ([title isEqualToString:@"居住证明"]) {
        LivingProofViewController *VC = [[LivingProofViewController alloc] init];
//        LoginViewController *VC = [[LoginViewController alloc] init];
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    }
}
#pragma mark - 居住证明
- (void)dwellBtnClick {
    LivingProofViewController *VC = [[LivingProofViewController alloc] init];
    VC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:VC animated:YES];
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
