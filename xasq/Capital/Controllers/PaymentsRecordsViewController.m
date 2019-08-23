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
#import "PaymentsRecordModel.h"
#import "CapitalModel.h"

@interface PaymentsRecordsViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) PaymentHeaderView *headerView;
@property (nonatomic, strong) PaymentTypeView *typeView;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSString *causeType; // 流水类型
@property (nonatomic, strong) NSString *currency; // 币种
@property (nonatomic, strong) NSMutableDictionary *dataDict; // 数据源
@property (nonatomic, strong) NSMutableArray *titleArray;  // 分区标题
@property (nonatomic, strong) NSMutableArray *currencyArray; // 币种数据
@property (nonatomic, assign) NSInteger pageNo;  // 分页
@property (nonatomic, assign) NSInteger totalPage; // 最大页数
@end

@implementation PaymentsRecordsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收支记录";
    self.view.backgroundColor = ThemeColorBackground;
    _causeType = @"";
    _currency = @"";
    _pageNo = 1;
    _totalPage = 1;
    _dataDict = [NSMutableDictionary dictionary];
    _titleArray = [NSMutableArray array];
    _currencyArray = [NSMutableArray array];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavHeight+50, ScreenWidth, ScreenHeight - NavHeight - 50 - BottomHeight) style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = ThemeColorBackground;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.rowHeight = 45;
    _tableView.tableFooterView = [[UIView alloc] init];
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    WeakObject;
    [_tableView pullHeaderRefresh:^{
        weakSelf.pageNo = 1;
        [weakSelf.dataDict removeAllObjects];
        [weakSelf.titleArray removeAllObjects];
        [weakSelf communityCapitalWater];
    }];
    [_tableView pullFooterRefresh:^{
        weakSelf.pageNo++;
        if (weakSelf.pageNo <= weakSelf.totalPage) {
            [self communityCapitalWater];
        } else {
            [weakSelf.tableView endRefresh];
        }
    }];
    
    UIView *headerBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, NavHeight, ScreenWidth, 50)];
    _headerView = [[[UINib nibWithNibName:@"PaymentHeaderView" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
    _headerView.frame = CGRectMake(0, 0, ScreenWidth, 50);
    [_headerView.typeBtn addTarget:self action:@selector(typeBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [_headerView.currencyBtn addTarget:self action:@selector(currencyBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [headerBackgroundView addSubview:_headerView];
    [self.view addSubview:headerBackgroundView];
    [self.view addSubview:_tableView];
    [self sendCommunityAreaCurrency];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.shadowImage = [UIImage imageFromColor:ThemeColorNavLine];
    [self communityCapitalWater];
}

- (void)sendCommunityAreaCurrency {
    WeakObject;
    [[NetworkManager sharedManager] getRequest:CommunityAreaCurrency parameters:nil success:^(NSDictionary * _Nonnull data) {
        if (data) {
            for (NSDictionary *dic in data[@"data"]) {
                CapitalModel *model = [CapitalModel modelWithDictionary:dic];
                [weakSelf.currencyArray addObject:model];
            }
        }
    } failure:^(NSError * _Nonnull error) {
        [self showErrow:error];
    }];
}

- (void)communityCapitalWater {
    WeakObject;
    NSDictionary *dict = @{@"causeType"    : _causeType,
                           @"currency"     : _currency,
                           @"pageNo"       : [NSString stringWithFormat:@"%ld",_pageNo],
                           };
    [[NetworkManager sharedManager] getRequest:CommunityCapitalWater parameters:dict success:^(NSDictionary * _Nonnull data) {
        NSArray *array = data[@"data"][@"rows"];
        if ([array isKindOfClass:[NSArray class]]) {
            NSString *key;
            NSMutableArray *typeArr = [NSMutableArray array];
            weakSelf.totalPage = [data[@"data"][@"totalPage"] integerValue];
            if (weakSelf.titleArray.count > 0) {
                // 上拉添加数据
                key = weakSelf.titleArray.lastObject;
                typeArr = [NSMutableArray arrayWithArray:weakSelf.dataDict[key]];
            } else {
                // 下拉刷新数据
                key = array.firstObject[@"time"];
            }
            for (int i=0; i < array.count; i++) {
                NSDictionary *dic = array[i];
                PaymentsRecordModel *model = [PaymentsRecordModel modelWithDictionary:dic];
                if ([key isEqualToString:dic[@"time"]]) {
                    [typeArr addObject:model];
                } else {
                    [weakSelf.dataDict setValue:typeArr forKey:key];
                    if (![key isEqualToString:weakSelf.titleArray.lastObject]) {
                        // 防止出现上拉添加数据中第一天数据跟之前数据的最后一条数据是在同一天
                        [weakSelf.titleArray addObject:key];
                    }
                    key = dic[@"time"];
                    typeArr = [NSMutableArray array];
                    [typeArr addObject:model];
                }
                if (i == array.count - 1) {
                    // 直接加最后一条数据
                    [weakSelf.dataDict setValue:typeArr forKey:key];
                    [weakSelf.titleArray addObject:key];
                }
            }
        }
        [weakSelf.tableView endRefresh];
        [weakSelf.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        [weakSelf.tableView endRefresh];
        [self showErrow:error];
    }];
}

#pragma mark - 类型切换
- (void)typeBtnClick:(UIButton *)button {
    _type = 2;
    WeakObject;
    [button setTitleColor:ThemeColorBlue forState:(UIControlStateNormal)];
    [button setImage:[UIImage imageNamed:@"capital_type1"] forState:(UIControlStateNormal)];
    [_headerView.currencyBtn setTitleColor:ThemeColorText forState:(UIControlStateNormal)];
    [_headerView.currencyBtn setImage:[UIImage imageNamed:@"capital_type"] forState:(UIControlStateNormal)];
    [_typeView removeFromSuperview];
    _typeView = [[PaymentTypeView alloc] initWithFrame:CGRectMake(0, NavHeight+50, ScreenWidth, ScreenHeight - NavHeight - 50)];
    _typeView.type = _type;
    _typeView.paymentTypeBlock = ^(NSInteger index) {
        if (index == 0) {
            weakSelf.causeType = @"";
        } else if (index == 1) {
            weakSelf.causeType = @"14";
        } else {
            weakSelf.causeType = @"12";
        }
        [weakSelf.dataDict removeAllObjects];
        [weakSelf.titleArray removeAllObjects];
        [weakSelf communityCapitalWater];
    };
    [self.view addSubview:_typeView];
}
#pragma mark - 币种切换
- (void)currencyBtnClick:(UIButton *)button {
    _type = 1;
    WeakObject;
    [button setTitleColor:ThemeColorBlue forState:(UIControlStateNormal)];
    [button setImage:[UIImage imageNamed:@"capital_type1"] forState:(UIControlStateNormal)];
    [_headerView.typeBtn setTitleColor:ThemeColorText forState:(UIControlStateNormal)];
    [_headerView.typeBtn setImage:[UIImage imageNamed:@"capital_type"] forState:(UIControlStateNormal)];
    [_typeView removeFromSuperview];
    _typeView = [[PaymentTypeView alloc] initWithFrame:CGRectMake(0, NavHeight+50, ScreenWidth, ScreenHeight - NavHeight - 50)];
    _typeView.type = _type;
    [_typeView setCommunityAreaCurrency:_currencyArray];
    _typeView.paymentTypeBlock = ^(NSInteger index) {
        if (index == 0) {
            weakSelf.currency = @"";
        } else {
            CapitalModel *model = weakSelf.currencyArray[index-1];
            weakSelf.currency = model.currency;
        }
        [weakSelf.dataDict removeAllObjects];
        [weakSelf.titleArray removeAllObjects];
        [weakSelf communityCapitalWater];
    };
    [self.view addSubview:_typeView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _titleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *key = _titleArray[section];
    NSArray *value = _dataDict[key];
    return value.count;
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
    NSString *key = _titleArray[section];
    titleLB.text = key;
    [headerView addSubview:titleLB];

    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PaymentsRecordsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PaymentsRecordsTableViewCell"];
    if (cell == nil) {
        cell = [[[UINib nibWithNibName:@"PaymentsRecordsTableViewCell" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSString *key = _titleArray[indexPath.section];
    NSArray *value = _dataDict[key];
    PaymentsRecordModel *model = value[indexPath.row];
    cell.titleLB.text = model.nameStr;
    cell.valueLB.text = [NSString stringWithFormat:@"%@",model.amount];
    if ([model.cause integerValue] == 2) {
        cell.icon.image = [UIImage imageNamed:@"Capital_DrawMoney"];
    } else if ([model.cause integerValue] == 14) {
        cell.icon.image = [UIImage imageNamed:@"capital_reward"];
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
