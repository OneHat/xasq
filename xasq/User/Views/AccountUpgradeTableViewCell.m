//
//  AccountUpgradeTableViewCell.m
//  xasq
//
//  Created by dssj888@163.com on 2019/8/2.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "AccountUpgradeTableViewCell.h"

@implementation AccountUpgradeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _backgView.layer.cornerRadius = 2;
    _backgView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
