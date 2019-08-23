//
//  LanguageSetViewController.m
//  xasq
//
//  Created by dssj888@163.com on 2019/7/30.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "LanguageSetViewController.h"

@interface LanguageSetViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *languages;
@property (nonatomic, strong) NSArray *images;

@property (nonatomic, assign) NSInteger selectIndex;

@end

@implementation LanguageSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"语言设置";
    self.view.backgroundColor = ThemeColorBackground;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGRect rect = CGRectMake(0, NavHeight, ScreenWidth, ScreenHeight - NavHeight - BottomHeight);
    self.tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableView.tableFooterView = [[UIView alloc] init];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0.1)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
    
    self.languages = @[Language(@"Language_ZH"),Language(@"Language_EN")];
    self.images = @[@"user_ chinese",@"user_ english"];
    
    self.selectIndex = [LanguageTool currentLanguageType];
    
    [self initRightBtnWithTitle:@"保存" color:ThemeColorBlue];
}

#pragma mark -

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 20;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.languages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.textLabel.text = self.languages[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:self.images[indexPath.row]];
    if (self.selectIndex != indexPath.row) {
        cell.accessoryView = nil;
    } else {
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_choose"]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectIndex = indexPath.row;
    [tableView reloadData];
}

- (void)rightBtnAction {
    [LanguageTool setLanguageType:self.selectIndex];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
