//
//  TaskViewController.m
//  xasq
//
//  Created by dssj on 2019/8/8.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "TaskViewController.h"
#import "SegmentedControl.h"
#import "TaskViewCell.h"
#import "TaskModel.h"
#import "MyTaskModel.h"

@interface TaskViewController ()<SegmentedControlDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) SegmentedControl *segmentedControl;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UITableView *dayTableView;//每日任务
@property (nonatomic, strong) UITableView *weekTableView;//每周任务

@property (nonatomic, strong) NSArray *dayArray;
@property (nonatomic, strong) NSArray *weekArray;

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerImageViewTop;

@end

@implementation TaskViewController

- (UITableView *)dayTableView {
    if (!_dayTableView) {
        _dayTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame)) style:UITableViewStylePlain];
        [_dayTableView registerNib:[UINib nibWithNibName:@"TaskViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        _dayTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _dayTableView.tableFooterView = [[UIView alloc] init];
        _dayTableView.dataSource = self;
        _dayTableView.delegate = self;
        _dayTableView.rowHeight = 70;
        [self.scrollView addSubview:_dayTableView];
    }
    return _dayTableView;
}

- (UITableView *)weekTableView {
    if (!_weekTableView) {
        _weekTableView = [[UITableView alloc] initWithFrame:CGRectMake(CGRectGetWidth(_scrollView.frame), 0, CGRectGetWidth(_scrollView.frame), CGRectGetHeight(_scrollView.frame)) style:UITableViewStylePlain];
        [_weekTableView registerNib:[UINib nibWithNibName:@"TaskViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        _weekTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _weekTableView.tableFooterView = [[UIView alloc] init];
        _weekTableView.dataSource = self;
        _weekTableView.delegate = self;
        _weekTableView.rowHeight = 70;
    }
    return _dayTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = ThemeColorBackground;
    
    //title
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, StatusBarHeight, ScreenWidth, 44)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"任务";
    titleLabel.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:titleLabel];
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(0, StatusBarHeight, 44, 44)];
    [backButton setImage:[UIImage imageNamed:@"leftBar_back_white"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    _headerImageViewTop.constant = NavHeight;
    
    ///
    CGFloat viewWidth = ScreenWidth - 20;
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_headerImageView.frame), viewWidth, ScreenHeight - 20 - CGRectGetMaxY(_headerImageView.frame) - BottomHeight)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    backgroundView.layer.cornerRadius = 5;
    [self.view addSubview:backgroundView];
    
    
    NSArray *items = @[@"每日任务",@"每周任务"];
    _segmentedControl = [[SegmentedControl alloc] initWithFrame:CGRectMake(0, 0, viewWidth, 40)
                                                          items:items];
    _segmentedControl.delegate = self;
    [backgroundView addSubview:_segmentedControl];
    
    CGRect rect = CGRectMake(0, 50, viewWidth, CGRectGetHeight(backgroundView.frame) - 60);
    _scrollView = [[UIScrollView alloc] initWithFrame:rect];
    _scrollView.contentSize = CGSizeMake(viewWidth * items.count, 0);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    [backgroundView addSubview:_scrollView];
    
    [_scrollView addSubview:self.dayTableView];
    
//    [[NetworkManager sharedManager] getRequest:UserSignInfo parameters:@{@"userId":[UserDataManager shareManager].userId} success:^(NSDictionary * _Nonnull data) {
//        NSLog(@"%@",data);
//    } failure:^(NSError * _Nonnull error) {
//
//    }];
    
    
//    [[NetworkManager sharedManager] getRequest:CommunityTask parameters:@{@"userId":[UserDataManager shareManager].userId} success:^(NSDictionary * _Nonnull data) {
//        NSLog(@"%@",data);
//    } failure:^(NSError * _Nonnull error) {
//        
//    }];
    
//    [[NetworkManager sharedManager] getRequest:CommunityTaskRecommend parameters:@{@"userId":[UserDataManager shareManager].userId} success:^(NSDictionary * _Nonnull data) {
//        NSArray *dataArray = data[@"data"];
//        if (dataArray && [dataArray isKindOfClass:[NSArray class]] && dataArray.count > 0) {
//            self.dayArray = [TaskModel modelWithArray:dataArray];
//            [self.dayTableView reloadData];
//
//        } else {
//            [self.dayTableView showEmptyView:EmptyViewReasonNoData refreshBlock:nil];
//        }
//
//    } failure:^(NSError * _Nonnull error) {
//        [self.dayTableView showEmptyView:EmptyViewReasonNoData refreshBlock:nil];
//    }];
    
//    [[NetworkManager sharedManager] getRequest:CommunityTaskPower parameters:nil success:^(NSDictionary * _Nonnull data) {
//        NSLog(@"%@",data);
//    } failure:^(NSError * _Nonnull error) {
//        
//    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
    if (tableView == self.dayTableView) {
        return self.dayArray.count;
        
    } else if (tableView == self.weekTableView) {
        return self.weekArray.count;
        
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TaskViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (tableView == self.dayTableView) {
        TaskModel *model = self.dayArray[indexPath.row];
        cell.task = model;
        
    } else if (tableView == self.weekTableView) {
//        TaskModel *model = self.highArray[indexPath.row];
        
    }
    
    return cell;
}

#pragma mark -
- (void)segmentedControlItemSelect:(NSInteger)index {
    self.scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.scrollView.frame) * index, 0);
    
    if (index) {
        
    } else {
        
    }
}

#pragma mark - 网络请求
- (void)getSignInfo {
    [[NetworkManager sharedManager] getRequest:UserSignInfo parameters:nil success:^(NSDictionary * _Nonnull data) {
        //"signDate"："2019-01-01"，"keepSign":3
        NSDictionary *signInfo = data[@"data"];
        if (signInfo && [signInfo isKindOfClass:[NSDictionary class]]) {
//            NSString *signDate = signInfo[@"signDate"];
            
        }
        
    } failure:^(NSError * _Nonnull error) {
    }];
}

- (void)userSign {
    [[NetworkManager sharedManager] postRequest:UserSignIn parameters:nil success:^(NSDictionary * _Nonnull data) {
        
        [self showMessage:@"签到成功"];
        
    } failure:^(NSError * _Nonnull error) {
    }];
}

@end
