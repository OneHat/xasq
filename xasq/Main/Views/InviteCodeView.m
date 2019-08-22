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
@property (weak, nonatomic) IBOutlet UIButton *beginInviteButton;//开始邀请
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
    self.myCodeTitleLabel.font = ThemeFontMiddleText;
    
    self.myCodeLabel.font = [UIFont systemFontOfSize:26];
    self.myCodeLabel.textColor = ThemeColorBlue;
    
    [self.bindInviteButton setTitleColor:ThemeColorBlue forState:UIControlStateNormal];
    self.bindInviteButton.titleLabel.font = ThemeFontTipText;
    self.bindInviteButton.backgroundColor = HexColor(@"e7e7e7");
    self.bindInviteButton.layer.cornerRadius = CGRectGetHeight(self.bindInviteButton.frame) * 0.5;
    self.bindInviteButton.layer.masksToBounds = YES;
    
    [self.copMyCodeButton setTitleColor:ThemeColorTextGray forState:UIControlStateNormal];
    self.copMyCodeButton.titleLabel.font = ThemeFontTipText;
    self.copMyCodeButton.backgroundColor = HexColor(@"e7e7e7");
    self.copMyCodeButton.layer.cornerRadius = CGRectGetHeight(self.copMyCodeButton.frame) * 0.5;
    self.copMyCodeButton.layer.masksToBounds = YES;
    
    [self.beginInviteButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.beginInviteButton.titleLabel.font = ThemeFontMiddleText;
    self.beginInviteButton.backgroundColor = ThemeColorBlue;
    self.beginInviteButton.layer.cornerRadius = CGRectGetHeight(self.beginInviteButton.frame) * 0.5;
    self.beginInviteButton.layer.masksToBounds = YES;
    
    self.myFriendsLabel.font = ThemeFontText;
    
    self.totalInviteLabel.font = ThemeFontSmallText;
    self.totalInviteLabel.textColor = ThemeColorBlue;
}

- (void)setInviteCode:(NSString *)inviteCode {
    _inviteCode = inviteCode;
    self.myCodeLabel.text = _inviteCode;
}

- (void)setTotalInvite:(NSInteger)totalInvite {
    _totalInvite = totalInvite;
    self.totalInviteLabel.text = [NSString stringWithFormat:@"累计邀请 %ld",_totalInvite];
}

- (IBAction)bindInvite:(UIButton *)sender {
    if (self.buttonClickBlock) {
        self.buttonClickBlock(InviteCodeViewButtonStyleBind);
    }
}

- (IBAction)beginInvite:(UIButton *)sender {
    
}

- (IBAction)copyMyCode:(UIButton *)sender {
    
    if (!self.inviteCode) {
        return;
    }
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.inviteCode;
    
    if (self.buttonClickBlock) {
        self.buttonClickBlock(InviteCodeViewButtonStyleCopy);
    }
}

@end
