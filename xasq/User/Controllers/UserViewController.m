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

@interface UserViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray;
@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _titleArray = @[@"认证信息", @"账户设置", @"语言设置", @"邀请好友", @"建议与反馈", @"版本升级", @"关于我们", @"联系我们"];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavHeight, ScreenWidth, ScreenHeight - NavHeight - BarHeight) style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    _tableView.rowHeight = 45;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
}
    
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserTableViewCell"];
    if (cell == nil) {
        cell = [[[UINib nibWithNibName:@"UserTableViewCell" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.titleLB.text = _titleArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *title = _titleArray[indexPath.row];
    if ([title isEqualToString:@"认证信息"]) {
        CredentialsViewController *VC = [[CredentialsViewController alloc] init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    } else if ([title isEqualToString:@"账户设置"]) {
        AccountSetViewController *VC = [[AccountSetViewController alloc] init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    } else if ([title isEqualToString:@"语言设置"]) {
        LanguageSetViewController *VC = [[LanguageSetViewController alloc] init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    } else if ([title isEqualToString:@"版本升级"]) {
        OurVersionViewController *VC = [[OurVersionViewController alloc] init];
        VC.type = 0;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    } else if ([title isEqualToString:@"关于我们"]) {
        OurVersionViewController *VC = [[OurVersionViewController alloc] init];
        VC.type = 1;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    } else if ([title isEqualToString:@"联系我们"]) {
        OurVersionViewController *VC = [[OurVersionViewController alloc] init];
        VC.type = 2;
        self.hidesBottomBarWhenPushed = YES;
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
