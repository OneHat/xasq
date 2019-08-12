//
//  RootViewController.m
//  xasq
//
//  Created by dssj on 2019/7/26.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "RootViewController.h"
#import "HomeViewController.h"
#import "TacticsViewController.h"
#import "DiscoveryViewController.h"
#import "CapitalViewController.h"
#import "UserViewController.h"
#import "LoginViewController.h"

@interface RootViewController ()<UITabBarControllerDelegate>

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    //首页
    HomeViewController *homeVC = [[HomeViewController alloc] init];
    UINavigationController *homeNVC = [[UINavigationController alloc] initWithRootViewController:homeVC];
    
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

    self.viewControllers = @[homeNVC,tacticsNVC,discoveryNVC,capitalNVC,userNVC];
    
    NSArray *titles = @[@"首页",@"策略",@"发现",@"资产",@"我的"];
    NSArray *imagesNormal = @[@"Tab_Home_Normal",
                              @"Tab_Tactics_Normal",
                              @"Tab_Discovery_Normal",
                              @"Tab_Capital_Normal",
                              @"Tab_User_Normal"];
    
    NSArray *imagesSelect = @[@"Tab_Home_Select",
                              @"Tab_Tactics_Select",
                              @"Tab_Discovery_Select",
                              @"Tab_Capital_Select",
                              @"Tab_User_Select"];
    
    for (int i = 0;i < self.tabBar.items.count;i++) {
        UITabBarItem *item = self.tabBar.items[i];
        item.title = titles[i];
        
        NSDictionary *attributeNormal = @{NSForegroundColorAttributeName:[UIColor grayColor],NSFontAttributeName:[UIFont systemFontOfSize:10]};
        NSDictionary *attributeSelect = @{NSForegroundColorAttributeName:ThemeColorBlue,NSFontAttributeName:[UIFont systemFontOfSize:10]};
        
        [item setTitleTextAttributes:attributeNormal forState:UIControlStateNormal];
        [item setTitleTextAttributes:attributeSelect forState:UIControlStateSelected];
        
        UIImage *imageNormal = [UIImage imageNamed:imagesNormal[i]];
        UIImage *imageSelect = [UIImage imageNamed:imagesSelect[i]];
        [item setImage:[imageNormal imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [item setSelectedImage:[imageSelect imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    }
    
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    UINavigationController *NVC = (UINavigationController *)viewController;
    UIViewController *selectVC = NVC.topViewController;
    
    if ([selectVC isKindOfClass:[HomeViewController class]]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:DSSJTabBarSelectHome object:nil];
        
    } else if ([selectVC isKindOfClass:[CapitalViewController class]]) {
        if (![UserDataManager shareManager].userId) {
            
            return NO;
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:DSSJTabBarSelectCapital object:nil];
        
    } else if ([selectVC isKindOfClass:[UserViewController class]]) {
        
        NSString *userId = [UserDataManager shareManager].userId;
        if (!userId) {
            LoginViewController *VC = [[LoginViewController alloc] init];
            VC.closeLoginBlock = ^(BOOL isLogin) {
                
                if (!isLogin) {
                    tabBarController.selectedIndex = 0;
                }
            };
            
            VC.hidesBottomBarWhenPushed = YES;
            [NVC pushViewController:VC animated:NO];
            
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:DSSJTabBarSelectUser object:nil];
        }
    }
    
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    
    
}


@end
