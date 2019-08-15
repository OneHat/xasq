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

@interface RewardBallView : UIView

@property (nonatomic, strong) RewardModel *rewardModel;

@property (nonatomic, strong) void (^RewardTakeSuccess)(void);

@end

NS_ASSUME_NONNULL_END
