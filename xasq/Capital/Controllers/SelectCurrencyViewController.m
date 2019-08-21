//
//  SelectCurrencyViewController.m
//  xasq
//
//  Created by dssj888@163.com on 2019/8/5.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "SelectCurrencyViewController.h"
#import "SelectCurrencyTableViewCell.h"

@interface SelectCurrencyViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation SelectCurrencyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择币种";
    self.view.backgroundColor = ThemeColorBackground;
    _dataArray = [NSMutableArray array];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavHeight, ScreenWidth, ScreenHeight - NavHeight) style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = ThemeColorBackground;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 0);
    _tableView.separatorColor = ThemeColorLine;
    _tableView.rowHeight = 50;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self CommunityCapitalCurrencyBalance];
}

- (void)CommunityCapitalCurrencyBalance {
    WeakObject;
    NSDictionary *dict = @{@"userId" : [UserDataManager shareManager].userId,
                           @"pageNo" : @"1",
                           };
    [[NetworkManager sharedManager] getRequest:CommunityCapitalCurrencyBalance parameters:dict success:^(NSDictionary * _Nonnull data) {
        NSArray *rows = data[@"data"][@"rows"];
        if ([rows isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dic in rows) {
                CapitalModel *model = [CapitalModel modelWithDictionary:dic];
                [weakSelf.dataArray addObject:model];
            }
            [weakSelf.tableView reloadData];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    headerView.backgroundColor = ThemeColorBackground;
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SelectCurrencyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SelectCurrencyTableViewCell"];
    if (cell == nil) {
        cell = [[[UINib nibWithNibName:@"SelectCurrencyTableViewCell" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    CapitalModel *model = _dataArray[indexPath.row];
    cell.nameLB.text = model.currency;
    cell.amountLB.text = model.amount;
    NSString *imageStr = [model.icon stringByReplacingOccurrencesOfString:@"data:image/jpg;base64," withString:@""];
    NSData *imageData = [[NSData alloc]initWithBase64EncodedString:imageStr options:NSDataBase64DecodingIgnoreUnknownCharacters];
    UIImage *icon = [UIImage imageWithData:imageData];
    if (icon) {
        cell.iconImageV.image = icon;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CapitalModel *model = _dataArray[indexPath.row];
    if (_CapitalModelBlock) {
        _CapitalModelBlock(model);
    }
    [self.navigationController popViewControllerAnimated:YES];
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
