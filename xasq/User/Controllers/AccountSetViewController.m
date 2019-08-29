//
//  AccountSetViewController.m
//  xasq
//
//  Created by dssj888@163.com on 2019/7/29.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "AccountSetViewController.h"
#import "AccountSetTableViewCell.h"
#import "BindPhoneAndEmailViewController.h"
#import "PayAndLoginPasswordViewController.h"
#import "ChangePhoneAndEmailViewController.h"
#import "UIViewController+ActionSheet.h"

@interface AccountSetViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *imageTitleArray;


@end

@implementation AccountSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户设置";
    self.view.backgroundColor = ThemeColorBackground;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _titleArray = @[@"修改登录密码", @"设置支付密码", @"绑定邮箱", @"绑定手机"];
    _imageTitleArray = @[@"change_login_password", @"set_pay_password", @"binding_email", @"binding_phone"];

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - NavHeight) style:(UITableViewStylePlain)];
    _tableView.backgroundColor = ThemeColorBackground;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 55, 0, 0);
    _tableView.separatorColor = ThemeColorLine;
    _tableView.rowHeight = 45;
    
    UIButton *footButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    footButton.frame = CGRectMake(0, 0, ScreenWidth, 50);
    [footButton setTitle:@"退出登录" forState:(UIControlStateNormal)];
    [footButton setTitleColor:ThemeColorText forState:(UIControlStateNormal)];
    footButton.titleLabel.font = [UIFont systemFontOfSize:15];
    footButton.backgroundColor = [UIColor whiteColor];
    [footButton addTarget:self action:@selector(quitLoginClick) forControlEvents:(UIControlEventTouchUpInside)];
    _tableView.tableFooterView = footButton;
    [self.view addSubview:_tableView];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)quitLoginClick {
    
    [self alertWithTitle:@"提示" message:@"是否退出登录?" items:@[@"取消",@"确定"] action:^(NSInteger index) {
        
        if (index == 0) {
            [self dismissViewControllerAnimated:NO completion:nil];
            
        } else {
            [self dismissViewControllerAnimated:NO completion:nil];
            
            [[UserDataManager shareManager] deleteLoginStatus];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:DSSJUserLogoutNotification object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:DSSJTabBarSelectHomeNotification object:nil];
            
            NSArray *VCArr = self.navigationController.viewControllers;
            UIViewController *topVC = VCArr.firstObject;
            UITabBarController *tabbarVC = topVC.tabBarController;
            tabbarVC.selectedIndex = 0;
            [self.navigationController popViewControllerAnimated:NO];
        }
        
    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AccountSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AccountSetTableViewCell"];
    if (cell == nil) {
        cell = [[[UINib nibWithNibName:@"AccountSetTableViewCell" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSString *name = _titleArray[indexPath.row];
    NSString *imageName = _imageTitleArray[indexPath.row];
    cell.nameLB.text = name;
    cell.iconImageV.image = [UIImage imageNamed:imageName];
    cell.contentLB.hidden = YES;
    cell.arrowImageV.hidden = NO;
    if (indexPath.row == 2) {
        cell.contentLB.hidden = NO;
        if ([UserDataManager shareManager].usermodel.email.length > 0) {
            cell.contentLB.text = [UserDataManager shareManager].usermodel.email;
        } else {
            cell.contentLB.text = @"未绑定";
        }
    } else if (indexPath.row == 3) {
        cell.contentLB.hidden = NO;
        if ([UserDataManager shareManager].usermodel.mobile.length > 0) {
            cell.contentLB.text = [UserDataManager shareManager].usermodel.mobile;
        } else {
            cell.contentLB.text = @"未绑定";
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        PayAndLoginPasswordViewController *VC = [[PayAndLoginPasswordViewController alloc] init];
        VC.type = 0; // 修改登录密码
        [self.navigationController pushViewController:VC animated:YES];
    } else if (indexPath.row == 1) {
        PayAndLoginPasswordViewController *VC = [[PayAndLoginPasswordViewController alloc] init];
        VC.type = 1; // 设置支付密码
        [self.navigationController pushViewController:VC animated:YES];
    } else if (indexPath.row == 2) {
        if ([UserDataManager shareManager].usermodel.email.length > 0) {
            ChangePhoneAndEmailViewController *VC = [[ChangePhoneAndEmailViewController alloc] init];
            VC.type = 1;
            [self.navigationController pushViewController:VC animated:YES];
        } else {
            BindPhoneAndEmailViewController *VC = [[BindPhoneAndEmailViewController alloc] init];
            VC.type = 1; // 绑定邮箱
            [self.navigationController pushViewController:VC animated:YES];
        }
    } else if (indexPath.row == 3) {
        if ([UserDataManager shareManager].usermodel.mobile.length > 0) {
            ChangePhoneAndEmailViewController *VC = [[ChangePhoneAndEmailViewController alloc] init];
            VC.type = 0;
            [self.navigationController pushViewController:VC animated:YES];
        } else {
            BindPhoneAndEmailViewController *VC = [[BindPhoneAndEmailViewController alloc] init];
            VC.type = 0; // 绑定手机
            [self.navigationController pushViewController:VC animated:YES];
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
