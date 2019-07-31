//
//  UIView+Empty.h
//  xasq
//
//  Created by dssj on 2019/7/30.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,EmptyViewReason) {
    //没有数据
    EmptyViewReasonNoData,
    //没有网络
    EmptyViewReasonNoNetwork
};

typedef void(^RefreshBlock)(void);

@interface UIView (Empty)

///
- (void)showEmptyView:(EmptyViewReason)reason refreshBlock:(nullable RefreshBlock)block;

- (void)hideEmptyView;

@end

NS_ASSUME_NONNULL_END
