//
//  HomeNewsViewCell.m
//  xasq
//
//  Created by dssj on 2019/8/1.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "HomeNewsViewCell.h"

@interface HomeNewsViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation HomeNewsViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setNewsModel:(UserNewsModel *)newsModel {
    _newsModel = newsModel;
    
    self.contentLabel.text = [NSString stringWithFormat:@"%@   %@ %@",newsModel.userName,newsModel.quantity,newsModel.currencyCode];
    self.timeLabel.text = newsModel.showTime;
}

@end
