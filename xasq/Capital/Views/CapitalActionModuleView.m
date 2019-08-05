//
//  CapitalActionModuleView.m
//  xasq
//
//  Created by dssj on 2019/8/5.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "CapitalActionModuleView.h"

@implementation CapitalActionModuleView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        [self loadSubViews];
    }
    return self;
}

- (void)loadSubViews {
    CGFloat buttonW = 60;
    CGFloat width = self.frame.size.width;
    if (width > 320.0) {
        buttonW = 80;
    }
    
    CGFloat margin = ceil((width - 4 * buttonW) / 5.0);
    
    NSArray *titles = @[@"充币",@"提币",@"资金划转",@"扫一扫"];
    NSArray *images = @[@"Capital_DrawMoney",@"Capital_DrawMoney",@"Capital_DrawMoney",@"Capital_DrawMoney"];
    
    for (int i = 0; i < 4; i++) {
        
        UIButton *actionButton = [[UIButton alloc] initWithFrame:CGRectMake((margin + buttonW) * i + margin, 10, buttonW, buttonW)];
        actionButton.tag = i;
        actionButton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
        [actionButton setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [self addSubview:actionButton];
        [actionButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake((margin + buttonW) * i + margin, CGRectGetMaxY(actionButton.frame), buttonW, 30)];
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.font = ThemeFontMiddleText;
        tipLabel.text = titles[i];
        [self addSubview:tipLabel];
    }
    
    CGRect rect = self.frame;
    rect.size.height = buttonW + 10 * 2 + 30;
    self.frame = rect;
    
}

- (void)buttonAction:(UIButton *)sender {
    if (_ButtonClickBlock) {
        _ButtonClickBlock(sender.tag);
    }
}


@end
