//
//  HomeRankView.m
//  xasq
//
//  Created by dssj on 2019/7/31.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "HomeRankView.h"
#import "SegmentedControl.h"
#import "UserRankModel.h"
#import "HomeRankViewCell.h"

@interface HomeRankView ()<SegmentedControlDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) SegmentedControl *segmentedControl;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UITableView *powerRankView;//算力排行
@property (nonatomic, strong) UITableView *levelRankView;//等级排行
@property (nonatomic, strong) UITableView *inviteRankView;//邀请排行

///算力排行数据、等级排行数据(是同一个数据)
@property (nonatomic, strong) NSArray *powerRankDatas;//算力排行数据
@property (nonatomic, strong) NSArray *levelRankDatas;//等级排行数据

@property (nonatomic, strong) NSArray *inviteRankDatas;//邀请排行数据

@end

static NSString *HomeRankCellIdentifier = @"HomeRankCell";
const CGFloat RowHeight = 55.0;

@implementation HomeRankView

- (UITableView *)powerRankView {
    if (!_powerRankView) {
        _powerRankView = [self customerTableView];
        [_scrollView addSubview:_powerRankView];
    }
    return _powerRankView;
}

- (UITableView *)levelRankView {
    if (!_levelRankView) {
        _levelRankView = [self customerTableView];
        [_scrollView addSubview:_levelRankView];
    }
    return _levelRankView;
}

- (UITableView *)inviteRankView {
    if (!_inviteRankView) {
        _inviteRankView = [self customerTableView];
        [_scrollView addSubview:_inviteRankView];
    }
    return _inviteRankView;
}

- (UITableView *)customerTableView {
    UITableView *tableView = [[UITableView alloc] init];
    tableView.scrollEnabled = NO;
    [tableView registerNib:[UINib nibWithNibName:@"HomeRankViewCell" bundle:nil]
         forCellReuseIdentifier:HomeRankCellIdentifier];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.tableFooterView = [[UIView alloc] init];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.rowHeight = RowHeight;
    return tableView;
}

#pragma mark -
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        NSArray *items = @[@"算力排行",@"等级排行",@"邀请排行"];
        _segmentedControl = [[SegmentedControl alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)
                                                              items:items];
        _segmentedControl.delegate = self;
        [self addSubview:_segmentedControl];
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(_segmentedControl.frame), ScreenWidth, 0)];
        _scrollView.contentSize = CGSizeMake(ScreenWidth * items.count, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
        [self addSubview:_scrollView];
        
        [self getRankData];
    }
    return self;
}

#pragma mark-
- (UIView *)footerView {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, RowHeight * 1.5)];
    footerView.backgroundColor = [UIColor whiteColor];
    
    UILabel *dotLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, RowHeight * 0.5)];
    dotLabel.textAlignment = NSTextAlignmentCenter;
    dotLabel.text = @"......";
    [footerView addSubview:dotLabel];
    
    HomeRankViewCell *cell = [[NSBundle mainBundle] loadNibNamed:@"HomeRankViewCell" owner:self options:nil].firstObject;
    cell.frame = CGRectMake(0, RowHeight * 0.5, ScreenWidth, RowHeight);
    [footerView addSubview:cell];
    
    NSInteger currentIndex = self.segmentedControl.selectIndex;
    if (currentIndex == 0) {
        cell.cellStyle = HomeRankCellStylePower;
        cell.rankInfo = self.powerRankDatas.lastObject;
        
    } else if (currentIndex == 1) {
        cell.cellStyle = HomeRankCellStyleLevel;
        cell.rankInfo = self.levelRankDatas.lastObject;
        
    } else if (currentIndex == 2) {
        cell.cellStyle = HomeRankCellStyleInvite;
        cell.rankInfo = self.inviteRankDatas.lastObject;
    }
    
    return footerView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return MIN(10, self.powerRankDatas.count);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HomeRankViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HomeRankCellIdentifier];
    
    NSInteger currentIndex = self.segmentedControl.selectIndex;
    if (currentIndex == 0) {
        cell.cellStyle = HomeRankCellStylePower;
        cell.rankInfo = self.powerRankDatas[indexPath.row];
        
    } else if (currentIndex == 1) {
        cell.cellStyle = HomeRankCellStyleLevel;
        cell.rankInfo = self.levelRankDatas[indexPath.row];
        
    } else if (currentIndex == 2) {
        cell.cellStyle = HomeRankCellStyleInvite;
        cell.rankInfo = self.inviteRankDatas[indexPath.row];
    }
    
    return cell;
}

