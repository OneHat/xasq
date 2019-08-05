//
//  CapitalTopView.m
//  xasq
//
//  Created by dssj on 2019/8/2.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "CapitalTopView.h"

@interface CapitalTopView ()

@property (nonatomic, strong) UILabel *styleLabel;

@end

@implementation CapitalTopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        [self loadSubViews];
    }
    return self;
}

- (void)loadSubViews {
    //颜色
    UIColor *textOrangeColor = RGBColorA(225, 204, 172, 1);
    UIColor *buttonTitleColor = RGBColorA(36, 69, 102, 1);
    
    CGFloat width = CGRectGetWidth(self.frame);
    
    //背景
    UIImage *bgImage = [UIImage imageNamed:@"capital_RecordBG"];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [bgImage resizeImageInCenter];
    [self addSubview:imageView];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 100, 30)];
    tipLabel.font = ThemeFontText;
    tipLabel.textColor = textOrangeColor;
    _styleLabel = tipLabel;
    [self addSubview:tipLabel];
    
    //
    UIImage *buttonImage = [UIImage imageNamed:@"capital_recordButton"];
    UIButton *recordButton = [[UIButton alloc] initWithFrame:CGRectMake(width - 120, 15, 90, 24)];
    [recordButton setBackgroundImage:[buttonImage resizeImageInCenter] forState:UIControlStateNormal];
    recordButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    [recordButton setTitle:@"收支记录 " forState:UIControlStateNormal];
    [recordButton setTitleColor:buttonTitleColor forState:UIControlStateNormal];
    [recordButton addTarget:self action:@selector(recordClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:recordButton];
    
    //分割线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(30, 10 + CGRectGetMaxY(tipLabel.frame), width - 60, 0.5)];
    lineView.backgroundColor = RGBColorA(38, 116, 2.8, 0.6);
    [self addSubview:lineView];
    
    //资产数值
    UILabel *capitalLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 10 + CGRectGetMaxY(lineView.frame), width, 30)];
    capitalLabel.font = [UIFont boldSystemFontOfSize:30];
    capitalLabel.text = @"0.00TC";
    capitalLabel.textColor = textOrangeColor;
    [self addSubview:capitalLabel];
    
    //换算成美元数值
    UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 5 + CGRectGetMaxY(capitalLabel.frame), width, 30)];
    moneyLabel.font = ThemeFontText;
    moneyLabel.textColor = [UIColor whiteColor];
    moneyLabel.text = @"¥000";
    [self addSubview:moneyLabel];
    
    CGRect rect = self.frame;
    rect.size.height = 5 + CGRectGetMaxY(moneyLabel.frame);
    self.frame = rect;
    
    imageView.frame = CGRectMake(10, 0, width - 20, self.frame.size.height);
}

- (void)setViewStyle:(CapitalTopViewStyle)viewStyle {
    _viewStyle = viewStyle;
    
    if (_viewStyle == CapitalTopViewAll) {
        _styleLabel.text = @"总资产折合";
    } else if (_viewStyle == CapitalTopViewHold) {
        _styleLabel.text = @"持有";
    }
}

#pragma mark -
- (void)recordClick {
    if (_RecordClickBlock) {
        _RecordClickBlock();
    }
}

@end
