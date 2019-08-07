//
//  RewardBallView.m
//  xasq
//
//  Created by dssj on 2019/8/7.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "RewardBallView.h"

const CGFloat ViewWidth = 50;
const CGFloat BallWidth = 40;

@implementation RewardBallView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, ViewWidth, ViewWidth + 20);
        
        [self loadSubViews];
        [self addAnimation];
    }
    return self;
}

- (void)loadSubViews {
    UIButton *circleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewWidth)];
    [circleButton setImage:nil forState:UIControlStateNormal];
    [circleButton addTarget:self action:@selector(rewardClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:circleButton];
    
    
    UILabel *rewardLabel = [[UILabel alloc] initWithFrame:CGRectMake((ViewWidth - BallWidth) * 0.5, 0, BallWidth, BallWidth)];
    rewardLabel.numberOfLines = 0;
    rewardLabel.text = @"0.0008BTC";
    rewardLabel.textColor = [UIColor whiteColor];
    rewardLabel.font = [UIFont systemFontOfSize:10];
    [self addSubview:rewardLabel];
    
    
    UILabel *sourceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, BallWidth, ViewWidth, 20)];
    sourceLabel.text = @"步行奖励";
    sourceLabel.textColor = [UIColor whiteColor];
    sourceLabel.font = [UIFont systemFontOfSize:10];
    sourceLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:sourceLabel];
}

- (void)addAnimation {
    
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.fromValue = [NSValue valueWithCGPoint:self.center];
    moveAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y + 10)];
    moveAnimation.duration = 1.0;
    moveAnimation.repeatCount = MAXFLOAT;
    moveAnimation.autoreverses = YES;
    
    [self.layer addAnimation:moveAnimation forKey:@"move"];
}

- (void)rewardClick:(UIButton *)sender {
    [self removeFromSuperview];
}

@end
