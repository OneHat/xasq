//
//  FriendMainViewController.m
//  xasq
//
//  Created by dssj on 2019/8/16.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "FriendMainViewController.h"

@interface FriendMainViewController ()

@end

@implementation FriendMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //背景
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenWidth)];
    imageView.image = [UIImage imageNamed:@"home_topBackground"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:imageView];
    
}

//- ()

@end
