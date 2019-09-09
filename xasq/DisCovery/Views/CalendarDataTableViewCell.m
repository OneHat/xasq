//
//  CalendarDataTableViewCell.m
//  xasq
//
//  Created by dssj888@163.com on 2019/9/9.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "CalendarDataTableViewCell.h"

@interface CalendarDataTableViewCell ()

@property (weak, nonatomic) IBOutlet UIView *releasedView; // 公布view
@property (weak, nonatomic) IBOutlet UIButton *releasedBtn; // 公布Btn
@property (weak, nonatomic) IBOutlet UILabel *timeLB;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UIImageView *countryImageV;
@property (weak, nonatomic) IBOutlet UILabel *preValLB;
@property (weak, nonatomic) IBOutlet UILabel *expectValLB;
@property (weak, nonatomic) IBOutlet UILabel *publishValLB;


@end

@implementation CalendarDataTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _releasedView.layer.cornerRadius = 5;
    _releasedView.layer.borderWidth = 1;
    _releasedView.layer.borderColor = ThemeColorBlue.CGColor;
    _releasedView.layer.masksToBounds = YES;
    _releasedBtn.layer.cornerRadius = 11;
    _releasedBtn.layer.borderWidth = 1;
    _releasedBtn.layer.borderColor = ThemeColorBlue.CGColor;

}

- (void)setDataModel:(CalendarModel *)model {
    _timeLB.text = model.time;
    _titleLB.text = model.title;
    _preValLB.text = [NSString stringWithFormat:@"前值：%@",model.preVal];
    _expectValLB.text = [NSString stringWithFormat:@"预期值：%@",model.expectVal];
    if (model.publishVal.length > 0) {
        _releasedBtn.hidden = YES;
        _releasedView.hidden = NO;
        _publishValLB.text = model.publishVal;
    } else {
        _releasedBtn.hidden = NO;
        _releasedView.hidden = YES;
    }
    [self importantImageV:model.important];
}

- (void)importantImageV:(NSInteger)count {
    for (int i=0; i<5; i++) {
        UIImageView *imageV = [self viewWithTag:60+i];
        if (count >= 3) {
            if (i < count) {
                imageV.image = [UIImage imageNamed:@"discovery_important"];
            } else {
                imageV.image = [UIImage imageNamed:@"discovery_gray"];
            }
            _titleLB.textColor = ThemeColorRed;
            _preValLB.textColor = ThemeColorRed;
            _expectValLB.textColor = ThemeColorRed;
            self.backgroundColor = ThemeColorBackground;
        } else {
            if (i < count) {
                imageV.image = [UIImage imageNamed:@"discovery_usual"];
            } else {
                imageV.image = [UIImage imageNamed:@"discovery_gray"];
            }
            _titleLB.textColor = ThemeColorText;
            _preValLB.textColor = ThemeColorTextGray;
            _expectValLB.textColor = ThemeColorTextGray;
            self.backgroundColor = [UIColor whiteColor];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
