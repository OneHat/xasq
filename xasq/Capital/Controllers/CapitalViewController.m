//
//  CapitalViewController.m
//  xasq
//
//  Created by dssj on 2019/8/1.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "CapitalViewController.h"
#import "CapitalKindViewController.h"
#import "CapitalSearchViewController.h"
#import "CapitalSegmentedControl.h"
#import "CapitalMainView.h"

@interface CapitalViewController ()<CapitalSegmentedControlDelegate,UIScrollViewDelegate,CapitalMainViewDelegate>

@property (strong, nonatomic) CapitalSegmentedControl *segmentedControl;

@property (nonatomic, strong) UIScrollView *scrollView;//

@property (strong, nonatomic) CapitalMainView *walletView;//钱包账户
@property (strong, nonatomic) CapitalMainView *mineView;//挖矿账户

@property (assign, nonatomic) BOOL isHideMoney;//是否隐藏金额

@end

@implementation CapitalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"资产";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11.0, *)) {
        _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    ///
    [self setNavBarBackGroundColor:[UIColor clearColor]];
    [self setNavBarTitleColor:[UIColor whiteColor]];
    
    [self initRightBtnWithImage:[UIImage imageNamed:@"capital_eyeOpen"]];
    
    //////
    
    UIImageView *topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    topImageView.image = [UIImage imageNamed:@"capital_topBackground"];
    [self.view addSubview:topImageView];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - BottomHeight - 49)];
    _scrollView.contentSize = CGSizeMake(ScreenWidth * 2, 0);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
    
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
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

#pragma mark-
- (void)rightBtnAction {
    _isHideMoney = !_isHideMoney;
    
    if (_isHideMoney) {
        [self initRightBtnWithImage:[UIImage imageNamed:@"capital_eyeClose"]];
        
    } else {
        [self initRightBtnWithImage:[UIImage imageNamed:@"capital_eyeOpen"]];
    }
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
    //
    CapitalKindViewController *kindVC = [[CapitalKindViewController alloc] init];
    kindVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:kindVC animated:YES];
}

- (void)capitalMainViewSearchClick {
    CapitalSearchViewController *searchVC = [[CapitalSearchViewController alloc] init];
    searchVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:searchVC animated:YES];
}

- (void)capitalMainViewButtonModuleClick:(NSInteger)index {
    
}

- (void)capitalMainViewRecordClick {
    
}

@end
