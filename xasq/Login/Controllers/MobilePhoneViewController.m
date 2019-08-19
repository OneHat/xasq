//
//  MobilePhoneViewController.m
//  xasq
//
//  Created by dssj888@163.com on 2019/8/9.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "MobilePhoneViewController.h"
#import "MobilePhoneTableViewCell.h"
#import "CountryCodeModel.h"

@interface MobilePhoneViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *tableDict; // 数据源
@property (nonatomic, strong) NSMutableArray *sectionArr;   // 分区数组

@end

@implementation MobilePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"手机号归属地";
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - BottomHeight) style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 15);
    _tableView.rowHeight = 50;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    [self getOpertionCountry];
}

- (void)getOpertionCountry {
    WeakObject;
    [[NetworkManager sharedManager] getRequest:OperationCountry parameters:nil success:^(NSDictionary * _Nonnull data) {
        NSArray *array = data[@"data"];
        weakSelf.tableDict = [NSMutableDictionary dictionary];
        weakSelf.sectionArr = [NSMutableArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"W",@"X",@"Y",@"Z", nil];
        for (NSDictionary *dictArr in array) {
            // 获取第一个首拼字母
            NSString *lowercaseStr = [[NSString transform:dictArr[@"name"]] substringToIndex:1];

            // 取出每个字母key对应的数组
            NSMutableArray *tableDictArr = weakSelf.tableDict[lowercaseStr];
            if (!tableDictArr) {
                // 没有就创建
                tableDictArr = [NSMutableArray array];
            }
            // 把国家放进相对应数组
            CountryCodeModel *model = [CountryCodeModel modelWithDictionary:dictArr];
            [tableDictArr addObject:model];
            // 把字母key对应数组放回字典
            [weakSelf.tableDict setObject:tableDictArr forKey:lowercaseStr];
        }
        [weakSelf.tableView reloadData];
    } failure:^(NSError * _Nonnull error) {
        [self showErrow:error];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sectionArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *key = _sectionArr[section];
    NSArray *keyArr = _tableDict[key];
    return keyArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 35;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 35)];
    headerView.backgroundColor = ThemeColorBackground;
    UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 35)];
    titleLB.text = _sectionArr[section];
    titleLB.textColor = ThemeColorTextGray;
    titleLB.font = ThemeFontText;
    [headerView addSubview:titleLB];
    return headerView;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [_sectionArr copy];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MobilePhoneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MobilePhoneTableViewCell"];
    if (cell == nil) {
        cell = [[[UINib nibWithNibName:@"MobilePhoneTableViewCell" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    NSString *key = _sectionArr[indexPath.section];
    NSArray *keyArr = _tableDict[key];
    CountryCodeModel *model = keyArr[indexPath.row];
    cell.nameLB.text = model.name;
    cell.codeLB.text = [NSString stringWithFormat:@"+%@",model.areaCode];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *key = _sectionArr[indexPath.section];
    NSArray *keyArr = _tableDict[key];
    CountryCodeModel *model = keyArr[indexPath.row];
    self.countryCodeBlock(model.areaCode,model.name);
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
