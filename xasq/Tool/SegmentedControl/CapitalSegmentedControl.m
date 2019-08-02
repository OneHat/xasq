//
//  CapitalSegmentedControl.m
//  xasq
//
//  Created by dssj on 2019/8/1.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "CapitalSegmentedControl.h"

//const CGFloat SegmentedIndicatorWidth = 50;

#define ButtonTitleNormal        [UIFont systemFontOfSize:14]
#define ButtonTitleSelect        [UIFont boldSystemFontOfSize:16]
#define ButtonTitleColorNormal   [UIColor whiteColor]
#define ButtonTitleColorSelect   [UIColor whiteColor]

@interface CapitalSegmentedControl ()

//@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *indicatorView;//指示器

@property (nonatomic, strong) NSArray *items;//titles

@property (nonatomic, strong) NSMutableArray *buttons;//按钮集合

@end

@implementation CapitalSegmentedControl

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray<NSString *> *)items {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        _items = items;
        _currentIndex = 0;
        _buttons = [NSMutableArray array];
        
        [self loadSubViews];
    }
    return self;
}

- (void)loadSubViews {
    
    CGFloat height = CGRectGetHeight(self.frame);
    CGFloat buttonWidth = 100;
    
    _indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, height - 5, 50, 2)];
    _indicatorView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_indicatorView];
    
    for (int i = 0; i < _items.count; i++) {
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, height)];
        button.center = CGPointMake(ScreenWidth * 0.25 + ScreenWidth * 0.5 * i, button.center.y);
        button.tag = i;
        
        NSDictionary *attributeNormal = @{NSFontAttributeName:ButtonTitleNormal,NSForegroundColorAttributeName:ButtonTitleColorNormal};
        NSAttributedString *attStringNormal = [[NSAttributedString alloc] initWithString:_items[i] attributes:attributeNormal];
        
        NSDictionary *attributeSelect = @{NSFontAttributeName:ButtonTitleSelect,NSForegroundColorAttributeName:ButtonTitleColorSelect};
        NSAttributedString *attStringSelect = [[NSAttributedString alloc] initWithString:_items[i] attributes:attributeSelect];
        
        [button setAttributedTitle:attStringNormal forState:UIControlStateNormal];
        [button setAttributedTitle:attStringSelect forState:UIControlStateSelected];
        [button setAttributedTitle:attStringSelect forState:UIControlStateSelected | UIControlStateHighlighted];
        
        [button addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [_buttons addObject:button];
        
        if (i == 0) {
            _indicatorView.center = CGPointMake(button.center.x, _indicatorView.center.y);
            button.selected = YES;
        }
    }
    
}

//点击button
- (void)itemClick:(UIButton *)sender {
    if (_currentIndex != sender.tag) {
        
        for (UIButton *button in _buttons) {
            button.selected = NO;
        }
        
        sender.selected = YES;
        
        [UIView animateWithDuration:0.25 animations:^{
            self.indicatorView.center = CGPointMake(sender.center.x, self.indicatorView.center.y);
        }];
        
        _currentIndex = sender.tag;
        
        if ([self.delegate respondsToSelector:@selector(segmentedControlItemSelect:)]) {
            [self.delegate segmentedControlItemSelect:_currentIndex];
        }
        
    }
    
}

- (void)setCurrentIndex:(NSInteger)currentIndex {
    _currentIndex = currentIndex;
    
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
