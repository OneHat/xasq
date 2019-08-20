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

@property (weak, nonatomic) IBOutlet UIImageView *currencyImageView;
@property (weak, nonatomic) IBOutlet UILabel *currencyNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *currencyNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *powerNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *powerNameLabel;

@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

@implementation InviteHistoryViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.timeLabel.textColor = ThemeColorTextGray;
    
    self.currencyNameLabel.textColor = ThemeColorTextGray;
    self.powerNameLabel.textColor = ThemeColorTextGray;
    
    self.lineView.backgroundColor = ThemeColorLine;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
