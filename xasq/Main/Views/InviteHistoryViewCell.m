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
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.timeLabel.textColor = ThemeColorTextGray;
    
    self.currencyNameLabel.textColor = ThemeColorTextGray;
    self.powerNameLabel.textColor = ThemeColorTextGray;
    
    self.lineView.backgroundColor = ThemeColorLine;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setInviteInfo:(NSDictionary *)inviteInfo {
    _inviteInfo = inviteInfo;
    
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:_inviteInfo[@"userHead"]] placeholderImage:[UIImage imageNamed:@"head_portrait"]];
    
    self.nameLabel.text = inviteInfo[@"userName"];
    self.timeLabel.text = inviteInfo[@"createdOn"];
    
    if (inviteInfo[@"power"]) {
        self.powerNumberLabel.text = [NSString stringWithFormat:@"+%@",inviteInfo[@"power"]];
    }
    self.currencyImageView.image = Base64ImageStr(_inviteInfo[@"currencyIcon"]);
    self.currencyNameLabel.text = _inviteInfo[@"currency"];
    if (_inviteInfo[@"quantity"]) {
        if ([inviteInfo[@"currency"] isEqualToString:@"BTC"]) {
            int quantity = [inviteInfo[@"quantity"] doubleValue] * BTCRate;
            self.currencyNumberLabel.text = [NSString stringWithFormat:@"%d聪",quantity];
        } else {
            self.currencyNumberLabel.text = [NSString stringWithFormat:@"+%@",_inviteInfo[@"quantity"]];
        }
    }
}

@end
