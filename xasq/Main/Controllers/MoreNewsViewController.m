//
//  MoreNewsViewController.m
//  xasq
//
//  Created by dssj on 2019/8/1.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "MoreNewsViewController.h"
#import "HomeNewsViewCell.h"

static NSString *NewsCellIdentifier = @"NewsCellIdentifier";

@interface MoreNewsViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
//@property (nonatomic, strong) NSArray *newsArray;

@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSMutableDictionary *newsDictionary;

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
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    self.titles = [NSMutableArray array];
    self.newsDictionary = [NSMutableDictionary dictionary];
    
    [self getUserNews];
}

- (void)getUserNews {
    [[NetworkManager sharedManager] getRequest:CommunityStealFlow parameters:@{@"outUserId":@"100"} success:^(NSDictionary * _Nonnull data) {
        
        NSArray *dateList = data[@"data"];
        if (!dateList || ![dateList isKindOfClass:[NSArray class]] || dateList.count == 0) {
            return;
        }
        
        [self handleData:dateList];
        [self.tableView reloadData];
        
    } failure:^(NSError * _Nonnull error) {
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
        
        NSMutableArray *temp = self.newsDictionary[key];
        if (!temp) {
            temp = [NSMutableArray array];
            [self.newsDictionary setObject:temp forKey:key];
        }
        
        [temp addObject:model];
    }
}

#pragma mark-
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.titles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.newsDictionary[self.titles[section]];
    return array.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, ScreenWidth, 30)];
    titleLabel.text = self.titles[section];;
    [headerView addSubview:titleLabel];
    
    return headerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeNewsViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NewsCellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSString *key = self.titles[indexPath.section];
    NSArray *array = self.newsDictionary[key];
    
    UserNewsModel *model = array[indexPath.row];
    
    cell.newsModel = model;
    
    return cell;
}


@end
