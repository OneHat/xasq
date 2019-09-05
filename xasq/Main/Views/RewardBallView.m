//
//  RewardBallView.m
//  xasq
//
//  Created by dssj on 2019/8/7.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "RewardBallView.h"

const CGFloat ViewWidth = 70;

@interface RewardBallView ()

@property (nonatomic, strong) UIImageView *background;//背景

@property (nonatomic, strong) UILabel *nameLabel;//奖励数值
@property (nonatomic, strong) UILabel *rewardLabel;//奖励数值

@property (nonatomic, strong) UIButton *button;//收取/偷取按钮

@property (nonatomic, strong) NSTimer *rewardTimer;//收取/偷取按钮

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
    
    UIImageView *BTC = [[UIImageView alloc] initWithFrame:CGRectMake(18, 15, 10.5, 15)];
    BTC.image = [UIImage imageNamed:@"ball_reward"];
    [self addSubview:BTC];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 15, 40, 20)];
    nameLabel.text = @"BTC";
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont boldSystemFontOfSize:11];
    [self addSubview:nameLabel];
    _nameLabel = nameLabel;
    
    UILabel *rewardLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 22, ViewWidth, 40)];
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
    
    self.nameLabel.text = _rewardModel.currencyCode;
    
    if ([self.nameLabel.text isEqualToString:@"BTC"]) {
        int quantity = _rewardModel.currencyQuantity.doubleValue * BTCRate;
        self.rewardLabel.text = [NSString stringWithFormat:@"%d聪",quantity];
    } else {
        self.rewardLabel.text = [NSString stringWithFormat:@"%.2f",_rewardModel.currencyQuantity.doubleValue];
    }
    
    if (_rewardModel.status == 10) {
        //不可偷取
        self.alpha = 0.5;
//        self.button.enabled = NO;

    } else if (_rewardModel.status == 0) {
        //未成熟
        self.alpha = 0.5;
//        self.button.enabled = NO;
        self.rewardLabel.text = @"挖矿中";

        [self.rewardTimer invalidate];
        self.rewardTimer = nil;

        WeakObject
        self.rewardTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
            [weakSelf refreshStates:timer];
        }];
        [[NSRunLoop currentRunLoop] addTimer:self.rewardTimer forMode:NSRunLoopCommonModes];
    }
    
    [self addAnimation];
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
- (void)refreshStates:(NSTimer *)timer {
    if (self.rewardModel.status != 0) {
        [timer invalidate];
        timer = nil;
        return;
    }
    
    //未成熟
    self.alpha = 0.5;
//    self.button.enabled = NO;
    
    int duration = self.rewardModel.generateTime / 1000 - [[NSDate date] timeIntervalSince1970];
    
    if (duration <= 0) {
        //变成已成熟
        self.alpha = 1.0;
//        self.button.enabled = YES;
        
        if ([self.nameLabel.text isEqualToString:@"BTC"]) {
            int quantity = _rewardModel.currencyQuantity.doubleValue * BTCRate;
            self.rewardLabel.text = [NSString stringWithFormat:@"%d聪",quantity];
        } else {
            self.rewardLabel.text = [NSString stringWithFormat:@"%.2f",_rewardModel.currencyQuantity.doubleValue];
        }
        
        self.rewardModel.status = 1;
        
        [timer invalidate];
        timer = nil;
        
    } else if (duration > 1800) {
        //距离成熟大于30分钟
        self.rewardLabel.text = @"挖矿中";
        
    } else {
        //距离成熟30分钟以内
        
        int minute = duration % 3600 / 60;
        int second = duration % 60;
        
        self.rewardLabel.text = [NSString stringWithFormat:@"%02d:%02d",minute,second];
    }
    
}

#pragma mark -
- (void)addAnimation {
    [self.layer removeAllAnimations];
    
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.fromValue = [NSValue valueWithCGPoint:self.center];
    moveAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(self.center.x, self.center.y + 5)];
    moveAnimation.duration = 1.0;
    moveAnimation.repeatCount = MAXFLOAT;
    moveAnimation.autoreverses = YES;
    moveAnimation.removedOnCompletion = NO;
    moveAnimation.fillMode = kCAFillModeForwards;
    
    [self.layer addAnimation:moveAnimation forKey:@"move"];
}

- (void)rewardClick:(UIButton *)sender {
//    sender.enabled = NO;
    if (_rewardModel.status == 10) {
        //不可偷取
        if (self.TheCluesBallClick) {
            self.TheCluesBallClick();
        }
        return;
    } else if (_rewardModel.status == 0) {
        //未成熟
        if (self.TheCluesBallClick) {
            self.TheCluesBallClick();
        }
        return;
    }
    
    if (self.RewardBallClick) {
        self.RewardBallClick(self);
    }
}

- (void)resetButtonEnable {
//    self.button.enabled = YES;
}

@end
