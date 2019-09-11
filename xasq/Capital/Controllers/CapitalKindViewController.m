//
//  CapitalKindViewController.m
//  xasq
//
//  Created by dssj on 2019/8/2.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "CapitalKindViewController.h"
#import "MentionMoneyViewController.h"
#import "CapitalTopView.h"
#import "PaymentsRecordsTableViewCell.h"
#import "CapitalViewController.h"
#import "UIViewcontroller+ActionSheet.h"
#import "PaymentsRecordModel.h"

@interface CapitalKindViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSString *causeType; // 流水类型
@property (nonatomic, strong) NSMutableDictionary *dataDict; // 数据源
@property (nonatomic, strong) NSMutableArray *titleArray;  // 分区标题
@property (nonatomic, assign) NSInteger pageNo;  // 分页
@property (nonatomic, assign) NSInteger totalPage; // 最大页数
@end

@implementation CapitalKindViewController
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ThemeColorBackground;
    _causeType = @"";
    _pageNo = 1;
    _totalPage = 1;
    _dataDict = [NSMutableDictionary dictionary];
    _titleArray = [NSMutableArray array];
    //背景
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    imageView.image = [UIImage imageNamed:@"capital_topBackground"];
    imageView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:imageView];
    WeakObject;
    //title
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, StatusBarHeight, ScreenWidth, 44)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = _model.currency;
    titleLabel.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:titleLabel];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, StatusBarHeight, 44, 44)];
    [backButton setImage:[UIImage imageNamed:@"leftBar_back_white"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    //资产view
    CapitalTopView *topView = [[CapitalTopView alloc] initWithFrame:CGRectMake(0, NavHeight, ScreenWidth, 20)];
    topView.viewStyle = CapitalTopViewHold;
    topView.BTCStr = [NSString stringWithFormat:@"%@ %@",_model.amount,_model.currency];
    topView.moneyStr = _model.toCNY?_model.toCNY:@"--";
    topView.DrawClickBlock = ^{
        //提币
        MentionMoneyViewController *mentionMoneyViewVC = [[MentionMoneyViewController alloc] init];
        mentionMoneyViewVC.model = weakSelf.model;
        mentionMoneyViewVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:mentionMoneyViewVC animated:YES];
    };
    [self.view addSubview:topView];
    
    ////topView的高度会根据内容自己计算，这里重新赋值高度给外层
    CGFloat imageViewH = topView.frame.size.height + NavHeight;
    imageView.frame = CGRectMake(0, 0, ScreenWidth, imageViewH);
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, imageViewH + 10, ScreenWidth, 30)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, 30)];
    label.backgroundColor = [UIColor whiteColor];
    label.text = @"收支记录";
    label.font = [UIFont boldSystemFontOfSize:18];
    [backView addSubview:label];
    
    UIButton *recordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    recordButton.frame = CGRectMake(ScreenWidth - 80, 5, 60, 20);
    [recordButton setTitle:@"筛选 " forState:UIControlStateNormal];
    recordButton.titleLabel.font = ThemeFontSmallText;
    [recordButton setTitleColor:ThemeColorText forState:UIControlStateNormal];
    [recordButton addTarget:self action:@selector(shiftClick) forControlEvents:UIControlEventTouchUpInside];
    UIImage *image = [UIImage imageNamed:@"shift_button"];
    [recordButton setBackgroundImage:[image resizeImageInCenter] forState:UIControlStateNormal];
    [backView addSubview:recordButton];
    
    CGRect rect = CGRectMake(0, CGRectGetMaxY(backView.frame), ScreenWidth, ScreenHeight - CGRectGetMaxY(backView.frame) - BottomHeight);
    _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 45;
    [self.view addSubview:_tableView];
    
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
    [self communityCapitalWater];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)backButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)communityCapitalWater {
    NSDictionary *dict = @{@"causeType"    : _causeType,
                           @"currency"     : _model.currency,
                           @"pageNo"       : [NSString stringWithFormat:@"%ld",_pageNo],
                           };
    [[NetworkManager sharedManager] getRequest:CommunityCapitalWater parameters:dict success:^(NSDictionary * _Nonnull data) {
        NSArray *array = data[@"data"][@"rows"];
        if ([array isKindOfClass:[NSArray class]]) {
            NSString *key;
            NSMutableArray *typeArr = [NSMutableArray array];
            self.totalPage = [data[@"data"][@"totalPage"] integerValue];
            if (self.titleArray.count > 0) {
                // 上拉添加数据
                key = self.titleArray.lastObject;
                typeArr = [NSMutableArray arrayWithArray:self.dataDict[key]];
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
                    [self.dataDict setValue:typeArr forKey:key];
                    if (![key isEqualToString:self.titleArray.lastObject]) {
                        // 防止出现上拉添加数据中第一天数据跟之前数据的最后一条数据是在同一天
                        [self.titleArray addObject:key];
                    }
                    key = dic[@"time"];
                    typeArr = [NSMutableArray array];
                    [typeArr addObject:model];
                }
                if (i == array.count - 1) {
                    // 直接加最后一条数据
                    [self.dataDict setValue:typeArr forKey:key];
                    if (![key isEqualToString:self.titleArray.lastObject]) {
                        // 防止出现上拉添加数据中第一天数据跟之前数据的最后一条数据是在同一天
                        [self.titleArray addObject:key];
                    }
                }
            }
            [self.tableView hideEmptyView];
        } else {
            if (self.pageNo == 1) {
                [self.tableView showEmptyView:EmptyViewReasonNoData msg:nil refreshBlock:nil];
            }
        }
        [self.tableView endRefresh];
        [self.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        [self.tableView endRefresh];
        [self showErrow:error];
    }];
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
    cell.model = model;
    
    return cell;
}


#pragma mark -
- (void)shiftClick {
    [self actionSheetWithItems:@[@"全部",@"提币",@"奖励"] complete:^(NSInteger index) {
        if (index == 0) {
            self.causeType = @"";
        } else if (index == 1) {
            self.causeType = @"12";
        } else {
            self.causeType = @"14";
        }
        self.pageNo = 1;
        [self.dataDict removeAllObjects];
        [self.titleArray removeAllObjects];
        [self communityCapitalWater];
    }];
}

@end
