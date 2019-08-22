//
//  SignSuccessView.m
//  xasq
//
//  Created by dssj on 2019/8/16.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "SignSuccessView.h"

@interface SignSuccessView ()

@property (weak, nonatomic) IBOutlet UILabel *signDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *powerLabel;


@end

@implementation SignSuccessView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *successView = [[NSBundle mainBundle] loadNibNamed:@"SignSuccessView" owner:self options:nil].firstObject;
        successView.backgroundColor = [UIColor clearColor];
        successView.frame = frame;
        self = (SignSuccessView *)successView;
    }
    return self;
}

- (IBAction)closeAction:(UIButton *)sender {
    if (self.closeView) {
        self.closeView();
    }
}

- (void)setDay:(NSInteger)day {
    _day = day;
    self.signDayLabel.text = [NSString stringWithFormat:@"连续签到%ld天",_day];
}

-(void)setPower:(NSInteger)power {
    _power = power;
    self.powerLabel.text = [NSString stringWithFormat:@"%ld",_power];
}

@end
