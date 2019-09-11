//
//  AdvertisTableViewCell.m
//  xasq
//
//  Created by dssj888@163.com on 2019/9/6.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "AdvertisTableViewCell.h"

@interface AdvertisTableViewCell ()


@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UIImageView *advertImageV;
@property (strong, nonatomic)  UIView *lineView; // 竖线

@end

@implementation AdvertisTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDataModel:(DiscoveryModel *)model {
    [_advertImageV sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
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
