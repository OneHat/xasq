//
//  HomeNewsView.m
//  xasq
//
//  Created by dssj on 2019/7/31.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "HomeNewsView.h"

@interface OneNewsView : UIView

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UILabel *timeLabel;

- (void)setNewsData:(NSDictionary *)news;

@end

@implementation OneNewsView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self loadSubViews];
    }
    return self;
}

- (void)loadSubViews {
    CGFloat height = CGRectGetHeight(self.frame);
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat timeWidth = 100;
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, height, height)];
    [self addSubview:_iconImageView];
    
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(height + 10, 0, width - timeWidth, height)];
    _contentLabel.font = ThemeFontTipText;
    [self addSubview:_contentLabel];
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(width - timeWidth, 0, timeWidth, height)];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    _timeLabel.textColor = ThemeColorTextGray;
    _timeLabel.font = ThemeFontTipText;
    [self addSubview:_timeLabel];
    
}

- (void)setNewsData:(NSDictionary *)news {
    _contentLabel.text = news[@"content"];
    _timeLabel.text = news[@"time"];
}

@end


@interface HomeNewsView ()

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat heightPer;//每行数据高度

@property (nonatomic, strong) NSMutableArray *viewArray;//共有4行view，其中一行用来过渡动画

@end

@implementation HomeNewsView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        
        _width = CGRectGetWidth(self.frame);
        _height = CGRectGetHeight(self.frame);
        _heightPer = _height / 3.0;
        _viewArray = [NSMutableArray array];
    }
    return self;
}

- (void)loadSubViews {
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    _currentIndex = 3;//显示的最新数据的index，后面累加取余
    
    for (int i = 0; i < 4; i++) {
        OneNewsView *newsView = [[OneNewsView alloc] initWithFrame:CGRectMake(0, _height - _heightPer * (i + 1), _width, _heightPer)];
        [newsView setNewsData:_newsArray[i % _newsArray.count]];
        [self addSubview:newsView];
        
        [self.viewArray addObject:newsView];
    }
    
    [NSTimer scheduledTimerWithTimeInterval:3.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self addNews];
    }];
    
}

- (void)setNewsArray:(NSArray *)newsArray {
    _newsArray = newsArray;
    
    [self loadSubViews];
}

- (void)addNews {
    
    for (OneNewsView *view in self.viewArray) {
        
        CGRect rect = view.frame;
        rect.origin.y += self.heightPer;
        
        //页面向下滚动，最底下一行动画完成后移到最上面
        if (rect.origin.y == self.frame.size.height) {
            
            [UIView animateWithDuration:0.25 animations:^{
                view.frame = rect;
            } completion:^(BOOL finished) {
                
                view.frame = CGRectMake(0, -self.heightPer, self.width, self.heightPer);
                
                self.currentIndex++;
                
                [view setNewsData:self.newsArray[self.currentIndex % self.newsArray.count]];
            }];
            
        } else {
            [UIView animateWithDuration:0.25 animations:^{
                view.frame = rect;
            }];
        }
        
    }
    
}


@end

