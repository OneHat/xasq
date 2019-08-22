//
//  UITableView+Refresh.m
//  xasq
//
//  Created by dssj on 2019/8/22.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "UITableView+Refresh.h"
#import <MJRefresh/MJRefresh.h>

@implementation UITableView (Refresh)

- (void)pullHeaderRefresh:(DSSJBlock)pullRefresh {
    
    MJRefreshNormalHeader *normalHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        pullRefresh();
    }];
    normalHeader.stateLabel.hidden = YES;
    normalHeader.lastUpdatedTimeLabel.hidden = YES;
    self.mj_header = normalHeader;
}

- (void)pullFooterRefresh:(DSSJBlock)pullRefresh {
    MJRefreshBackNormalFooter *autoFooter = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        pullRefresh();
    }];
    autoFooter.stateLabel.hidden = YES;
    self.mj_footer = autoFooter;
}

- (void)beginRefresh {
    [self.mj_header beginRefreshing];
}

///end
- (void)endRefresh {
    [self.mj_header endRefreshing];
    [self.mj_footer endRefreshing];
}

@end
