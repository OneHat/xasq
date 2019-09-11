//
//  CalendarViewController.m
//  xasq
//
//  Created by dssj888@163.com on 2019/9/9.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "CalendarViewController.h"
#import "CalendarDataTableViewCell.h"
#import "CalendareventTableViewCell.h"
#import "CalendarholidayTableViewCell.h"
#import "CalendarHeaderView.h"
#import "CalendarModel.h"

@interface CalendarViewController () <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) CalendarHeaderView *headerView;
@property (nonatomic, assign) NSInteger type; // 0 数据,1 事件,2 假期
@property (nonatomic, strong) NSString *dateStr; // 选择日期
@property (nonatomic, strong) NSArray *topArray; // 日期数据
@property (nonatomic, strong) NSMutableArray *dateArray; // 数据
@property (nonatomic, strong) NSMutableArray *eventArray; // 事件
@property (nonatomic, strong) NSMutableArray *holidayArray; // 假日

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _type = 0;
    _dateArray = [NSMutableArray arrayWithCapacity:15];
    _eventArray = [NSMutableArray arrayWithCapacity:15];
    _holidayArray = [NSMutableArray arrayWithCapacity:15];

    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 105)];
    _headerView = [[[UINib nibWithNibName:@"CalendarHeaderView" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
    _headerView.frame = CGRectMake(0, 0, ScreenWidth, 105);
    WeakObject;
    _headerView.eventBtnChangeBlock = ^(NSInteger type) {
        weakSelf.type = type;
        [weakSelf.tableView reloadData];
    };
    _headerView.dateBtnChangeBlock = ^(NSInteger type) {
        [weakSelf.dateArray removeAllObjects];
        [weakSelf.eventArray removeAllObjects];
        [weakSelf.holidayArray removeAllObjects];
        NSDictionary *dict = weakSelf.topArray[type];
        weakSelf.dateStr = dict[@"date"];
        [weakSelf sendDataArray];
    };
    [backView addSubview:_headerView];
    [self.view addSubview:backView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 105, ScreenWidth, ScreenHeight - 105 - BarHeight - NavHeight) style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _tableView.separatorColor = ThemeColorLine;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    
    [self getOperEconomicCalendarList];

}

- (void)getOperEconomicCalendarList {
    [[NetworkManager sharedManager] getRequest:OperEconomicCalendarList parameters:nil success:^(NSDictionary * _Nonnull data) {
        if ([data[@"data"] isKindOfClass:[NSArray class]]) {
            self.topArray = [NSArray arrayWithArray:data[@"data"]];
            [self.headerView setDateSubViews:data[@"data"]];
            NSDictionary *dict = data[@"data"][3];
            self.dateStr = dict[@"date"];
            [self sendDataArray];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void)sendDataArray {
    NSDictionary *dict = @{@"date" : _dateStr,};
    [[NetworkManager sharedManager] getRequest:OperEconomicDataList parameters:dict success:^(NSDictionary * _Nonnull data) {
        if ([data[@"data"] isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dict in data[@"data"]) {
                CalendarModel *model = [CalendarModel modelWithDictionary:dict];
                [self.dateArray addObject:model];
            }
            if (self.type == 0) {
                if (self.dateArray.count > 0) {
                    [self.tableView hideEmptyView];
                } else {
                    [self.tableView showEmptyView:EmptyViewReasonNoData msg:@"当天无数据" refreshBlock:nil];
                }
                [self.tableView reloadData];
            }
        } else {
            [self.tableView showEmptyView:EmptyViewReasonNoData msg:@"当天无数据" refreshBlock:nil];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
    [[NetworkManager sharedManager] getRequest:OperEconomicEventList parameters:dict success:^(NSDictionary * _Nonnull data) {
        if ([data[@"data"] isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dict in data[@"data"]) {
                CalendarModel *model = [CalendarModel modelWithDictionary:dict];
                [self.eventArray addObject:model];
            }
            if (self.type == 1) {
                if (self.eventArray.count > 0) {
                    [self.tableView hideEmptyView];
                } else {
                    [self.tableView showEmptyView:EmptyViewReasonNoData msg:@"当天无事件" refreshBlock:nil];
                }
                [self.tableView reloadData];
            }
        } else {
            [self.tableView showEmptyView:EmptyViewReasonNoData msg:@"当天无事件" refreshBlock:nil];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
    [[NetworkManager sharedManager] getRequest:OperEconomicHolidayList parameters:dict success:^(NSDictionary * _Nonnull data) {
        if ([data[@"data"] isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dict in data[@"data"]) {
                CalendarModel *model = [CalendarModel modelWithDictionary:dict];
                [self.holidayArray addObject:model];
            }
            if (self.type == 2) {
                if (self.holidayArray.count > 0) {
                    [self.tableView hideEmptyView];
                } else {
                    [self.tableView showEmptyView:EmptyViewReasonNoData msg:@"当天无假期" refreshBlock:nil];
                }
                [self.tableView reloadData];
            }
        } else {
            [self.tableView showEmptyView:EmptyViewReasonNoData msg:@"当天无假期" refreshBlock:nil];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_type == 0) {
        return _dateArray.count;
    } else if (_type == 1) {
        return _eventArray.count;
    } else {
        return _holidayArray.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_type == 0) {
        return 110;
    } else if (_type == 1) {
        return 100;
    } else {
        return 80;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_type == 0) {
        CalendarDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CalendarDataTableViewCell"];
        if (cell == nil) {
            cell = [[[UINib nibWithNibName:@"CalendarDataTableViewCell" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        CalendarModel *model = _dateArray[indexPath.row];
        [cell setDataModel:model];
        return cell;
    } else if (_type == 1) {
        CalendareventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CalendareventTableViewCell"];
        if (cell == nil) {
            cell = [[[UINib nibWithNibName:@"CalendareventTableViewCell" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        CalendarModel *model = _eventArray[indexPath.row];
        [cell setDataModel:model];
        return cell;
    } else {
        CalendarholidayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CalendarholidayTableViewCell"];
        if (cell == nil) {
            cell = [[[UINib nibWithNibName:@"CalendarholidayTableViewCell" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        CalendarModel *model = _holidayArray[indexPath.row];
        [cell setDataModel:model];
        return cell;
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
