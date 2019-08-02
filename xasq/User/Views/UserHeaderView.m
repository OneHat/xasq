//
//  UserHeaderView.m
//  xasq
//
//  Created by dssj888@163.com on 2019/8/1.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "UserHeaderView.h"

@implementation UserHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    _countLB.layer.cornerRadius = 7.5;
    _countLB.layer.masksToBounds = YES;

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
