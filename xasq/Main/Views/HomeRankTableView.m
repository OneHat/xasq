//
//  HomeRankTableView.m
//  xasq
//
//  Created by dssj on 2019/8/1.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "HomeRankTableView.h"
#import "HomeRankViewCell.h"

static NSString *homeRankCellIdentifier = @"homeRankCell";

@interface HomeRankTableView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end


const CGFloat RowHeight = 55.0;

@implementation HomeRankTableView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _tableView.scrollEnabled = NO;
        [_tableView registerNib:[UINib nibWithNibName:@"HomeRankViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:homeRankCellIdentifier];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.rowHeight = RowHeight;
        
        [self addSubview:_tableView];
        
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    
    CGRect rect = self.frame;
    rect.size.height = dataArray.count * RowHeight;
    self.frame = rect;
    
    self.tableView.frame = CGRectMake(0, 0, ScreenWidth, dataArray.count * RowHeight);
    
    [self.tableView reloadData];
}

#pragma mark-
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeRankViewCell *cell = [tableView dequeueReusableCellWithIdentifier:homeRankCellIdentifier];
    return cell;
}

@end
