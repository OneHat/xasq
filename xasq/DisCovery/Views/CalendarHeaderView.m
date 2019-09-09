//
//  CalendarHeaderView.m
//  xasq
//
//  Created by dssj888@163.com on 2019/9/9.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "CalendarHeaderView.h"

@interface CalendarHeaderView ()

@property (weak, nonatomic) IBOutlet UIButton *dataBtn; // 数据
@property (weak, nonatomic) IBOutlet UIButton *eventBtn; // 事件
@property (weak, nonatomic) IBOutlet UIButton *holidayBtn; // 假期



@end

@implementation CalendarHeaderView


- (IBAction)eventClickChange:(UIButton *)sender {
    NSInteger type = 0;
    if (sender == _dataBtn) {
        type = 0;
        [_dataBtn setTitleColor:ThemeColorBlue forState:(UIControlStateNormal)];
        [_eventBtn setTitleColor:ThemeColorTextGray forState:(UIControlStateNormal)];
        [_holidayBtn setTitleColor:ThemeColorTextGray forState:(UIControlStateNormal)];
    } else if (sender == _eventBtn) {
        type = 1;
        [_dataBtn setTitleColor:ThemeColorTextGray forState:(UIControlStateNormal)];
        [_eventBtn setTitleColor:ThemeColorBlue forState:(UIControlStateNormal)];
        [_holidayBtn setTitleColor:ThemeColorTextGray forState:(UIControlStateNormal)];
    } else {
        type = 2;
        [_dataBtn setTitleColor:ThemeColorTextGray forState:(UIControlStateNormal)];
        [_eventBtn setTitleColor:ThemeColorTextGray forState:(UIControlStateNormal)];
        [_holidayBtn setTitleColor:ThemeColorBlue forState:(UIControlStateNormal)];
    }
    if (_eventBtnChangeBlock) {
        _eventBtnChangeBlock(type);
    }
}


- (IBAction)dateSelectionClick:(UIButton *)sender {
    // 日期选择
    NSInteger tag = sender.tag - 50;
    for (int i=0; i<7; i++) {
        UIButton *button = [self viewWithTag:50+i];
        UIView *view = [button superview];
        for (UILabel *label in view.subviews) {
            if ([label isKindOfClass:[UILabel class]]) {
                if (tag == i) {
                    label.textColor = [UIColor whiteColor];
                    view.backgroundColor = ThemeColorBlue;
                } else {
                    label.textColor = ThemeColorBlue;
                    view.backgroundColor = HexColor(@"F6F7FB");
                }
            }
        }
    }
    if (_dateBtnChangeBlock) {
        _dateBtnChangeBlock(tag);
    }
}

- (void)setDateSubViews:(NSArray *)array {
    for (int i=0; i<7; i++) {
        UIButton *button = [self viewWithTag:50+i];
        UIView *view = [button superview];
        NSDictionary *dict = array[i];
        for (int y=0; y<view.subviews.count; y++) {
            UILabel *label = view.subviews[y];
            if ([label isKindOfClass:[UILabel class]]) {
                if (y == 1) {
                    label.text = [self dateChangeStr:[NSString stringWithFormat:@"%@",dict[@"week"]]];
                } else if (y == 2) {
                    label.text = [NSString stringWithFormat:@"%@",dict[@"day"]];
                }
            }
        }
    }
}


- (NSString *)dateChangeStr:(NSString *)day {
    if ([day isEqualToString:@"0"]) {
        return @"周日";
    } else if ([day isEqualToString:@"1"]) {
        return @"周一";
    } else if ([day isEqualToString:@"2"]) {
        return @"周二";
    } else if ([day isEqualToString:@"3"]) {
        return @"周三";
    } else if ([day isEqualToString:@"4"]) {
        return @"周四";
    } else if ([day isEqualToString:@"5"]) {
        return @"周五";
    } else if ([day isEqualToString:@"6"]) {
        return @"周六";
    }
    return @"";
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
