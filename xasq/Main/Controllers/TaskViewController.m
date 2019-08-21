//
//  TaskViewController.m
//  xasq
//
//  Created by dssj on 2019/8/8.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "TaskViewController.h"
#import "TaskRecordViewController.h"
#import "SegmentedControl.h"
#import "TaskViewCell.h"
#import "SignSuccessView.h"

@interface TaskViewController ()<SegmentedControlDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) SegmentedControl *segmentedControl;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UITableView *dayTableView;//每日任务
@property (nonatomic, strong) UITableView *weekTableView;//每周任务

@property (nonatomic, strong) NSArray *dayArray;
@property (nonatomic, strong) NSArray *weekArray;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerTopHeight;

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *powerLabel;

@property (weak, nonatomic) IBOutlet UIButton *signButton;
@property (weak, nonatomic) IBOutlet UILabel *signLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *signButtonWidth;

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
        [self.scrollView addSubview:_weekTableView];
    }
    return _weekTableView;
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
    
    UIButton *recordButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - 44, StatusBarHeight, 44, 44)];
    [recordButton setImage:[UIImage imageNamed:@"reward_record"] forState:UIControlStateNormal];
    [recordButton addTarget:self action:@selector(recordAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:recordButton];
    
    
    //////
    self.headerTopHeight.constant = NavHeight + 20;
    self.nameLabel.text = [UserDataManager shareManager].usermodel.nickName;
    
    self.signLabel.font = [UIFont boldSystemFontOfSize:13];
    
    UIImage *image = [UIImage imageNamed:@"task_daysign"];
    [self.signButton setBackgroundImage:[image resizeImageInCenter] forState:UIControlStateNormal];
    [self updateSignLabel:@"已签到" buttonSelect:YES];
    
    NSString *imageUrl = [UserDataManager shareManager].usermodel.headImg;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    
    ///
    CGFloat viewWidth = ScreenWidth - 30;
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(15, NavHeight + 80, viewWidth, ScreenHeight - NavHeight - 90 - BottomHeight)];
    backgroundView.backgroundColor = [UIColor whiteColor];
    backgroundView.layer.cornerRadius = 5;
    backgroundView.layer.masksToBounds = YES;
    [self.view addSubview:backgroundView];
    
    NSArray *items = @[@"每日任务",@"每周任务"];
    _segmentedControl = [[SegmentedControl alloc] initWithFrame:CGRectMake(0, 0, viewWidth, 40)
                                                          items:items];
    _segmentedControl.delegate = self;
    [backgroundView addSubview:_segmentedControl];
    
    CGRect rect = CGRectMake(0, 50, viewWidth, CGRectGetHeight(backgroundView.frame) - 50);
    _scrollView = [[UIScrollView alloc] initWithFrame:rect];
    _scrollView.contentSize = CGSizeMake(viewWidth * items.count, 0);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    [backgroundView addSubview:_scrollView];
    
    [self getDayTasks];
    [self getWeekTasks];
    
    [self getSignInfo];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma mark -
- (IBAction)signAction:(UIButton *)sender {
    if (self.signButton.selected) {
        return;
    }
    
    self.signButton.selected = YES;
    [[NetworkManager sharedManager] postRequest:UserSignIn parameters:nil success:^(NSDictionary * _Nonnull data) {
        
        [self showSignSuccessView];
        [self updateSignLabel:@"已签到" buttonSelect:YES];
        
    } failure:^(NSError * _Nonnull error) {
        self.signButton.selected = NO;
        [self showErrow:error];
    }];
    
}

- (void)updateSignLabel:(NSString *)text buttonSelect:(BOOL)select {
    self.signLabel.text = text;
    
    CGFloat buttonWidth = [self.signLabel.text getWidthWithFont:self.signLabel.font];
    self.signButtonWidth.constant = buttonWidth + 35;
    self.signButton.selected = select;
}

