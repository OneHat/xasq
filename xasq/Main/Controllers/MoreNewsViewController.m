//
//  MoreNewsViewController.m
//  xasq
//
//  Created by dssj on 2019/8/1.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "MoreNewsViewController.h"
#import "HomeNewsViewCell.h"
#import "UITableView+Refresh.h"

static NSString *NewsCellIdentifier = @"NewsCellIdentifier";

@interface MoreNewsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableDictionary *newsInfo;

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger totalPage;

@end

@implementation MoreNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"最新动态";
    self.view.backgroundColor = ThemeColorBackground;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGRect rect = CGRectMake(0, NavHeight + 10, ScreenWidth, ScreenHeight - NavHeight - BottomHeight);
    self.tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStyleGrouped];
    self.tableView.backgroundColor = ThemeColorBackground;
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeNewsViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:NewsCellIdentifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 46;
    self.tableView.sectionFooterHeight = 0.01;
    [self.view addSubview:self.tableView];
    
    self.titles = [NSMutableArray array];
    self.newsInfo = [NSMutableDictionary dictionary];
    
    [self.tableView pullHeaderRefresh:^{
        self.page = 1;
        [self getUserNews];
    }];
    
    [self.tableView pullFooterRefresh:^{
        
        if (self.page < self.totalPage) {
            self.page++;
            [self getUserNews];
            return;
        }
        [self.tableView endRefresh];
    }];
    
    self.page = 1;
    [self getUserNews];
}

- (void)getUserNews {
    
    [[NetworkManager sharedManager] postRequest:CommunityStealFlow parameters:@{@"pageNo":@(self.page)} success:^(NSDictionary * _Nonnull data) {
        [self.tableView endRefresh];
        
        self.totalPage = [data[@"data"][@"totalPage"] integerValue];
        
        NSArray *dateList = data[@"data"][@"rows"];
        if (!dateList || ![dateList isKindOfClass:[NSArray class]] || dateList.count == 0) {
            return;
        }
        
        if (self.page == 1) {
            [self.titles removeAllObjects];
            [self.newsInfo removeAllObjects];
        }
        
        [self handleData:dateList];
        [self.tableView reloadData];
        
    } failure:^(NSError * _Nonnull error) {
        [self.tableView endRefresh];
    }];
}

//处理数据，分组
- (void)handleData:(NSArray *)array {
    NSArray *originalArray = [UserNewsModel modelWithArray:array];
    
    for (UserNewsModel *model in originalArray) {
        NSString *key = self.titles.lastObject;
        if (![key isEqualToString:model.showDate]) {
            key = model.showDate;
            [self.titles addObject:key];
        }
        
        NSMutableArray *temp = self.newsInfo[key];
        if (!temp) {
            temp = [NSMutableArray array];
            [self.newsInfo setObject:temp forKey:key];
        }
        
        [temp addObject:model];
    }
}

#pragma mark-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.newsInfo[self.titles[section]];
    return array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth, 30)];
    titleLabel.text = self.titles[section];
    [headerView addSubview:titleLabel];
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeNewsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NewsCellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *key = self.titles[indexPath.section];
    NSArray *array = self.newsInfo[key];
    
    UserNewsModel *model = array[indexPath.row];
    
    cell.newsModel = model;
    
    return cell;
}


@end
