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

@interface CapitalKindViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation CapitalKindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ThemeColorBackground;
    
    //背景
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    imageView.image = [UIImage imageNamed:@"capital_topBackground"];
    imageView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:imageView];
    
    //title
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, StatusBarHeight, ScreenWidth, 44)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"BTC";
    titleLabel.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:titleLabel];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, StatusBarHeight, 44, 44)];
    [backButton setImage:[UIImage imageNamed:@"leftBar_back_white"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    //资产view
    CapitalTopView *topView = [[CapitalTopView alloc] initWithFrame:CGRectMake(0, NavHeight, ScreenWidth, 20)];
    topView.viewStyle = CapitalTopViewHold;
    topView.DrawClickBlock = ^{
        //提币
        MentionMoneyViewController *mentionMoneyViewVC = [[MentionMoneyViewController alloc] init];
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
    
    CGRect rect = CGRectMake(0, CGRectGetMaxY(backView.frame), ScreenWidth, ScreenHeight - imageViewH - 10);
    _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    [_tableView registerNib:[UINib nibWithNibName:@"PaymentsRecordsTableViewCell" bundle:nil] forCellReuseIdentifier:@"PaymentsRecordsTableViewCell"];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 45;
    [self.view addSubview:_tableView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:DSSJTabBarSelectCapitalNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)backButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PaymentsRecordsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PaymentsRecordsTableViewCell"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    headerView.backgroundColor = [UIColor whiteColor];
    UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, ScreenWidth - 40, 30)];
    titleLB.textColor = ThemeColorTextGray;
    titleLB.font = ThemeFontTipText;
    titleLB.text = @"26日-星期五";
    [headerView addSubview:titleLB];
    
    return headerView;
}

#pragma mark -
- (void)shiftClick {
    [self actionSheetWithItems:@[@"充币",@"提币",@"奖励"] complete:^(NSInteger index) {
        
    }];
}

@end
