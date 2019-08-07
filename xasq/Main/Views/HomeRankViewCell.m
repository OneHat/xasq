//
//  HomeRankViewCell.m
//  xasq
//
//  Created by dssj on 2019/8/1.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "HomeRankViewCell.h"

@interface HomeRankViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *selfImageView;

@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rankImageView;

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomLine;

@end

@implementation HomeRankViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _nameLabel.font = ThemeFontText;
    
    _areaLabel.font = ThemeFontSmallText;
    _areaLabel.textColor = ThemeColorTextGray;
    
    _valueLabel.textColor = ThemeColorTextGray;
    
    _bottomLine.backgroundColor = ThemeColorLine;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
