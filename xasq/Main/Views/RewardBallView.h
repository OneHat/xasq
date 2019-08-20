//
//  RewardBallView.h
//  xasq
//
//  Created by dssj on 2019/8/7.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RewardModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,RewardBallViewStyle) {
    RewardBallViewStyleStep,//步行奖励
    RewardBallViewStylePower,//算力奖励
};

@interface RewardBallView : UIView

@property (nonatomic, strong) RewardModel *rewardModel;

@property (nonatomic, strong) void (^RewardBallClick)(NSInteger rewardId);

@property (nonatomic, assign) RewardBallViewStyle ballStyle;

@end

NS_ASSUME_NONNULL_END
