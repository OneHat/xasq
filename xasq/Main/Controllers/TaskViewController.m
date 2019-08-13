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

@property (nonatomic, strong) UITableView *myTableView;//我的任务
@property (nonatomic, strong) UITableView *highTableView;//高分任务
@property (nonatomic, strong) UITableView *recommondTableView;//推荐任务

@property (nonatomic, strong) NSArray *recommondArray;
@property (nonatomic, strong) NSArray *myArray;
@property (nonatomic, strong) NSArray *highArray;

@end

@implementation TaskViewController

- (UITableView *)recommondTableView {
    if (!_recommondTableView) {
        _recommondTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, CGRectGetHeight(_scrollView.frame)) style:UITableViewStylePlain];
        [_recommondTableView registerNib:[UINib nibWithNibName:@"TaskViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        _recommondTableView.tableFooterView = [[UIView alloc] init];
        _recommondTableView.dataSource = self;
        _recommondTableView.delegate = self;
        _recommondTableView.rowHeight = 56;
        [self.scrollView addSubview:_recommondTableView];
    }
    return _recommondTableView;
}

- (UITableView *)highTableView {
    if (!_highTableView) {
        _highTableView = [[UITableView alloc] initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, CGRectGetHeight(_scrollView.frame)) style:UITableViewStylePlain];
        [_highTableView registerNib:[UINib nibWithNibName:@"TaskViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        _highTableView.tableFooterView = [[UIView alloc] init];
        _highTableView.dataSource = self;
        _highTableView.delegate = self;
    }
    return _recommondTableView;
}

- (UITableView *)myTableView {
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(ScreenWidth * 2, 0, ScreenWidth, CGRectGetHeight(_scrollView.frame)) style:UITableViewStylePlain];
        [_myTableView registerNib:[UINib nibWithNibName:@"TaskViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        _myTableView.tableFooterView = [[UIView alloc] init];
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
    }
    return _myTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    if (![UserDataManager shareManager].userId) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    //背景
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 160)];
    imageView.image = [UIImage imageNamed:@"capital_topBackground"];
    imageView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:imageView];
    
    
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
    
    
    NSArray *items = @[@"推荐任务",@"高分任务",@"我的任务"];
    _segmentedControl = [[SegmentedControl alloc] initWithFrame:CGRectMake(0, 200, ScreenWidth, 40)
                                                          items:items];
    _segmentedControl.delegate = self;
    [self.view addSubview:_segmentedControl];
    
    CGRect rect = CGRectMake(0, CGRectGetMaxY(_segmentedControl.frame), ScreenWidth, ScreenHeight - CGRectGetMaxY(_segmentedControl.frame));
    _scrollView = [[UIScrollView alloc] initWithFrame:rect];
    _scrollView.contentSize = CGSizeMake(ScreenWidth * items.count, 0);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    
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
    
    [[NetworkManager sharedManager] getRequest:CommunityTaskRecommend parameters:@{@"userId":[UserDataManager shareManager].userId} success:^(NSDictionary * _Nonnull data) {
        NSArray *dataArray = data[@"data"];
        if (dataArray && [dataArray isKindOfClass:[NSArray class]] && dataArray.count > 0) {
            self.recommondArray = [TaskModel modelWithArray:dataArray];
            [self.recommondTableView reloadData];
            
        } else {
            [self.recommondTableView showEmptyView:EmptyViewReasonNoData refreshBlock:nil];
        }
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
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
    if (tableView == self.recommondTableView) {
        return self.recommondArray.count;
        
    } else if (tableView == self.highTableView) {
        return self.highArray.count;
        
    } else if (tableView == self.myTableView) {
        return self.myArray.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TaskViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (tableView == self.recommondTableView) {
        TaskModel *model = self.recommondArray[indexPath.row];
        cell.task = model;
        
    } else if (tableView == self.highTableView) {
        TaskModel *model = self.highArray[indexPath.row];
        
    } else if (tableView == self.myTableView) {
        MyTaskModel *model = self.myArray[indexPath.row];
    }
    
    return cell;
}

#pragma mark -
- (void)segmentedControlItemSelect:(NSInteger)index {
    
}

@end
