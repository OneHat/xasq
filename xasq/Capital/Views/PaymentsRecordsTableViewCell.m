//
//  PaymentsRecordsTableViewCell.m
//  xasq
//
//  Created by dssj888@163.com on 2019/8/5.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "PaymentsRecordsTableViewCell.h"

@implementation PaymentsRecordsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(PaymentsRecordModel *)model {
    _model = model;
    _valueLB.text = [NSString stringWithFormat:@"%@",model.amount];
    NSInteger cause = [model.cause integerValue];
    if (cause == 12) {
        _icon.image = [UIImage imageNamed:@"capital_extract"];
        _titleLB.text = @"提币";
    } else if (cause == 14) {
        _icon.image = [UIImage imageNamed:@"capital_reward"];
        _titleLB.text = @"任务奖励";
    } else if (cause == 15 || cause == 16) {
        _icon.image = [UIImage imageNamed:@"capital_dig"];
        _titleLB.text = @"挖矿收益";
    } else if (cause == 17) {
        _icon.image = [UIImage imageNamed:@"capital_group"];
        _titleLB.text = @"团收益";
    }
    CGFloat amount = [_model.amount floatValue];
    if (amount > 0) {
        _valueLB.textColor = HexColor(@"#ff5000");
    } else {
        _valueLB.textColor = ThemeColorText;
    }
}

@end
