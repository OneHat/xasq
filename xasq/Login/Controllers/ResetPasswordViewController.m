//
//  ResetPasswordViewController.m
//  xasq
//
//  Created by dssj888@163.com on 2019/7/31.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "ResetPasswordViewController.h"

@interface ResetPasswordViewController ()

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;  // 新密码
@property (weak, nonatomic) IBOutlet UITextField *affirmPasswordTF; // 确认密码

@end

@implementation ResetPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码"; // 重置密码
    
    _confirmBtn.layer.cornerRadius = 22.5;
    _confirmBtn.layer.masksToBounds = YES;
}

- (IBAction)confirmBtnClick:(UIButton *)sender {
    // 修改支付密码
    if (_passwordTF.text.length == 0) {
        [self showMessage:@"请输入登录密码"];
        return;
    } else if (_affirmPasswordTF.text.length == 0) {
        [self showMessage:@"请输入确认登录密码"];
        return;
    } else if (![_passwordTF.text isEqualToString:_affirmPasswordTF.text]) {
        [self showMessage:@"密码不一致"];
        return;
    }
    [self loading];
    NSString *nameStr;
    if (_type == 0) {
        nameStr = @"mobile";
    } else {
        nameStr = @"email";
    }
    NSDictionary *dict = @{@"userName"      : _account,
                           @"password"      : _passwordTF.text,
                           @"validCode"     : _code,
                           @"validCodeType" : nameStr,
                           @"type"          : @"0"
                           };
    [[NetworkManager sharedManager] postRequest:UserPwdReset parameters:dict success:^(NSDictionary * _Nonnull data) {
        [self hideHUD];
        [self showMessage:@"密码已找回，请使用新密码登录" complete:^{
            NSArray *vcArr = self.navigationController.viewControllers;
            UIViewController *VC = vcArr[vcArr.count - 3];
            [self.navigationController popToViewController:VC animated:YES];
        }];
    } failure:^(NSError * _Nonnull error) {
        [self hideHUD];
        [self showErrow:error];
    }];
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
