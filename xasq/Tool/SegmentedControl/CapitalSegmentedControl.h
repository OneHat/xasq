//
//  CapitalSegmentedControl.h
//  xasq
//
//  Created by dssj on 2019/8/1.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CapitalSegmentedControl : UIView

@property (nonatomic, assign) NSInteger currentIndex;//当前显示index

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray<NSString *> *)items;

@end

NS_ASSUME_NONNULL_END
