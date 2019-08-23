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
    CGFloat timeWidth = 80;
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, height, height)];
    [self addSubview:_iconImageView];
    
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(height + 20, 0, width - timeWidth - height - 30, height)];
    _contentLabel.font = ThemeFontTipText;
    [self addSubview:_contentLabel];
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(width - timeWidth - 10, 0, timeWidth, height)];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    _timeLabel.textColor = ThemeColorTextGray;
    _timeLabel.font = ThemeFontTipText;
    [self addSubview:_timeLabel];
    
}

- (void)setNewsData:(UserNewsModel *)news {
//    [_iconImageView sd_setImageWithURL:<#(nullable NSURL *)#>]
    self.contentLabel.text = [NSString stringWithFormat:@"%@偷取了 %.8f %@",news.userName,news.quantity.doubleValue,news.currencyCode];
    self.timeLabel.text = news.showTime;
    
    if (![news.showDate isEqualToString: @"今天"]) {
        self.timeLabel.text = news.showDate;
    }
    
}

@end


@interface HomeNewsView ()

@property (nonatomic, assign) NSInteger currentIndex;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat heightPer;//每行数据高度

@property (nonatomic, strong) NSMutableArray *viewArray;//共有4行view，其中一行用来过渡动画

@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;

@end

@implementation HomeNewsView

- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.frame = CGRectMake(ScreenWidth * 0.5-10, CGRectGetHeight(self.frame) * 0.5-10, 20, 20);
        [_indicatorView startAnimating];
    }
    return _indicatorView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds = YES;
        
        _width = CGRectGetWidth(self.frame);
        _height = CGRectGetHeight(self.frame);
        _heightPer = _height / 3.0;
        _viewArray = [NSMutableArray array];
        
        [self addSubview:self.indicatorView];
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
    
//    [NSTimer scheduledTimerWithTimeInterval:3.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        [self loadNextNews];
//    }];
    
}

- (void)setNewsArray:(NSArray *)newsArray {
    _newsArray = newsArray;
    
    if (_newsArray.count > 0) {
        [self.indicatorView removeFromSuperview];
        self.indicatorView = nil;
        
        [self loadSubViews];
    } else {
        [self.indicatorView removeFromSuperview];
        self.indicatorView = nil;
        
        [self addSubview:self.indicatorView];
        [self.indicatorView startAnimating];
    }
}

- (void)loadNextNews {
    
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