#pragma mark - 代理方法
- (void)segmentedControlItemSelect:(NSInteger)index {
    [_scrollView setContentOffset:CGPointMake(ScreenWidth * index, 0) animated:YES];
    
    [self resizeFrame];
}

#pragma mark - 算力等级排行
- (void)getRankData {
    NSDictionary *parameters = @{@"pageNo":@(1),@"pageSize":@(10),@"order":@"asc"};
    
    [[NetworkManager sharedManager] postRequest:CommunityPowerRank parameters:parameters success:^(NSDictionary * _Nonnull data) {
        
        NSArray *dateList = data[@"data"][@"rows"];
        if (!dateList || ![dateList isKindOfClass:[NSArray class]] || dateList.count == 0) {
            return;
        }
        
        self.powerRankDatas = [UserRankModel modelWithArray:dateList];
        self.levelRankDatas = self.powerRankDatas;
        
        [self resizeFrame];
        
    } failure:^(NSError * _Nonnull error){
        
    }];
    
    [[NetworkManager sharedManager] getRequest:UserInviteRankCount parameters:parameters success:^(NSDictionary * _Nonnull data) {
        NSArray *dateList = data[@"data"][@"rows"];
        if (!dateList || ![dateList isKindOfClass:[NSArray class]] || dateList.count == 0) {
            return;
        }
        
        self.inviteRankDatas = [UserRankModel modelWithArray:dateList];

    } failure:^(NSError * _Nonnull error){

    }];
    
}

- (void)resizeFrame {
    UserRankModel *lastModel;
    NSInteger currentIndex = self.segmentedControl.selectIndex;
    
    if (currentIndex == 0) {
        lastModel = self.powerRankDatas.lastObject;
        
    } else if (currentIndex == 1) {
        lastModel = self.levelRankDatas.lastObject;
        
    } else if (currentIndex == 2) {
        lastModel = self.inviteRankDatas.lastObject;
        
    }
    if (!lastModel) {
        return;
    }
    
    CGFloat viewHeight = 0.0;
    BOOL flag = NO;//是否需要footerView
    if ([UserDataManager shareManager].userId) {
        //已经登录
        if (lastModel.ranking > 10) {
            //自己不在前10名，需要在底部显示(不登录时，只有10条数据)
            viewHeight = (self.powerRankDatas.count - 1) * RowHeight + RowHeight * 1.5;
            flag = YES;
        } else {
            //自己在前10名，不需要额外显示(不登录时，只有10条数据，也只显示10条数据)
            viewHeight = MIN(10, self.powerRankDatas.count - 1) * RowHeight;
        }
        
    } else {
        //没登录只显示10条
        viewHeight = MIN(10, self.powerRankDatas.count) * RowHeight;
    }
    
    if (currentIndex == 0) {
        self.powerRankView.frame = CGRectMake(0, 0, ScreenWidth, viewHeight);
        if (flag) {
            self.powerRankView.tableFooterView = [self footerView];
        }
        
        [self.powerRankView reloadData];
        
    } else if (currentIndex == 1) {
        self.levelRankView.frame = CGRectMake(ScreenWidth, 0, ScreenWidth, viewHeight);
        if (flag) {
            self.levelRankView.tableFooterView = [self footerView];
        }
        
        [self.levelRankView reloadData];
        
    } else if (currentIndex == 2) {
        self.inviteRankView.frame = CGRectMake(ScreenWidth * 2, 0, ScreenWidth, viewHeight);
        if (flag) {
            self.inviteRankView.tableFooterView = [self footerView];
        }
        
        [self.inviteRankView reloadData];
    }
    
    CGRect rect = self.frame;
    rect.size.height = viewHeight + CGRectGetHeight(self.segmentedControl.frame);
    self.frame = rect;
    
    self.scrollView.frame = CGRectMake(0, CGRectGetHeight(self.segmentedControl.frame), ScreenWidth, viewHeight);
    
    if (self.HomeRankDataComplete) {
        self.HomeRankDataComplete(CGRectGetHeight(self.frame));
    }
}

#pragma mark-
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.segmentedControl.selectIndex = page;
    [self.segmentedControl.delegate segmentedControlItemSelect:page];
}

#pragma mark -
- (void)reloadViewData {
    
    self.powerRankDatas = nil;
    self.powerRankDatas = nil;
    self.powerRankDatas = nil;
    
    [self.powerRankView reloadData];
    [self.levelRankView reloadData];
    [self.inviteRankView reloadData];
    
    [self getRankData];
}

@end
