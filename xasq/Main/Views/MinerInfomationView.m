//
//  MinerInfomationView.m
//  xasq
//
//  Created by dssj on 2019/8/6.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "MinerInfomationView.h"

@implementation MinerInfomationView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UIView *contentView = [[NSBundle mainBundle] loadNibNamed:@"MinerInfomationView" owner:self options:nil].firstObject;
        contentView.backgroundColor = [UIColor clearColor];
        contentView.frame = self.bounds;
        [self addSubview:contentView];
    }
    return self;
}

@end
