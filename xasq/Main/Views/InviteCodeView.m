//
//  InviteCodeView.m
//  xasq
//
//  Created by dssj on 2019/8/6.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "InviteCodeView.h"

@interface InviteCodeView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *bindInviteButton;//绑定邀请
@property (weak, nonatomic) IBOutlet UILabel *myCodeTitleLabel;//
@property (weak, nonatomic) IBOutlet UILabel *myCodeLabel;//邀请码
@property (weak, nonatomic) IBOutlet UIButton *copMyCodeButton;//复制
@property (weak, nonatomic) IBOutlet UIButton *makeMyCardButton;//生成邀请卡
@property (weak, nonatomic) IBOutlet UILabel *myFriendsLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalInviteLabel;//共邀请

@end

@implementation InviteCodeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *contentView = [[NSBundle mainBundle] loadNibNamed:@"InviteCodeView" owner:self options:nil].firstObject;
        contentView.frame = frame;
        self = (InviteCodeView *)contentView;
        
        [self setSubView];
    }
    return self;
}

- (void)setSubView {
    self.titleLabel.font = ThemeFontText;
    self.myCodeTitleLabel.font = ThemeFontSmallText;
    
    self.myCodeLabel.font = [UIFont systemFontOfSize:20];
    self.myCodeLabel.textColor = ThemeColorBlue;
    
    [self.bindInviteButton setTitleColor:ThemeColorBlue forState:UIControlStateNormal];
    self.bindInviteButton.titleLabel.font = [UIFont systemFontOfSize:10];
    self.bindInviteButton.backgroundColor = ThemeColorBackground;
    self.bindInviteButton.layer.cornerRadius = CGRectGetHeight(self.bindInviteButton.frame) * 0.5;
    self.bindInviteButton.layer.masksToBounds = YES;
    
    [self.copMyCodeButton setTitleColor:ThemeColorTextGray forState:UIControlStateNormal];
    self.copMyCodeButton.titleLabel.font = [UIFont systemFontOfSize:10];
    self.copMyCodeButton.backgroundColor = ThemeColorBackground;
    self.copMyCodeButton.layer.cornerRadius = CGRectGetHeight(self.copMyCodeButton.frame) * 0.5;
    self.copMyCodeButton.layer.masksToBounds = YES;
    
    [self.makeMyCardButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.makeMyCardButton.titleLabel.font = ThemeFontMiddleText;
    self.makeMyCardButton.backgroundColor = ThemeColorBlue;
    self.makeMyCardButton.layer.cornerRadius = CGRectGetHeight(self.makeMyCardButton.frame) * 0.5;
    self.makeMyCardButton.layer.masksToBounds = YES;
    
    self.myFriendsLabel.font = ThemeFontText;
    
    self.totalInviteLabel.font = ThemeFontSmallText;
    self.totalInviteLabel.textColor = ThemeColorBlue;
}

- (IBAction)bindInvite:(UIButton *)sender {
    if (self.buttonClickBlock) {
        self.buttonClickBlock(InviteCodeViewButtonStyleBind);
    }
}

- (IBAction)makeMyCard:(UIButton *)sender {
}

- (IBAction)copyMyCode:(UIButton *)sender {
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = @"666888";
    
    if (self.buttonClickBlock) {
        self.buttonClickBlock(InviteCodeViewButtonStyleCopy);
    }
}

@end
