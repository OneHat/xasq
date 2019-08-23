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
    
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:_inviteInfo[@"headImg"]]];
    
    self.nameLabel.text = inviteInfo[@"nickName"];
    self.timeLabel.text = inviteInfo[@"bindTime"];
    
    self.powerNumberLabel.text = [NSString stringWithFormat:@"+%@",inviteInfo[@"awardPower"]];
    
    self.currencyImageView.image = Base64ImageStr(_inviteInfo[@"currencyLogo"]);
    self.currencyNameLabel.text = _inviteInfo[@"currencyCode"];
    
    NSString *num = _inviteInfo[@"currencyCount"];
    self.currencyNumberLabel.text = [NSString stringWithFormat:@"+%.8f",num.doubleValue];
}

@end
