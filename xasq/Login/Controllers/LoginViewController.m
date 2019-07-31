//
//  LoginViewController.m
//  xasq
//
//  Created by dssj888@163.com on 2019/7/31.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "RetrievePasswordViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *logoImageV;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _loginBtn.layer.cornerRadius = 22.5;
    _loginBtn.layer.masksToBounds = YES;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 设置导航栏背景颜色
//    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
//    //去除导航栏下方的横线
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc]init]
//                                                  forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init]];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (IBAction)closeClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - 忘记密码
- (IBAction)retrievePassword:(UIButton *)sender {
    RetrievePasswordViewController *VC = [[RetrievePasswordViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark - 注册
- (IBAction)registerClick:(UIButton *)sender {
    RegisterViewController *registerVC = [[RegisterViewController alloc] init];
    [self.navigationController pushViewController:registerVC animated:YES];
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
