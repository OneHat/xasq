//
//  InviteCodeView.m
//  xasq
//
//  Created by dssj on 2019/8/6.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "InviteCodeView.h"

@implementation InviteCodeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIView *contentView = [[NSBundle mainBundle] loadNibNamed:@"InviteCodeView" owner:self options:nil].firstObject;
        contentView.frame = self.bounds;
        [self addSubview:contentView];
    }
    return self;
}

@end
