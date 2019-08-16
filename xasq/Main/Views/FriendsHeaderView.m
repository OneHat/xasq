//
//  FriendsHeaderView.m
//  xasq
//
//  Created by dssj888@163.com on 2019/8/15.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "FriendsHeaderView.h"

@implementation FriendsHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *headerView = [[NSBundle mainBundle] loadNibNamed:@"FriendsHeaderView" owner:nil options:nil].firstObject;
        headerView.frame = frame;
        self = (FriendsHeaderView *)headerView;
    }
    return self;
}

@end
