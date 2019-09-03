//
//  MinerInfomationView.m
//  xasq
//
//  Created by dssj on 2019/8/6.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "MinerInfomationView.h"

@interface MinerInfomationView ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;


@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet UIView *rightView;
@property (weak, nonatomic) IBOutlet UIView *progressView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *progressViewWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rateViewLeft;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;

@property (weak, nonatomic) IBOutlet UILabel *currentLVLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftLVLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLVLabel;

@end

@implementation MinerInfomationView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UIView *contentView = [[NSBundle mainBundle] loadNibNamed:@"MinerInfomationView" owner:self options:nil].firstObject;
        contentView.backgroundColor = [UIColor clearColor];
        contentView.frame = frame;
        self = (MinerInfomationView *)contentView;
        
        [self setSubView];
    }
    return self;
}

- (void)setSubView {
    self.leftView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
    self.middleView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
    self.rightView.backgroundColor = [UIColor colorWithWhite:1 alpha:0.2];
    self.progressView.backgroundColor = HexColor(@"ae8849");
    
    self.leftLVLabel.backgroundColor = HexColor(@"ae8849");
    self.rightLVLabel.backgroundColor = ThemeColorTextGray;
    
    NSString *imageUrl = [UserDataManager shareManager].usermodel.headImg;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    
    CGFloat rate = 0.0;
    CGFloat totalWidth = CGRectGetWidth(self.middleView.frame);
    
    self.progressViewWidth.constant = totalWidth * rate;
    self.rateViewLeft.constant = totalWidth * rate - 40;
    
    self.nameLabel.text = [UserDataManager shareManager].usermodel.nickName;
}

- (void)setUserInfo:(NSDictionary *)userInfo {
    _userInfo = userInfo;
    
    self.leftLVLabel.text = _userInfo[@"userLevelName"];
    self.rightLVLabel.text = _userInfo[@"upLevelName"];
    self.levelLabel.text = _userInfo[@"userLevelName"];
    NSInteger currentPow = [_userInfo[@"userPower"] integerValue];
    NSInteger nextPow = [_userInfo[@"upPower"] integerValue];
    
    self.rateLabel.text = [NSString stringWithFormat:@"%ld/%ld",currentPow,nextPow];
    
    CGFloat rate = MIN(1.0, currentPow * 1.0 / nextPow);
    CGFloat totalWidth = CGRectGetWidth(self.middleView.frame);
    
    [UIView animateWithDuration:0.5 animations:^{
        self.progressViewWidth.constant = totalWidth * rate;
        self.rateViewLeft.constant = totalWidth * rate - 40;
        [self layoutIfNeeded];
    }];
    
    
    
}

@end
