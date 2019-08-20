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
    
    
    CGFloat rate = 0.333;
    CGFloat totalWidth = CGRectGetWidth(self.middleView.frame);
    
    self.progressViewWidth.constant = totalWidth * rate;
    self.rateViewLeft.constant = totalWidth * rate - 40;
    
    self.nameLabel.text = [UserDataManager shareManager].usermodel.nickName;
    self.levelLabel.text = [UserDataManager shareManager].usermodel.level;
}

@end
