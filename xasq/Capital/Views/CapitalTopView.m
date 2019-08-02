//
//  CapitalTopView.m
//  xasq
//
//  Created by dssj on 2019/8/2.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "CapitalTopView.h"

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
    CGFloat width = self.frame.size.width;
    
    //背景
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, width - 20, 20)];
    imageView.image = [UIImage imageNamed:@"capital_RecordBG"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:imageView];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 100, 30)];
    tipLabel.font = ThemeFontNormalText;
    tipLabel.text = @"总资产折合";
    [self addSubview:tipLabel];
    
    //
    UIImage *originalImage = [UIImage imageNamed:@"capital_recordButton"];
    UIEdgeInsets insets = UIEdgeInsetsMake(12, 45, 12, 45);
    UIImage *stretchableImage = [originalImage resizableImageWithCapInsets:insets];
    
    UIButton *recordButton = [[UIButton alloc] initWithFrame:CGRectMake(width - 120, 13, 90, 24)];
    [recordButton setBackgroundImage:stretchableImage forState:UIControlStateNormal];
    recordButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    [recordButton setTitle:@"收支记录 " forState:UIControlStateNormal];
    [recordButton setTitleColor:ThemeColorBlue forState:UIControlStateNormal];
    [self addSubview:recordButton];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(30, 5 + CGRectGetMaxY(tipLabel.frame), width - 60, 0.5)];
    lineView.backgroundColor = ThemeColorBlue;
    [self addSubview:lineView];
    
    //资产数值
    UILabel *capitalLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 10 + CGRectGetMaxY(lineView.frame), width, 30)];
    capitalLabel.font = [UIFont boldSystemFontOfSize:30];
    capitalLabel.text = @"0.22342TC";
    [self addSubview:capitalLabel];
    
    //换算成美元数值
    UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 5 + CGRectGetMaxY(capitalLabel.frame), width, 30)];
    moneyLabel.font = ThemeFontNormalText;
    moneyLabel.textColor = [UIColor whiteColor];
    moneyLabel.text = @"¥234324234234";
    [self addSubview:moneyLabel];
    
    CGRect rect = self.frame;
    rect.size.height = 5 + CGRectGetMaxY(moneyLabel.frame);
    self.frame = rect;
    
    imageView.frame = CGRectMake(10, 0, width - 20, self.frame.size.height);
}

@end
