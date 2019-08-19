//
//  HomeRankView.m
//  xasq
//
//  Created by dssj on 2019/7/31.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "HomeRankView.h"
#import "SegmentedControl.h"

#import "HomeRankTableView.h"

@interface HomeRankView ()<SegmentedControlDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) SegmentedControl *segmentedControl;
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) HomeRankTableView *powerRankView;//算力排行
@property (nonatomic, strong) HomeRankTableView *levelRankView;//等级排行
@property (nonatomic, strong) HomeRankTableView *inviteRankView;//邀请排行

///算力排行数据、等级排行数据(是同一个数据)
@property (nonatomic, strong) NSArray *powerRankDatas;//算力排行数据
@property (nonatomic, strong) NSArray *levelRankDatas;//等级排行数据

@property (nonatomic, strong) NSArray *inviteRankDatas;//邀请排行数据

@end

@implementation HomeRankView

- (HomeRankTableView *)powerRankView {
    if (!_powerRankView) {
        _powerRankView = [[HomeRankTableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 0)];
        [_scrollView addSubview:_powerRankView];
    }
    return _powerRankView;
}

- (HomeRankTableView *)levelRankView {
    if (!_levelRankView) {
        _levelRankView = [[HomeRankTableView alloc] initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, 0)];
        [_scrollView addSubview:_levelRankView];
    }
    return _levelRankView;
}

- (HomeRankTableView *)inviteRankView {
    if (!_inviteRankView) {
        _inviteRankView = [[HomeRankTableView alloc] initWithFrame:CGRectMake(ScreenWidth * 2, 0, ScreenWidth, 0)];
        [_scrollView addSubview:_inviteRankView];
    }
    return _inviteRankView;
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
        
//        [self getRankData];
    }
    return self;
}

#pragma mark - 代理方法
- (void)segmentedControlItemSelect:(NSInteger)index {
    [_scrollView setContentOffset:CGPointMake(ScreenWidth * index, 0) animated:YES];
    
//    if (index == 0) {
//        return;
//    }
//
//    if (index == 1) {
//
//        return;
//    }
//
//    if (index == 2) {
//
//        return;
//    }
    
    [self resizeFrame];
}

#pragma mark-
- (void)getRankData {
    NSDictionary *parameters = @{@"pageNo":@(0),@"pageSize":@(10),@"order":@"desc"};
    
    [[NetworkManager sharedManager] postRequest:UserInviteAllpower parameters:parameters success:^(NSDictionary * _Nonnull data) {
        NSLog(@"%@",data);
        
    } failure:^(NSError * _Nonnull error){
        
    }];
    
    [[NetworkManager sharedManager] postRequest:UserInviteCount parameters:parameters success:^(NSDictionary * _Nonnull data) {
        NSLog(@"%@",data);
        
    } failure:^(NSError * _Nonnull error){
        
    }];
    
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        self.powerRankDatas = @[@"",@"",@"",@""];
//        self.powerRankView.dataArray = self.powerRankDatas;
//        
//        self.levelRankDatas = @[@"",@"",@"",@"",@"",@"",@"",@""];
//        self.levelRankView.dataArray = self.levelRankDatas;
//
//        self.inviteRankDatas = @[@"",@"",@"",@"",@"",@""];
//        self.inviteRankView.dataArray = self.inviteRankDatas;
//        
//        [self resizeFrame];
//    });
    
}

- (void)resizeFrame {
    NSInteger currentIndex = self.segmentedControl.selectIndex;
    
    CGFloat viewHeight = 0.0;
    if (currentIndex == 0) {
        viewHeight = CGRectGetHeight(self.powerRankView.frame);
        
    } else if (currentIndex == 1) {
        viewHeight = CGRectGetHeight(self.levelRankView.frame);
        
    } else if (currentIndex == 2) {
        viewHeight = CGRectGetHeight(self.inviteRankView.frame);
        
    }
    
    CGRect rect = self.frame;
    rect.size.height = viewHeight + CGRectGetHeight(self.segmentedControl.frame);
    self.frame = rect;
    
    self.scrollView.frame = CGRectMake(0, CGRectGetHeight(self.segmentedControl.frame), ScreenWidth, viewHeight + CGRectGetHeight(self.segmentedControl.frame));
    
    if (self.HomeRankDataComplete) {
        self.HomeRankDataComplete(viewHeight + CGRectGetHeight(self.segmentedControl.frame));
    }
}

#pragma mark-
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int page = scrollView.contentOffset.x / scrollView.frame.size.width;
    self.segmentedControl.selectIndex = page;
    [self.segmentedControl.delegate segmentedControlItemSelect:page];
}


@end
