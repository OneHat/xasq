//
//  ConfirmViewController.m
//  xasq
//
//  Created by dssj888@163.com on 2019/7/31.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "ConfirmViewController.h"

@interface ConfirmViewController ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeight;

@end

@implementation ConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"联系我们";
    
    self.topHeight.constant = NavHeight + 44;
    if (@available(iOS 11.0, *)) {
        self.topHeight.constant = NavHeight;
    }
    
}

@end
