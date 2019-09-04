//
//  FriendsRankViewCell.m
//  xasq
//
//  Created by dssj on 2019/8/14.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "FriendsRankViewCell.h"

@interface FriendsRankViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *rankLabel;

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *powNumberLabel;

@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

@implementation FriendsRankViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.lineView.backgroundColor = ThemeColorLine;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (void)setFriendInfo:(UserRankModel *)friendInfo {
    _friendInfo = friendInfo;
    
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:_friendInfo.userHead] placeholderImage:[UIImage imageNamed:@"head_portrait"]];
    
    self.rankLabel.text = [NSString stringWithFormat:@"%ld",_friendInfo.rank];
    
    self.nameLabel.text = _friendInfo.userName;
    self.typeLabel.text = _friendInfo.areaName;
    self.powNumberLabel.text = [NSString stringWithFormat:@"%ld",_friendInfo.power];
}

@end
