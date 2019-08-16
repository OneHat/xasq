//
//  FriendsRankViewCell.m
//  xasq
//
//  Created by dssj on 2019/8/14.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "FriendsRankViewCell.h"

@interface FriendsRankViewCell ()


@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *powNumberLabel;

@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

@implementation FriendsRankViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.lineView.backgroundColor = ThemeColorLine;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
