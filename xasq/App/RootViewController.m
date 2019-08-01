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
#import "DiscoveryViewController.h"
#import "CapitalViewController.h"
#import "UserViewController.h"

@interface RootViewController ()<UITabBarControllerDelegate>

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    //首页
    MainViewController *mainVC = [[MainViewController alloc] init];
    UINavigationController *mainNVC = [[UINavigationController alloc] initWithRootViewController:mainVC];
    
    //策略
    TacticsViewController *tacticsVC = [[TacticsViewController alloc] init];
    UINavigationController *tacticsNVC = [[UINavigationController alloc] initWithRootViewController:tacticsVC];
    
    //发现
    DiscoveryViewController *discoveryVC = [[DiscoveryViewController alloc] init];
    UINavigationController *discoveryNVC = [[UINavigationController alloc] initWithRootViewController:discoveryVC];
    
    //资产
    CapitalViewController *capitalVC = [[CapitalViewController alloc] init];
    UINavigationController *capitalNVC = [[UINavigationController alloc] initWithRootViewController:capitalVC];
    
    //我的
    UserViewController *userVC = [[UserViewController alloc] init];
    UINavigationController *userNVC = [[UINavigationController alloc] initWithRootViewController:userVC];
    userNVC.navigationBar.barTintColor = [UIColor whiteColor];

    self.viewControllers = @[mainNVC,tacticsNVC,discoveryNVC,capitalNVC,userNVC];
    
    NSArray *titles = @[@"首页",@"策略",@"发现",@"资产",@"我的"];
    for (int i = 0;i < self.tabBar.items.count;i++) {
        UITabBarItem *item = self.tabBar.items[i];
        item.title = titles[i];
    }
    
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    return YES;
}


@end
