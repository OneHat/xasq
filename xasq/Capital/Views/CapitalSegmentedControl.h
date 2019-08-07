//
//  CapitalSegmentedControl.h
//  xasq
//
//  Created by dssj on 2019/8/1.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CapitalSegmentedControlDelegate <NSObject>

- (void)segmentedControlItemSelect:(NSInteger)index;

@end

@interface CapitalSegmentedControl : UIView

@property (nonatomic, assign) NSInteger currentIndex;//当前显示index

@property (nonatomic, weak) id<CapitalSegmentedControlDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray<NSString *> *)items;

@end

NS_ASSUME_NONNULL_END
