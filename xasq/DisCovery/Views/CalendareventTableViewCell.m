//
//  CalendareventTableViewCell.m
//  xasq
//
//  Created by dssj888@163.com on 2019/9/9.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "CalendareventTableViewCell.h"

@interface CalendareventTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *timeLB;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UIImageView *countryImageV;

@end

@implementation CalendareventTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setDataModel:(CalendarModel *)model {
    _timeLB.text = model.time;
    _titleLB.text = model.title;

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
            self.backgroundColor = ThemeColorBackground;
        } else {
            if (i < count) {
                imageV.image = [UIImage imageNamed:@"discovery_usual"];
            } else {
                imageV.image = [UIImage imageNamed:@"discovery_gray"];
            }
            self.backgroundColor = [UIColor whiteColor];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
