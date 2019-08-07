//
//  SegmentedControl.h
//  xasq
//
//  Created by dssj on 2019/7/31.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SegmentedControlDelegate <NSObject>

- (void)segmentedControlItemSelect:(NSInteger)index;

@end

@interface SegmentedControl : UIView

@property (nonatomic, assign) NSInteger selectIndex;//当前显示index

@property (nonatomic, weak) id<SegmentedControlDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray<NSString *> *)items;

@end

NS_ASSUME_NONNULL_END
