//
//  TacticsViewCell.m
//  xasq
//
//  Created by dssj on 2019/7/29.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "TacticsViewCell.h"
#import "TacticsObject.h"

@interface TacticsViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *shortDescLabel;

@property (weak, nonatomic) IBOutlet UILabel *rewardLabel;

@end

@implementation TacticsViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)cellWithTacsics:(TacticsObject *)model {
    _nameLabel.text = model.name;
    _shortDescLabel.text = model.shortDes;
    _rewardLabel.text = model.reward;
}

@end
