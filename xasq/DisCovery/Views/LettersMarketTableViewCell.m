//
//  LettersMarketTableViewCell.m
//  xasq
//
//  Created by dssj888@163.com on 2019/9/6.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "LettersMarketTableViewCell.h"

@interface LettersMarketTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLB; // 标题
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *timeLB;
@property (strong, nonatomic)  UIView *lineView; // 竖线


@end

@implementation LettersMarketTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDataModel:(DiscoveryModel *)model {
    _titleLB.text = model.title;
    _timeLB.text = [NSDate timeTransferWithString:model.releaseTime];
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectMake(29, 0, 1, model.cellHeight)];
        [self.contentView addSubview:_lineView];
        [self.contentView sendSubviewToBack:_lineView];
        [UIView drawDashLine:_lineView lineLength:1 lineSpacing:1 lineColor:HexColor(@"#c4c4c4")];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
