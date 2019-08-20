//
//  CommunityDynamicTableViewCell.m
//  xasq
//
//  Created by dssj888@163.com on 2019/8/2.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "CommunityDynamicTableViewCell.h"

@interface CommunityDynamicTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *backgView;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;


@end

@implementation CommunityDynamicTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _backgView.layer.cornerRadius = 2;
    _backgView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setMessageInfo:(NSDictionary *)messageInfo {
    _messageInfo = messageInfo;
    
    self.typeLabel.text = @"社区动态";
    self.timeLabel = messageInfo[@"createdOn"];
    
    self.titleLabel = messageInfo[@"content"][@"title"];
    self.subTitleLabel = messageInfo[@"content"][@"desc"];
    
}

@end
