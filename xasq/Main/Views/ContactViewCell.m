//
//  ContactViewCell.m
//  xasq
//
//  Created by dssj on 2019/7/30.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "ContactViewCell.h"

@interface ContactViewCell ()

@property (weak, nonatomic) IBOutlet UIView *colorView;

@end

@implementation ContactViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    NSInteger red = arc4random() % 255;
    NSInteger green = arc4random() % 255;
    NSInteger blue = arc4random() % 255;
    
    UIColor *color = RGBColor(red, green, blue);
    
    self.colorView.backgroundColor = color;
    
    [self.inviteButton setTitleColor:ThemeColorTextGray forState:UIControlStateDisabled];
    [self.inviteButton setTitleColor:ThemeColorBlue forState:UIControlStateSelected];
    
    self.inviteButton.enabled = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
