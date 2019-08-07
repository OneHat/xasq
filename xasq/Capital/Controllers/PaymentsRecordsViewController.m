//
//  PaymentsRecordsViewController.m
//  xasq
//
//  Created by dssj888@163.com on 2019/8/5.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "PaymentsRecordsViewController.h"
#import "PaymentsRecordsTableViewCell.h"
#import "PaymentHeaderView.h"
#import "PaymentTypeView.h"

@interface PaymentsRecordsViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) PaymentHeaderView *headerView;
@property (nonatomic, strong) PaymentTypeView *typeView;
@property (nonatomic, assign) NSInteger type;
@end

@implementation PaymentsRecordsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收支记录";
    self.view.backgroundColor = ThemeColorBackground;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavHeight+50, ScreenWidth, ScreenHeight - NavHeight - 50) style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = ThemeColorBackground;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.rowHeight = 45;
    _tableView.tableFooterView = [[UIView alloc] init];
    UIView *headerBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, NavHeight, ScreenWidth, 50)];
    _headerView = [[[UINib nibWithNibName:@"PaymentHeaderView" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
    _headerView.frame = CGRectMake(0, 0, ScreenWidth, 50);
    [_headerView.typeBtn addTarget:self action:@selector(typeBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [_headerView.currencyBtn addTarget:self action:@selector(currencyBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [headerBackgroundView addSubview:_headerView];
    [self.view addSubview:headerBackgroundView];
    [self.view addSubview:_tableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.shadowImage = [UIImage imageFromColor:ThemeColorNavLine];;
}

#pragma mark - 类型切换
- (void)typeBtnClick:(UIButton *)button {
    if (_type == 1) {
        return;
    }
    _type = 1;
    [button setTitleColor:ThemeColorBlue forState:(UIControlStateNormal)];
    [button setImage:[UIImage imageNamed:@"capital_type1"] forState:(UIControlStateNormal)];
    [_headerView.currencyBtn setTitleColor:ThemeColorText forState:(UIControlStateNormal)];
    [_headerView.currencyBtn setImage:[UIImage imageNamed:@"capital_type"] forState:(UIControlStateNormal)];
    [_typeView removeFromSuperview];
    _typeView = [[PaymentTypeView alloc] initWithFrame:CGRectMake(0, NavHeight+50, ScreenWidth, ScreenHeight - NavHeight - 50)];
    _typeView.type = _type;
    [self.view addSubview:_typeView];
}
#pragma mark - 币种切换
- (void)currencyBtnClick:(UIButton *)button {
    if (_type == 2) {
        return;
    }
    _type = 2;
    [button setTitleColor:ThemeColorBlue forState:(UIControlStateNormal)];
    [button setImage:[UIImage imageNamed:@"capital_type1"] forState:(UIControlStateNormal)];
    [_headerView.typeBtn setTitleColor:ThemeColorText forState:(UIControlStateNormal)];
    [_headerView.typeBtn setImage:[UIImage imageNamed:@"capital_type"] forState:(UIControlStateNormal)];
    [_typeView removeFromSuperview];
    _typeView = [[PaymentTypeView alloc] initWithFrame:CGRectMake(0, NavHeight+50, ScreenWidth, ScreenHeight - NavHeight - 50)];
    _typeView.type = _type;
    [self.view addSubview:_typeView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    headerView.backgroundColor = [UIColor whiteColor];
    UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(20, 23, ScreenWidth - 40, 20)];
    titleLB.textColor = ThemeColorTextGray;
    titleLB.font = ThemeFontTipText;
    titleLB.text = @"26日-星期五";
    [headerView addSubview:titleLB];

    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PaymentsRecordsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PaymentsRecordsTableViewCell"];
    if (cell == nil) {
        cell = [[[UINib nibWithNibName:@"PaymentsRecordsTableViewCell" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
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
