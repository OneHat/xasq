//
//  MainViewController.m
//  xasq
//
//  Created by dssj on 2019/7/26.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "MainViewController.h"
#import "InviteUserViewController.h"
#import "DeviceInformation.h"

@interface MainViewController ()
    
@end

@implementation MainViewController
    
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"%@",[DeviceInformation currentInformation].deviceId);
    
}

- (IBAction)inviteAction:(UIButton *)sender {
    
    InviteUserViewController *cc = [[InviteUserViewController alloc] init];
    cc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:cc animated:YES];
    
    
}


@end
