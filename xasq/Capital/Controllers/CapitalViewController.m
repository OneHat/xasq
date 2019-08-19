//
//  CapitalViewController.m
//  xasq
//
//  Created by dssj on 2019/8/1.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "CapitalViewController.h"
#import "CapitalKindViewController.h"
#import "CapitalSegmentedControl.h"
#import "CapitalMainView.h"
#import "MentionMoneyViewController.h"
#import "PaymentsRecordsViewController.h"
#import "CapitalModel.h"

@interface CapitalViewController ()<CapitalSegmentedControlDelegate,UIScrollViewDelegate,CapitalMainViewDelegate>

@property (strong, nonatomic) CapitalSegmentedControl *segmentedControl;

@property (nonatomic, strong) UIScrollView *scrollView;//

@property (strong, nonatomic) CapitalMainView *walletView;//钱包账户
@property (strong, nonatomic) CapitalMainView *mineView;//挖矿账户

//参考HomeViewController（首页）
@property (assign, nonatomic) BOOL hideNavBarAnimation;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation CapitalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11.0, *)) {
        _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    _dataArray = [NSMutableArray array];
    //最先add的view
    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    topImageView.image = [UIImage imageNamed:@"capital_topBackground"];
    [self.view addSubview:topImageView];
    
    //第二add的view
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - BottomHeight - 49)];
    _scrollView.contentSize = CGSizeMake(ScreenWidth * 2, 0);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
    //辅助view
    UIImageView *tempImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, NavHeight + 44)];
    tempImageView.image = [UIImage imageNamed:@"capital_topBackground"];
    tempImageView.contentMode = UIViewContentModeTop;
    tempImageView.clipsToBounds = YES;
    [self.view addSubview:tempImageView];
    
    
    //第三add的view
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, StatusBarHeight, ScreenWidth, 44)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"资产";
    titleLabel.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:titleLabel];
    
    UIButton *recordButton = [[UIButton alloc] initWithFrame:CGRectMake(ScreenWidth - 50, StatusBarHeight, 44, 44)];
    recordButton.adjustsImageWhenHighlighted = NO;
    [recordButton setImage:[UIImage imageNamed:@"capital_record"] forState:UIControlStateNormal];
    [recordButton addTarget:self action:@selector(recordButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:recordButton];
    
    //第四add的view
    CGRect segmentFrame = CGRectMake(0, NavHeight - 10, ScreenWidth, 44);
    _segmentedControl = [[CapitalSegmentedControl alloc] initWithFrame:segmentFrame items:@[@"我的钱包",@"挖财账户"]];
    _segmentedControl.delegate = self;
    [self.view addSubview:_segmentedControl];
    
    //钱包账户
    _walletView = [[CapitalMainView alloc] initWithFrame:_scrollView.bounds];
    _walletView.delegate = self;
    [_scrollView addSubview:_walletView];
    
    //挖矿账户
    _mineView = [[CapitalMainView alloc] initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, _scrollView.frame.size.height)];
    _mineView.delegate = self;
    [_scrollView addSubview:_mineView];
    
    topImageView.frame = CGRectMake(0, 0, ScreenWidth, _walletView.topCapitalViewH);
    
    //
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCapitalHideAnimation) name:DSSJTabBarSelectCapitalNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:_hideNavBarAnimation];
    _hideNavBarAnimation = YES;
    [self sendCommunityCapitalStatistics];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)changeCapitalHideAnimation {
    _hideNavBarAnimation = NO;
}

- (void)sendCommunityCapitalStatistics {
    WeakObject;
    NSDictionary *dict = @{@"userId" : [UserDataManager shareManager].userId,
                           @"pageNo" : @"1"
                           };
    [[NetworkManager sharedManager] getRequest:CommunityCapitalStatistics parameters:dict success:^(NSDictionary * _Nonnull data) {
        NSArray *array = data[@"data"][@"userCapitalResponseList"][@"rows"];
        [weakSelf.dataArray removeAllObjects];
        for (NSDictionary *dic in array) {
            CapitalModel *model = [CapitalModel modelWithDictionary:dic];
            [weakSelf.dataArray addObject:model];
        }
        [weakSelf.walletView setCapitalDataArray:data];
    } failure:^(NSError * _Nonnull error) {
        [self showErrow:error];
    }];
}

#pragma mark - 收支记录界面
- (void)recordButtonAction:(UIButton *)sender {
    //收支记录
    PaymentsRecordsViewController *recordsVC = [[PaymentsRecordsViewController alloc] init];
    recordsVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:recordsVC animated:YES];
}

#pragma mark-
- (void)segmentedControlItemSelect:(NSInteger)index {
    [_scrollView setContentOffset:CGPointMake(ScreenWidth * index, 0) animated:YES];
    
    if (index == 0) {
        
    } else if (index == 1) {
        
    }
}

#pragma mark-
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.segmentedControl.currentIndex = page;
    [self.segmentedControl.delegate segmentedControlItemSelect:page];
}

#pragma mark - CapitalMainViewDelegate
- (void)capitalMainViewCellSelect:(NSInteger)index {
    //某一币种
    CapitalKindViewController *kindVC = [[CapitalKindViewController alloc] init];
    kindVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:kindVC animated:YES];
}

- (void)capitalMainViewSearchClick {
//    //搜索
//    CapitalSearchViewController *searchVC = [[CapitalSearchViewController alloc] init];
//    searchVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:searchVC animated:YES];
}

- (void)capitalMainViewDrawClick {
    //提币
    MentionMoneyViewController *mentionMoneyViewVC = [[MentionMoneyViewController alloc] init];
    mentionMoneyViewVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:mentionMoneyViewVC animated:YES];
}

@end
