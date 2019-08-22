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
@property (nonatomic, strong) UIButton *eyeButton;

@property (nonatomic, strong) UILabel *capitalLabel;
@property (nonatomic, strong) UILabel *moneyLabel;

@end

NSString *const CapitalChangeHideMoneyStatus = @"DSSJCapitalChangeHideMoneyStatus";

@implementation CapitalTopView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        CGRect rect = self.frame;
        rect.size.height = 140;
        self.frame = rect;
        
        self.clipsToBounds = YES;
        [self loadSubViews];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeHideMony) name:CapitalChangeHideMoneyStatus object:nil];
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
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, width - 20, CGRectGetHeight(self.frame))];
    imageView.image = [bgImage resizeImageInCenter];
    [self addSubview:imageView];
    
    _styleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 100, 30)];
    _styleLabel.font = ThemeFontText;
    _styleLabel.textColor = textOrangeColor;
    [self addSubview:_styleLabel];
    
    UIButton *eyeButton = [[UIButton alloc] initWithFrame:CGRectMake(130, 10, 30, 30)];
//    eyeButton.adjustsImageWhenHighlighted = NO;
    [eyeButton setImage:[UIImage imageNamed:@"capital_eyeOpen"] forState:UIControlStateNormal];
    [eyeButton setImage:[UIImage imageNamed:@"capital_eyeClose"] forState:UIControlStateSelected];
    [eyeButton addTarget:self action:@selector(eyeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    eyeButton.selected = [CapitalDataManager shareManager].hideMoney;
    [self addSubview:eyeButton];
    _eyeButton = eyeButton;
    
    //
    UIImage *buttonImage = [UIImage imageNamed:@"capital_recordButton"];
    UIButton *drawButton = [[UIButton alloc] initWithFrame:CGRectMake(width - 100, 15, 70, 24)];
    [drawButton setBackgroundImage:[buttonImage resizeImageInCenter] forState:UIControlStateNormal];
    drawButton.titleLabel.font = ThemeFontSmallText;
    [drawButton setTitle:@"提币 " forState:UIControlStateNormal];
    [drawButton setTitleColor:buttonTitleColor forState:UIControlStateNormal];
    [drawButton addTarget:self action:@selector(drawClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:drawButton];
    
    //分割线
//    10 + CGRectGetMaxY(tipLabel.frame)
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(30, 50, width - 60, 1)];
    lineView.backgroundColor = HexColor(@"1A5988");
    [self addSubview:lineView];
    
    //资产数值
    UILabel *capitalLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 10 + CGRectGetMaxY(lineView.frame), width, 30)];
    capitalLabel.font = [UIFont boldSystemFontOfSize:30];
    capitalLabel.text = @"0.00TC";
    capitalLabel.textColor = textOrangeColor;
    [self addSubview:capitalLabel];
    _capitalLabel = capitalLabel;
    
    //换算成美元数值
    UILabel *moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 5 + CGRectGetMaxY(capitalLabel.frame), width, 30)];
    moneyLabel.font = [UIFont systemFontOfSize:18];
    moneyLabel.textColor = [UIColor whiteColor];
    moneyLabel.text = @"$000";
    [self addSubview:moneyLabel];
    _moneyLabel = moneyLabel;
    
    [self changeHideMony];
}

- (void)setViewStyle:(CapitalTopViewStyle)viewStyle {
    _viewStyle = viewStyle;
    
    if (_viewStyle == CapitalTopViewAll) {
        _styleLabel.text = @"总资产折合";
    } else if (_viewStyle == CapitalTopViewHold) {
        _styleLabel.text = @"持有";
    }
    
    CGFloat width = [_styleLabel.text getWidthWithFont:_styleLabel.font];
    
    _styleLabel.frame = CGRectMake(30, 10, width, 30);
    _eyeButton.frame = CGRectMake(CGRectGetMaxX(_styleLabel.frame), 10, 30, 30);
}

#pragma mark -
- (void)drawClick {
    if (self.DrawClickBlock) {
        self.DrawClickBlock();
    }
}

- (void)eyeButtonAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    
    [CapitalDataManager shareManager].hideMoney = ![CapitalDataManager shareManager].hideMoney;
    [[NSNotificationCenter defaultCenter] postNotificationName:CapitalChangeHideMoneyStatus object:nil];
}

- (void)setBTCStr:(NSString *)BTCStr {
    _BTCStr = BTCStr;
    [self changeHideMony];
}

- (void)setMoneyStr:(NSString *)moneyStr {
    _moneyStr = moneyStr;
    [self changeHideMony];
}

- (void)changeHideMony {
    
    if ([CapitalDataManager shareManager].hideMoney) {
        _capitalLabel.text = @"***";
        _moneyLabel.text = @"***";
    } else {
        _capitalLabel.text = [NSString stringWithFormat:@"%@",_BTCStr];
        _moneyLabel.text = [NSString stringWithFormat:@"≈ ¥%@",_moneyStr];
    }
    
    _eyeButton.selected = [CapitalDataManager shareManager].hideMoney;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
