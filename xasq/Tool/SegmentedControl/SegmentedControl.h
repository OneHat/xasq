//
//  SegmentedControl.h
//  xasq
//
//  Created by dssj on 2019/7/31.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SegmentedControl : UIView

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray<NSString *> *)items;

@end

NS_ASSUME_NONNULL_END
