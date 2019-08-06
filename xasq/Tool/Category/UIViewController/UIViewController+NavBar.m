//
//  UIViewController+NavBar.m
//  xasq
//
//  Created by dssj888@163.com on 2019/7/29.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "UIViewController+NavBar.h"

@implementation UIViewController (NavBar)

- (void)initLeftBtnWithImage:(UIImage *)image {
    UIImage *leftImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithImage:leftImage
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(leftBtnAction)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
}

- (void)initLeftBtnWithTitle:(NSString *)title color:(UIColor *)color {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:title
                                                                             style:UIBarButtonItemStyleDone
                                                                            target:self
                                                                            action:@selector(leftBtnAction)];
    NSDictionary *selectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                                             NSForegroundColorAttributeName:color};
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:selectedTextAttributes
                                                         forState:UIControlStateNormal];
    [self.navigationItem.leftBarButtonItem setTitleTextAttributes:selectedTextAttributes
                                                         forState:UIControlStateHighlighted];
}

- (void)initRightBtnWithImage:(UIImage *)image {
    UIImage *rightImage = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithImage:rightImage
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(rightBtnAction)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

- (void)initRightBtnWithTitle:(NSString *)title color:(UIColor *)color {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:title
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(rightBtnAction)];
    
    NSDictionary *selectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15],
                                             NSForegroundColorAttributeName:color};
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:selectedTextAttributes
                                                          forState:UIControlStateNormal];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:selectedTextAttributes
                                                          forState:UIControlStateHighlighted];
    
}


#pragma mark - 
- (void)setNavBarTitleColor:(UIColor *)color {
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromColor:HexColor(@"#FFFFFF")]
//                                                  forBarMetrics:UIBarMetricsDefault];  //设置背景
//    self.navigationItem.rightBarButtonItem.tintColor = HexColor(@"#f56600");
//    self.navigationController.navigationBar.tintColor = HexColor(@"#f56600");
//    if (self.navigationController.viewControllers.count > 1) {
//        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"]
//                                                                                 style:UIBarButtonItemStyleDone
//                                                                                target:self
//                                                                                action:@selector(leftBtnAction)];
//        self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
//    }
//    NSDictionary *selectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:20],
//                                             NSForegroundColorAttributeName:HexColor(@"#1B1A1D")};
//    [self.navigationController.navigationBar setTitleTextAttributes:selectedTextAttributes];
    
    
    NSDictionary *textAttributes = @{NSForegroundColorAttributeName:color};
    [self.navigationController.navigationBar setTitleTextAttributes:textAttributes];
}

#pragma mark -
- (void)leftBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBtnAction {
    
}

@end
