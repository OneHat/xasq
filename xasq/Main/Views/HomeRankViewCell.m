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
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.nameLabel.font = ThemeFontSmallText;
    
    self.areaLabel.font = ThemeFontTipText;
    self.areaLabel.textColor = ThemeColorTextGray;
    
    self.valueLabel.textColor = ThemeColorTextGray;
    
    self.bottomLine.backgroundColor = ThemeColorLine;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setRankInfo:(UserRankModel *)rankInfo {
    _rankInfo = rankInfo;
    
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:self.rankInfo.headImg] placeholderImage:[UIImage imageNamed:@"head_portrait"]];
    self.nameLabel.text = rankInfo.nickName;
    [self setRank];
    
    self.cellStyle = self.cellStyle;
}

- (void)setRank {
    
    self.selfImageView.hidden = YES;
    if ([UserDataManager shareManager].userId && [UserDataManager shareManager].userId.integerValue == self.rankInfo.userId) {
        self.selfImageView.hidden = NO;
    }
    
    self.rankLabel.text = [NSString stringWithFormat:@"%ld",self.rankInfo.ranking];
    self.rankImageView.hidden = NO;
    
    switch (self.rankInfo.ranking) {
        case 1:{
            self.rankImageView.image = [UIImage imageNamed:@"rank_first"];
        }
            break;
            
        case 2:{
            self.rankImageView.image = [UIImage imageNamed:@"rank_second"];
        }
            break;
            
        case 3:{
            self.rankImageView.image = [UIImage imageNamed:@"rank_third"];
        }
            break;
            
        default:{
            self.rankImageView.image = nil;
            self.rankImageView.hidden = YES;
        }
            break;
    }
}

- (void)setCellStyle:(HomeRankCellStyle)cellStyle {
    _cellStyle = cellStyle;
    switch (cellStyle) {
        case HomeRankCellStylePower:{
            self.valueLabel.text = [NSString stringWithFormat:@"%ld",self.rankInfo.power];
        }
            break;
            
        case HomeRankCellStyleLevel:{
            self.valueLabel.text = self.rankInfo.levelName;
        }
            break;
            
        case HomeRankCellStyleInvite:{
            self.valueLabel.text = [NSString stringWithFormat:@"%ld",self.rankInfo.inviteNum];
        }
            break;
            
        default:
            self.valueLabel.text = @"";
            break;
    }
}




@end
