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

@end

@implementation OneNewsView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)loadSubViews {
    CGFloat height = CGRectGetHeight(self.frame);
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat timeWidth = 100;
    
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, height, height)];
    
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(height + 10, 0, width - timeWidth, height)];
    
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(width - timeWidth, 0, timeWidth, height)];
    _timeLabel.textAlignment = NSTextAlignmentRight;
    _timeLabel.textColor = ThemeColorTextGray;
    _timeLabel.font = ThemeFontNormalText;
}

@end



@interface HomeNewsView ()

@property (nonatomic, strong) OneNewsView *newsView;

@end

@implementation HomeNewsView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}

- (void)loadSubViews {
    
}

@end