- (void)showSignSuccessView {
    UIView *backView = [[UIView alloc] initWithFrame:self.view.bounds];
    backView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.8];
    [self.view addSubview:backView];
    
    __weak UIView *weakView = backView;
    SignSuccessView *successView = [[SignSuccessView alloc] initWithFrame:CGRectMake(0, 0, 271, 311 + 40)];
    successView.center = self.view.center;
    [backView addSubview:successView];
    
    successView.transform = CGAffineTransformMakeScale(0, 0);
    [UIView animateWithDuration:0.25 animations:^{
        successView.transform = CGAffineTransformIdentity;
    }];
    
    __weak SignSuccessView *weakSSView = successView;
    successView.CloseViewBlock = ^{
        [UIView animateWithDuration:0.25 animations:^{
            weakSSView.transform = CGAffineTransformMakeScale(0.01, 0.01);
        } completion:^(BOOL finished) {
            [weakView removeFromSuperview];
        }];
    };
}

- (void)recordAction {
    TaskRecordViewController *recordVC = [[TaskRecordViewController alloc] init];
    [self.navigationController pushViewController:recordVC animated:YES];
}

- (void)closeSuccessAction:(UIButton *)sender {
    [sender.superview.superview removeFromSuperview];
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
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
        cell.taskModel = model;
        
    } else if (tableView == self.weekTableView) {
        TaskModel *model = self.weekArray[indexPath.row];
        cell.taskModel = model;
    }
    
    return cell;
}

#pragma mark -
- (void)segmentedControlItemSelect:(NSInteger)index {
    
    [self.scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.scrollView.frame) * index, 0) animated:YES];
}

#pragma mark - 网络请求
- (void)getSignInfo {
    [[NetworkManager sharedManager] getRequest:UserSignInfo parameters:nil success:^(NSDictionary * _Nonnull data) {
        
        NSDictionary *signInfo = data[@"data"];
        if (signInfo && [signInfo isKindOfClass:[NSDictionary class]]) {
            long signDate = [signInfo[@"signDate"] longValue];//上次签到时间戳
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Asia/Shanghai"]];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *today = [formatter stringFromDate:[NSDate date]];
            
            if (signDate / 1000 < [[formatter dateFromString:today] timeIntervalSince1970]) {
                //今天没有签到
                [self updateSignLabel:@"每日签到" buttonSelect:NO];
            }
        }
        
    } failure:^(NSError * _Nonnull error) {
    }];
}

- (void)getDayTasks {
    [[NetworkManager sharedManager] getRequest:CommunityTaskDaily parameters:@{@"userId":[UserDataManager shareManager].userId} success:^(NSDictionary * _Nonnull data) {
        NSArray *dataArray = data[@"data"];
        
        if (dataArray && [dataArray isKindOfClass:[NSArray class]] && dataArray.count > 0) {
            self.dayArray = [TaskModel modelWithArray:dataArray];
            [self.dayTableView reloadData];
        } else {
            [self.dayTableView showEmptyView:EmptyViewReasonNoData refreshBlock:nil];
        }
        
    } failure:^(NSError * _Nonnull error) {
        [self.dayTableView showEmptyView:EmptyViewReasonNoNetwork refreshBlock:^{
            
        }];
    }];
}

- (void)getWeekTasks {
    [[NetworkManager sharedManager] getRequest:CommunityTaskWeekly parameters:@{@"userId":[UserDataManager shareManager].userId} success:^(NSDictionary * _Nonnull data) {
        NSArray *dataArray = data[@"data"];
        if (dataArray && [dataArray isKindOfClass:[NSArray class]] && dataArray.count > 0) {
            self.weekArray = [TaskModel modelWithArray:dataArray];
            [self.weekTableView reloadData];
        } else {
            [self.weekTableView showEmptyView:EmptyViewReasonNoData refreshBlock:nil];
        }
        
    } failure:^(NSError * _Nonnull error) {
        [self.weekTableView showEmptyView:EmptyViewReasonNoNetwork refreshBlock:^{
            
        }];
    }];
}

@end
