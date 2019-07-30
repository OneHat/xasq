//
//  AccountSetViewController.m
//  xasq
//
//  Created by dssj888@163.com on 2019/7/29.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "AccountSetViewController.h"
#import "AccountSetTableViewCell.h"

@interface AccountSetViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation AccountSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账户设置";
    
    _titleArray = @[@"修改登录密码", @"修改支付密码", @"绑定手机", @"绑定邮箱", @"Google认证"];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavHeight, ScreenWidth, ScreenHeight - NavHeight) style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    _tableView.rowHeight = 45;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
