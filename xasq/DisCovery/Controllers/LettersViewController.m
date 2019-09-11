//
//  LettersViewController.m
//  xasq
//
//  Created by dssj888@163.com on 2019/9/6.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "LettersViewController.h"
#import "LettersMarketTableViewCell.h"
#import "InformationTableViewCell.h"
#import "ReleaseTableViewCell.h"
#import "AdvertisTableViewCell.h"
#import "DiscoveryModel.h"

@interface LettersViewController () <UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (strong, nonatomic) UIView *dayView;
@property (strong, nonatomic) UILabel *dayLB;
@property (strong, nonatomic) UILabel *monthLB;
@property (nonatomic, assign) NSInteger pageNo;  // 分页
@property (nonatomic, assign) NSInteger totalPage; // 最大页数
@end

@implementation LettersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _pageNo = 1;
    _totalPage = 1;
    _dataArray = [NSMutableArray arrayWithCapacity:15];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - NavHeight - BarHeight) style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.tableFooterView = [[UIView alloc] init];
    [self.view addSubview:_tableView];
    
    _dayView = [[UIView alloc] initWithFrame:CGRectMake(15, 15, 30, 35)];
    _dayView.backgroundColor = [UIColor whiteColor];
    _dayView.layer.borderWidth = 1;
    _dayView.layer.borderColor = HexColor(@"#637283").CGColor;
    _dayLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 3, 30, 20)];
    _dayLB.font = ThemeFontMiddleText;
    _dayLB.textAlignment = NSTextAlignmentCenter;
    _dayLB.textColor = HexColor(@"#637283");
    _monthLB = [[UILabel alloc] initWithFrame:CGRectMake(0, 18, 30, 15)];
    _monthLB.font = [UIFont systemFontOfSize:10];
    _monthLB.textAlignment = NSTextAlignmentCenter;
    _monthLB.textColor = HexColor(@"#637283");
    [_dayView addSubview:_dayLB];
    [_dayView addSubview:_monthLB];
    [self.view addSubview:_dayView];
    WeakObject;
    [_tableView pullHeaderRefresh:^{
        weakSelf.pageNo = 1;
        [weakSelf.dataArray removeAllObjects];
        [weakSelf sendDataArray];
    }];
    [_tableView pullFooterRefresh:^{
        weakSelf.pageNo++;
        if (weakSelf.pageNo <= weakSelf.totalPage) {
            [weakSelf sendDataArray];
        } else {
            [weakSelf.tableView endRefresh];
        }
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _pageNo = 1;
    [_dataArray removeAllObjects];
    [self sendDataArray];
}

- (void)sendDataArray {
    NSDictionary *dict = @{@"categoryId" : @"1001",
                           @"pageNo"     : [NSString stringWithFormat:@"%ld",_pageNo],
                           };
    [[NetworkManager sharedManager] getRequest:OperInformationList parameters:dict success:^(NSDictionary * _Nonnull data) {
        NSArray *array = data[@"data"][@"rows"];
        if ([array isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dic in array) {
                DiscoveryModel *model = [DiscoveryModel modelWithDictionary:dic];
                [self.dataArray addObject:model];
            }
            [self setDaySubViewValueWith:0];
            [self.tableView hideEmptyView];
            [self.tableView reloadData];
        } else {
            [self.tableView showEmptyView:EmptyViewReasonNoData msg:@"暂无数据" refreshBlock:nil];
        }
        [self.tableView endRefresh];
    } failure:^(NSError * _Nonnull error) {
        [self.tableView endRefresh];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    DiscoveryModel *model = _dataArray[indexPath.row];
    return model.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DiscoveryModel *model = _dataArray[indexPath.row];
    if (model.type == 1) {
        
        LettersMarketTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LettersMarketTableViewCell"];
        if (cell == nil) {
            cell = [[[UINib nibWithNibName:@"LettersMarketTableViewCell" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        model.cellHeight = 120;
        [cell setDataModel:model];
        return cell;
    } else if (model.type == 2) {
        
        InformationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InformationTableViewCell"];
        if (cell == nil) {
            cell = [[[UINib nibWithNibName:@"InformationTableViewCell" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (model.cellHeight <= 0) {
            // 计算高度
            if (model.digest.length > 60) {
                // 简介最多显示60个
                model.digest = [model.digest substringToIndex:60];
                model.digest = [model.digest stringByAppendingString:@"..."];
            }
            NSInteger height = 125;
            NSInteger titleHeight = [NSString stringHeightCalculateWithTitle:model.title width:ScreenWidth - 73 font:[UIFont systemFontOfSize:15 weight:(UIFontWeightBold)] defaultHeight:20];
            NSInteger digestHeight = [NSString stringHeightCalculateWithTitle:model.digest width:ScreenWidth - 73 font:[UIFont systemFontOfSize:14 weight:(UIFontWeightRegular)] defaultHeight:20];
            NSInteger cellHeight = height + titleHeight + digestHeight;
            model.cellHeight = cellHeight;
        }
        [cell setDataModel:model];
        return cell;
    } else if (model.type == 3) {
        
        AdvertisTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AdvertisTableViewCell"];
        if (cell == nil) {
            cell = [[[UINib nibWithNibName:@"AdvertisTableViewCell" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        if (model.cellHeight <= 0) {
            // 计算高度
            NSInteger advertisHeight = (140*(ScreenWidth-70))/305;
            NSInteger cellHeight = advertisHeight + 35;
            model.cellHeight = cellHeight;
        }
        [cell setDataModel:model];
        return cell;
    } else if (model.type == 4) {
        ReleaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReleaseTableViewCell"];
        if (cell == nil) {
            cell = [[[UINib nibWithNibName:@"ReleaseTableViewCell" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        model.cellHeight = 145;
        [cell setDataModel:model];
        return cell;
    }
    return nil;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    UITableViewCell *firstCell = _tableView.visibleCells.firstObject;
    NSIndexPath *index = [_tableView indexPathForCell:firstCell];
    [self setDaySubViewValueWith:index.row];
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
//    
//    UITableViewCell *firstCell = tableView.visibleCells.firstObject;
//    NSIndexPath *index = [tableView indexPathForCell:firstCell];
//    [self setDaySubViewValueWith:index.row];
//}

- (void)setDaySubViewValueWith:(NSInteger)index {
    DiscoveryModel *model = _dataArray[index];
    if (model.rank != 0) {
        _dayLB.text = [NSDate dayTransferWithString:model.releaseTime];
        NSString *month = [NSDate monthTransferWithString:model.releaseTime];
        _monthLB.text = [NSString stringWithFormat:@"%@月",month];
    } else {
        if ((index+1) < _dataArray.count){
            [self setDaySubViewValueWith:index+1];
        } else {
            NSString *date = [NSDate getStandardTime];
            _dayLB.text = [NSDate dayTransferWithString:date];
            NSString *month = [NSDate monthTransferWithString:date];
            _monthLB.text = [NSString stringWithFormat:@"%@月",month];
        }
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
