//
//  RootViewController.m
//  xasq
//
//  Created by dssj on 2019/7/26.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "RootViewController.h"
#import "MainViewController.h"
#import "TacticsViewController.h"
#import "UserViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MainViewController *mainVC = [[MainViewController alloc] init];
    
    TacticsViewController *tacticsVC = [[TacticsViewController alloc] init];
    UINavigationController *tacticsNVC = [[UINavigationController alloc] initWithRootViewController:tacticsVC];
    
    UserViewController *userVC = [[UserViewController alloc] init];
    UINavigationController *userNVC = [[UINavigationController alloc] initWithRootViewController:userVC];

    self.viewControllers = @[mainVC,tacticsNVC,userNVC];
    
    NSArray *titles = @[@"首页",@"策略",@"我的"];
    for (int i = 0;i < self.tabBar.items.count;i++) {
        UITabBarItem *item = self.tabBar.items[i];
        item.title = titles[i];
    }
    
}

@end
