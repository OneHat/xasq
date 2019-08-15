//
//  RewardBallView.m
//  xasq
//
//  Created by dssj on 2019/8/7.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "RewardBallView.h"

const CGFloat ViewWidth = 50;
//const CGFloat BallWidth = 40;

@interface RewardBallView ()

@property (nonatomic, strong) UILabel *rewardLabel;

@end

@implementation RewardBallView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.frame = CGRectMake(frame.origin.x, frame.origin.y, ViewWidth, ViewWidth);
        
        [self loadSubViews];
    }
    return self;
}

- (void)loadSubViews {
    UIButton *circleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewWidth)];
    [circleButton setImage:nil forState:UIControlStateNormal];
    [circleButton addTarget:self action:@selector(rewardClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:circleButton];
    
    UILabel *rewardLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ViewWidth, ViewWidth)];
    rewardLabel.numberOfLines = 0;
    rewardLabel.textAlignment = NSTextAlignmentCenter;
    rewardLabel.text = @"0.0008BTC";
    rewardLabel.textColor = [UIColor whiteColor];
    rewardLabel.font = [UIFont systemFontOfSize:10];
    [self addSubview:rewardLabel];
    _rewardLabel = rewardLabel;
}

- (void)setRewardModel:(RewardModel *)rewardModel {
    _rewardModel = rewardModel;
    _rewardLabel.text = [NSString stringWithFormat:@"%@\n%@",rewardModel.currencyCode,rewardModel.currencyQuantity];
}

#pragma mark -
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
    sender.enabled = NO;
    
//    NSDictionary *parameters = @{@"userId":[UserDataManager shareManager].userId,
//                                 @"bId":[NSString stringWithFormat:@"%ld",_rewardModel.ID]
//                                 };
//    [[NetworkManager sharedManager] postRequest:CommunityAreaTakeCurrency parameters:parameters success:^(NSDictionary * _Nonnull data) {
//        
//        [self removeFromSuperview];
//        
//    } failure:^(NSError * _Nonnull error) {
//        sender.enabled = YES;
//    }];
    
    if (self.RewardTakeSuccess) {
        self.RewardTakeSuccess();
    }
}

@end
