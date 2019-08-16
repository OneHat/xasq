//
//  CapitalListViewCell.m
//  xasq
//
//  Created by dssj on 2019/8/2.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "CapitalListViewCell.h"

@interface CapitalListViewCell ()


@property (weak, nonatomic) IBOutlet UIView *bottomLine;

@end

@implementation CapitalListViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.nameLabel.font = ThemeFontText;
    
    self.numberLabel.font = ThemeFontText;
    self.numberLabel.textColor = ThemeColorText;
    
    self.moneyLabel.font = ThemeFontTipText;
    self.moneyLabel.textColor = ThemeColorTextGray;
    
    self.bottomLine.backgroundColor = ThemeColorLine;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
