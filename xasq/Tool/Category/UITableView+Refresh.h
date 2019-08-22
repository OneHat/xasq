//
//  UITableView+Refresh.h
//  xasq
//
//  Created by dssj on 2019/8/22.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (Refresh)

///上拉刷新
- (void)pullHeaderRefresh:(DSSJBlock)pullRefresh;

///下拉刷新
- (void)pullFooterRefresh:(DSSJBlock)pullRefresh;

///开始下拉刷新
- (void)beginRefresh;

///end
- (void)endRefresh;

@end

NS_ASSUME_NONNULL_END
