//
//  HomeBannerView.h
//  xasq
//
//  Created by dssj on 2019/8/5.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeBannerView : UIView

@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, copy) void (^ImageClickBlock)(NSInteger index);

- (void)openTimer;
- (void)invalidateTimer;

@end

NS_ASSUME_NONNULL_END
