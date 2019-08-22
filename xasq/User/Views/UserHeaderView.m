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
    _portraitImageV.layer.cornerRadius = 27.5;
    _portraitImageV.layer.masksToBounds = YES;

}

- (IBAction)dwellBtnClick:(UIButton *)sender {
    if (_dwellBtnBlock) {
        _dwellBtnBlock();
    }
}

- (IBAction)messageBtnClick:(UIButton *)sender {
    if (_messageBtnBlock) {
        _messageBtnBlock();
    }
}

- (IBAction)taskBtnClick:(UIButton *)sender {
    if (_taskBtnBlock) {
        _taskBtnBlock();
    }
}

- (IBAction)friendBtnClick:(UIButton *)sender {
    if (_friendBtnBlock) {
        _friendBtnBlock();
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
