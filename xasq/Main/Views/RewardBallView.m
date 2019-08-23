//
//  RewardBallView.m
//  xasq
//
//  Created by dssj on 2019/8/7.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "RewardBallView.h"

const CGFloat ViewWidth = 60;

@interface RewardBallView ()

@property (nonatomic, strong) UIImageView *background;//背景

@property (nonatomic, strong) UILabel *nameLabel;//奖励数值
@property (nonatomic, strong) UILabel *rewardLabel;//奖励数值

@property (nonatomic, strong) UIButton *button;//收取/偷取按钮

@end

@implementation RewardBallView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, ViewWidth, ViewWidth);
        self.clipsToBounds = YES;
        
        [self loadSubViews];
    }
    return self;
}

- (void)loadSubViews {
    self.background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewWidth)];
    self.background.image = [UIImage imageNamed:@"ball_white"];
    [self addSubview:self.background];
    
    UIImageView *BTC = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 10.5, 15)];
    BTC.image = [UIImage imageNamed:@"ball_reward"];
    [self addSubview:BTC];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(22, 10, 40, 20)];
    nameLabel.text = @"BTC";
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont boldSystemFontOfSize:11];
    [self addSubview:nameLabel];
    _nameLabel = nameLabel;
    
    UILabel *rewardLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, ViewWidth, 40)];
    rewardLabel.numberOfLines = 0;
    rewardLabel.textAlignment = NSTextAlignmentCenter;
    rewardLabel.text = @"0.0008BTC";
    rewardLabel.textColor = [UIColor whiteColor];
    rewardLabel.font = [UIFont boldSystemFontOfSize:11];
    [self addSubview:rewardLabel];
    _rewardLabel = rewardLabel;
    
    UIButton *circleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewWidth)];
    [circleButton setImage:nil forState:UIControlStateNormal];
    [circleButton addTarget:self action:@selector(rewardClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:circleButton];
    self.button = circleButton;
    
    
}

- (void)setRewardModel:(RewardModel *)rewardModel {
    _rewardModel = rewardModel;
    _nameLabel.text = rewardModel.currencyCode;
    
    _rewardLabel.text = [NSString stringWithFormat:@"%.8f",rewardModel.currencyQuantity.doubleValue];
    
    if (rewardModel.status == 10) {
        self.alpha = 0.7;
        self.button.enabled = NO;
    }
}

- (void)setBallStyle:(RewardBallViewStyle)ballStyle {
    _ballStyle = ballStyle;
    
    switch (ballStyle) {
        case RewardBallViewStyleStep:{
            self.background.image = [UIImage imageNamed:@"ball_white"];
        }
            break;
        case RewardBallViewStylePower:{
            self.background.image = [UIImage imageNamed:@"ball_orange"];
        }
        default:
            self.background.image = [UIImage imageNamed:@"ball_orange"];
            break;
    }
}

#pragma mark -
- (void)addAnimation {
    [self.layer removeAllAnimations];
    
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.fromValue = [NSValue valueWithCGPoint:self.center];
    moveAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y + 10)];
    moveAnimation.duration = 1.0;
    moveAnimation.repeatCount = MAXFLOAT;
    moveAnimation.autoreverses = YES;
    
    [self.layer addAnimation:moveAnimation forKey:@"move"];
}

- (void)rewardClick:(UIButton *)sender {
    sender.enabled = NO;
    
    if (self.RewardBallClick) {
        self.RewardBallClick(_rewardModel.ID,self);
    }
}

- (void)resetButtonEnable {
    self.button.enabled = YES;
}

@end
