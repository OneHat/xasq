//
//  BaseViewController.m
//  xasq
//
//  Created by dssj888@163.com on 2019/7/29.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavBarColor];
}

// 进入页面，建议在此处添加
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

// 退出页面，建议在此处添加
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)setNavBarColor {
    [self.navigationController.navigationBar setBackgroundImage:[BaseTool buttonImageFromColor:setColor(@"#FFFFFF")]
                                                  forBarMetrics:UIBarMetricsDefault];  //设置背景
    self.navigationItem.rightBarButtonItem.tintColor = setColor(@"#f56600");
    self.navigationController.navigationBar.tintColor = setColor(@"#f56600");
    if (self.navigationController.viewControllers.count > 1) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"返回"]
                                                                                 style:UIBarButtonItemStyleDone
                                                                                target:self
                                                                                action:@selector(leftBtnAction)];
        self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    }
    NSDictionary *selectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:20],
                                             NSForegroundColorAttributeName:setColor(@"#1B1A1D")};
    [self.navigationController.navigationBar setTitleTextAttributes:selectedTextAttributes];
}

- (void)initLeftBtnWithImage:(UIImage *)image {
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithImage:image
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(leftBtnAction)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    [self.navigationItem.leftBarButtonItem setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
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
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithImage:image
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(rightBtnAction)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    [self.navigationItem.rightBarButtonItem setImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
}

#pragma mark - 设置导航右键
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

#pragma mark - 去掉tableView 多余行线
- (void)setExtraCellLineHidden:(UITableView *)tableView {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

#pragma mark - 导航左方法
- (void)leftBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 导航右方法
- (void)rightBtnAction {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
