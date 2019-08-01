//
//  CapitalModuleView.m
//  xasq
//
//  Created by dssj on 2019/8/1.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "CapitalModuleView.h"

@implementation CapitalModuleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"CapitalModuleView" owner:nil options:nil] firstObject];
        
        self.frame = frame;
        
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

@end
