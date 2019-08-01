//
//  HomeChartsTableView.m
//  xasq
//
//  Created by dssj on 2019/8/1.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "HomeChartsTableView.h"
#import "HomeChartViewCell.h"

static NSString *homeChartCellIdentifier = @"homeChartCell";

@interface HomeChartsTableView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HomeChartsTableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _tableView.scrollEnabled = NO;
        [_tableView registerNib:[UINib nibWithNibName:@"HomeChartViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:homeChartCellIdentifier];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = 50;
        
        [self addSubview:_tableView];
        
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    
    self.frame = CGRectMake(0, 0, ScreenWidth, dataArray.count * 50);
    self.tableView.frame = CGRectMake(0, 0, ScreenWidth, dataArray.count * 50);
    
    [self.tableView reloadData];
}

#pragma mark-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeChartViewCell *cell = [tableView dequeueReusableCellWithIdentifier:homeChartCellIdentifier];
    return cell;
}

@end
