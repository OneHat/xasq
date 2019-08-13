//
//  InviteHistoryViewCell.m
//  xasq
//
//  Created by dssj on 2019/8/7.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "InviteHistoryViewCell.h"

@interface InviteHistoryViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@end

@implementation InviteHistoryViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _timeLabel.textColor = ThemeColorTextGray;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
