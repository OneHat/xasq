//
//  HomeRankView.h
//  xasq
//
//  Created by dssj on 2019/7/31.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeRankView : UIView

@property (nonatomic, strong) void (^HomeRankDataComplete)(CGFloat viewHeight);

- (void)reloadViewData;

@end

NS_ASSUME_NONNULL_END
