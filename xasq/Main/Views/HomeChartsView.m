//
//  HomeChartsView.m
//  xasq
//
//  Created by dssj on 2019/7/31.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "HomeChartsView.h"
#import "SegmentedControl.h"

#import "HomeChartsTableView.h"

@interface HomeChartsView ()<SegmentedControlDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) SegmentedControl *segmentedControl;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) HomeChartsTableView *powerChartView;//算力排行
@property (nonatomic, strong) HomeChartsTableView *levelChartView;//等级排行
@property (nonatomic, strong) HomeChartsTableView *inviteChartView;//邀请排行

@property (nonatomic, strong) NSArray *powerChartDatas;//邀请排行数据

@end

@implementation HomeChartsView

- (HomeChartsTableView *)powerChartView {
    if (!_powerChartView) {
        _powerChartView = [[HomeChartsTableView alloc] initWithFrame:CGRectZero];
        [_scrollView addSubview:_powerChartView];
    }
    return _powerChartView;
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
        
        [self segmentedControlItemSelect:0];
    }
    return self;
}

#pragma mark - 代理方法
- (void)segmentedControlItemSelect:(NSInteger)index {
    
    [_scrollView setContentOffset:CGPointMake(ScreenWidth * index, 0) animated:YES];
    
    if (index == 0) {
        [self getPowerData];
        
        return;
    }
    
    if (index == 1) {
        
        return;
    }
    
    if (index == 2) {
        
        return;
    }
}

#pragma mark-
- (void)getPowerData {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.powerChartDatas = @[@"",@"",@"",@""];
        self.powerChartView.dataArray = self.powerChartDatas;
        
        CGFloat viewHeight = self.powerChartDatas.count * 50;
        
        CGRect rect = self.frame;
        rect.size.height = viewHeight + CGRectGetHeight(self.segmentedControl.frame);
        self.frame = rect;
        
        self.scrollView.frame = CGRectMake(0, CGRectGetHeight(self.segmentedControl.frame), ScreenWidth, viewHeight + CGRectGetHeight(self.segmentedControl.frame));
        
        if (self.HomeChartsDataComplete) {
            self.HomeChartsDataComplete(viewHeight + CGRectGetHeight(self.segmentedControl.frame));
        }
        
    });
    
}

#pragma mark-
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.segmentedControl.currentIndex = page;
    [self.segmentedControl.delegate segmentedControlItemSelect:page];
}


@end
