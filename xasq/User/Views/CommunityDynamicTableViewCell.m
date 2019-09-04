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
    
    self.typeLabel.text = messageInfo[@"title"];
    NSDate *time = [NSDate stringTransferToDate:messageInfo[@"createdOn"]];
    BOOL isDay = [NSDate compareDate:time];
    if (isDay) {
        NSString *timeStr = [messageInfo[@"createdOn"] substringWithRange:NSMakeRange(11, 5)];
        self.timeLabel.text = timeStr;
    } else {
        NSString *timeStr = [messageInfo[@"createdOn"] substringWithRange:NSMakeRange(5, 11)];
        self.timeLabel.text = timeStr;
    }
    self.titleLabel.text = messageInfo[@"content"];
}

@end
