//
//  LaunchViewController.m
//  xasq
//
//  Created by dssj on 2019/8/6.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "LaunchViewController.h"

@interface LaunchViewController ()

@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (nonatomic, assign) NSInteger second;

@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _second = 2;
    _secondLabel.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        self.second--;
        self.secondLabel.text = [NSString stringWithFormat:@"%ld",self.second];
        
        if (self.second <= 0) {
            [timer invalidate];
            timer = nil;
            
            [self buttonAction:nil];
        }
        
    }];
}

- (IBAction)buttonAction:(UIButton *)sender {
    if (_DissmissLaunchBlock) {
        _DissmissLaunchBlock();
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

@end
