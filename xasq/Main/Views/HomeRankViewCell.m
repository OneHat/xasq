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

- (void)setRowIndex:(NSInteger)rowIndex {
    _rowIndex = rowIndex;
    
    self.rankLabel.text = [NSString stringWithFormat:@"%ld",rowIndex + 1];
    
    _rankImageView.hidden = NO;
    
    switch (rowIndex) {
        case 0:{
            _rankImageView.image = [UIImage imageNamed:@"rank_first"];
        }
            break;
            
        case 1:{
            _rankImageView.image = [UIImage imageNamed:@"rank_second"];
        }
            break;
            
        case 2:{
            _rankImageView.image = [UIImage imageNamed:@"rank_third"];
        }
            break;
            
        default:{
            _rankImageView.image = nil;
            _rankImageView.hidden = YES;
        }
            break;
    }
}

- (void)setRankInfo:(NSDictionary *)rankInfo {
    _rankInfo = rankInfo;
    
    self.nameLabel.text = rankInfo[@"nickName"];
//    self.areaLabel.text = @"";
    self.cellStyle = self.cellStyle;
    
    self.nameLabel.text = rankInfo[@"nickName"];
}

- (void)setCellStyle:(HomeRankCellStyle)cellStyle {
    _cellStyle = cellStyle;
    switch (cellStyle) {
        case HomeRankCellStylePower:{
            self.valueLabel.text = _rankInfo[@"power"];
        }
            break;
            
        case HomeRankCellStyleLevel:{
            self.valueLabel.text = [NSString stringWithFormat:@"LV%@",_rankInfo[@"userLevel"]];
        }
            break;
            
        case HomeRankCellStyleInvite:{
            self.valueLabel.text = _rankInfo[@"inviteCount"];
        }
            break;
            
        default:
            self.valueLabel.text = @"";
            break;
    }
}


@end
