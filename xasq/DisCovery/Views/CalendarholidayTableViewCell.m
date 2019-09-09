//
//  CalendarholidayTableViewCell.m
//  xasq
//
//  Created by dssj888@163.com on 2019/9/9.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "CalendarholidayTableViewCell.h"

@interface CalendarholidayTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *holidayLB;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UIImageView *countryImageV;

@end

@implementation CalendarholidayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDataModel:(CalendarModel *)model {
    _holidayLB.text = [NSString stringWithFormat:@"%@/%@",model.country,model.holidayName];
    _titleLB.text = model.title;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
