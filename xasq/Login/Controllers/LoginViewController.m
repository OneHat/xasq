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

@interface LoginViewController () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *logoImageV;
@property (weak, nonatomic) IBOutlet UITextField *accountTF; // 账号
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *removeBtn; // 清除Btn
@property (weak, nonatomic) IBOutlet UIButton *cipherBtn; // 密文切换Btn


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _loginBtn.layer.cornerRadius = 22.5;
    _loginBtn.layer.masksToBounds = YES;
    [_cipherBtn setImage:[UIImage imageNamed:@"login_eyes_close"] forState:(UIControlStateNormal)];
    [_cipherBtn setImage:[UIImage imageNamed:@"login_eyes_open"] forState:(UIControlStateSelected)];
    _accountTF.text = [UserDataManager shareManager].loginAccount;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.interactivePopGestureRecognizer.delegate = nil;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return NO;
}

- (IBAction)closeClick:(UIButton *)sender {
    [self isLoginSuccessfull:NO];
}

- (void)isLoginSuccessfull:(BOOL)isLogin {
    if (_closeLoginBlock) {
        _closeLoginBlock(isLogin);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)removeBtnClick:(UIButton *)sender {
    _accountTF.text = @"";
}

- (IBAction)CipherSwitch:(UIButton *)sender {
    _cipherBtn.selected = !_cipherBtn.isSelected;
    if (_cipherBtn.isSelected) {
        _passwordTF.secureTextEntry = NO;
    } else {
        _passwordTF.secureTextEntry = YES;
    }
}
#pragma mark - 登录
- (IBAction)loginClick:(UIButton *)sender {
    if (_accountTF.text.length == 0) {
        [self showMessage:@"请输入账号"];
        return;
    } else if (_passwordTF.text.length == 0) {
        [self showMessage:@"请输入密码"];
        return;
    }
    _loginBtn.userInteractionEnabled = NO;
    [self loading];
    WeakObject;
    NSString *URLStr;
    if ([_accountTF.text rangeOfString:@"@"].location != NSNotFound) {
        // 邮箱登录
        URLStr = UserLoginEmail;
    } else {
        // 手机号登录
        URLStr = UserLoginMobile;
    }
    NSDictionary *dict = @{@"loginName"     :   _accountTF.text,
                           @"password"      :   _passwordTF.text,
                           @"loginAddress"  :   @"上海",
                           @"sysVersion"    :   [AppVersion stringByReplacingOccurrencesOfString:@"." withString:@""]
                           };
    [[NetworkManager sharedManager] postRequest:URLStr parameters:dict success:^(NSDictionary * _Nonnull data) {
        weakSelf.loginBtn.userInteractionEnabled = YES;
        [weakSelf hideHUD];
        
        NSDictionary *dataInfo = data[@"data"];
        if (dataInfo && [dataInfo isKindOfClass:[NSDictionary class]]) {
            [UserDataManager shareManager].userId = [NSString stringWithFormat:@"%@",dataInfo[@"userId"]];
            [UserDataManager shareManager].authorization = dataInfo[@"accessToken"];
            [UserDataManager shareManager].loginAccount = weakSelf.accountTF.text;
            [[UserDataManager shareManager] saveUserData:dataInfo];
            
            [self showMessage:@"登录成功" complete:^{
                [self isLoginSuccessfull:YES];
            }];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:DSSJUserLoginSuccessNotification object:nil];
        }
        
    } failure:^(NSError * _Nonnull error) {
        if (error.code == E010130 || error.code == E010141 || error.code == E010145 || error.code == E010142) {
            //验证码
            
        }
        
        weakSelf.loginBtn.userInteractionEnabled = YES;
        [weakSelf hideHUD];
        [self showErrow:error];
    }];
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
