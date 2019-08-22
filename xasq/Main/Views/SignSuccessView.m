//
//  SignSuccessView.m
//  xasq
//
//  Created by dssj on 2019/8/16.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "SignSuccessView.h"

@implementation SignSuccessView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        UIView *successView = [[NSBundle mainBundle] loadNibNamed:@"SignSuccessView" owner:self options:nil].firstObject;
        successView.backgroundColor = [UIColor clearColor];
        successView.frame = frame;
        self = (SignSuccessView *)successView;
    }
    return self;
}

- (IBAction)closeAction:(UIButton *)sender {
    if (self.closeView) {
        self.closeView();
    }
}

@end
