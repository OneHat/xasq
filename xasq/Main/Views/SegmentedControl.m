//
//  SegmentedControl.m
//  xasq
//
//  Created by dssj on 2019/7/31.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "SegmentedControl.h"

const CGFloat SegmentedSpaceWidth = 10;
const CGFloat SegmentedIndicatorWidth = 50;

#define ButtonTitleNormal        [UIFont systemFontOfSize:13]
#define ButtonTitleSelect        [UIFont boldSystemFontOfSize:14]
#define ButtonTitleColorNormal   ThemeColorTextGray
#define ButtonTitleColorSelect   [UIColor blackColor]

@interface SegmentedControl ()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *indicatorView;//指示器

@property (nonatomic, strong) NSArray *items;//titles

@property (nonatomic, assign) CGFloat currentX;//创建view时，x坐标的值

@property (nonatomic, strong) NSMutableArray *buttons;//按钮集合

@end

@implementation SegmentedControl

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray<NSString *> *)items {
    if (self = [super initWithFrame:frame]) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.bounces = NO;
        [self addSubview:_scrollView];
        
        _items = items;
        _selectIndex = 0;
        _buttons = [NSMutableArray array];
        
        [self loadSubViews];
    }
    return self;
}

- (void)loadSubViews {
    
    CGFloat height = CGRectGetHeight(self.frame);
    
    _indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, height - 3, SegmentedIndicatorWidth, 2)];
    _indicatorView.backgroundColor = ThemeColorBlue;
    [_scrollView addSubview:_indicatorView];
    
    for (int i = 0; i < _items.count; i++) {
        
        CGFloat buttonX = _currentX + SegmentedSpaceWidth;
        CGFloat buttonWidth = [_items[i] getWidthWithFont:ButtonTitleSelect];
        if (buttonWidth < SegmentedIndicatorWidth) {
            buttonWidth = SegmentedIndicatorWidth;
        }
        
//        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(buttonX, 0, buttonWidth, height)];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(buttonX, 0, buttonWidth, height);
        button.adjustsImageWhenHighlighted = NO;
        button.tag = i;
        
        NSDictionary *attributeNormal = @{NSFontAttributeName:ButtonTitleNormal,NSForegroundColorAttributeName:ButtonTitleColorNormal};
        NSAttributedString *attStringNormal = [[NSAttributedString alloc] initWithString:_items[i] attributes:attributeNormal];
        
        NSDictionary *attributeSelect = @{NSFontAttributeName:ButtonTitleSelect,NSForegroundColorAttributeName:ButtonTitleColorSelect};
        NSAttributedString *attStringSelect = [[NSAttributedString alloc] initWithString:_items[i] attributes:attributeSelect];
        
        [button setAttributedTitle:attStringNormal forState:UIControlStateNormal];
        [button setAttributedTitle:attStringSelect forState:UIControlStateSelected];
        [button setAttributedTitle:attStringSelect forState:UIControlStateSelected | UIControlStateHighlighted];
        
        [button addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:button];
        [_buttons addObject:button];
        
        _currentX += buttonWidth + SegmentedSpaceWidth;
        
        if (i == 0) {
            _indicatorView.center = CGPointMake(button.center.x, _indicatorView.center.y);
            button.selected = YES;
        }
    }
    
    if (_currentX + SegmentedSpaceWidth > self.frame.size.width) {
        _scrollView.contentSize = CGSizeMake(_currentX + SegmentedSpaceWidth, 0);
    }
    
}

//点击button
- (void)itemClick:(UIButton *)sender {
    if (_selectIndex != sender.tag) {
        
        for (UIButton *button in _buttons) {
            button.selected = NO;
        }
        
        sender.selected = YES;
        
        [UIView animateWithDuration:0.25 animations:^{
            self.indicatorView.center = CGPointMake(sender.center.x, self.indicatorView.center.y);
        }];
        
        _selectIndex = sender.tag;
        
        if ([self.delegate respondsToSelector:@selector(segmentedControlItemSelect:)]) {
            [self.delegate segmentedControlItemSelect:_selectIndex];
        }
        
    }
    
}

- (void)setSelectIndex:(NSInteger)currentIndex {
    _selectIndex = currentIndex;
    
    for (UIButton *button in _buttons) {
        button.selected = NO;
        if (button.tag == currentIndex) {
            button.selected = YES;
            
            [UIView animateWithDuration:0.25 animations:^{
                self.indicatorView.center = CGPointMake(button.center.x, self.indicatorView.center.y);
            }];
            
            
        }
    }
    
}

@end
