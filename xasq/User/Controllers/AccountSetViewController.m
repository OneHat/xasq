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

@interface AccountSetViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation AccountSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户设置";
    self.view.backgroundColor = ThemeColorView;
    
    _titleArray = @[@"修改登录密码", @"设置支付密码", @"绑定邮箱", @"绑定手机"];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavHeight, ScreenWidth, ScreenHeight - NavHeight) style:(UITableViewStylePlain)];
    _tableView.backgroundColor = ThemeColorView;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 55, 0, 0);
    _tableView.separatorColor = ThemeColorLine;
    _tableView.rowHeight = 45;
    _tableView.tableFooterView = [[UIView alloc] init];
    
    UIButton *footButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    footButton.frame = CGRectMake(0, 0, ScreenWidth, 50);
    [footButton setTitle:@"退出登录" forState:(UIControlStateNormal)];
    [footButton setTitleColor:ThemeColorTitle forState:(UIControlStateNormal)];
    footButton.titleLabel.font = [UIFont systemFontOfSize:19];
    footButton.backgroundColor = [UIColor whiteColor];
    _tableView.tableFooterView = footButton;
    [self.view addSubview:_tableView];
    
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
    cell.nameLB.text = name;
    cell.contentLB.hidden = YES;
    cell.arrowImageV.hidden = NO;
    if (indexPath.row == 0) {
        
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
        BindPhoneAndEmailViewController *VC = [[BindPhoneAndEmailViewController alloc] init];
        VC.type = 1; // 绑定邮箱
        [self.navigationController pushViewController:VC animated:YES];
    } else if (indexPath.row == 3) {
        BindPhoneAndEmailViewController *VC = [[BindPhoneAndEmailViewController alloc] init];
        VC.type = 0; // 绑定手机
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
