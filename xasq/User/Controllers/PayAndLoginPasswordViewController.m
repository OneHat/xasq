//
//  PayPasswordViewController.m
//  xasq
//
//  Created by dssj888@163.com on 2019/8/1.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "PayAndLoginPasswordViewController.h"
#import "UIViewController+ActionSheet.h"
#import "SetReplaceEmailViewController.h"
#import "SetReplacePhoneViewController.h"

@interface PayAndLoginPasswordViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *affirmBtnTop;

@property (weak, nonatomic) IBOutlet UITextField *passwordTF;  // 新密码
@property (weak, nonatomic) IBOutlet UITextField *affirmPasswordTF; // 确认密码
@property (weak, nonatomic) IBOutlet UIView *passwordView;
@property (weak, nonatomic) IBOutlet UILabel *channelLB;
@property (weak, nonatomic) IBOutlet UILabel *typeNameLB; // 手机号或邮箱

@property (weak, nonatomic) IBOutlet UIButton *codeBtn; // 验证码Btn
@property (weak, nonatomic) IBOutlet UITextField *codeTF; // 验证码
@property (weak, nonatomic) IBOutlet UIButton *affirmBtn; // 确认按钮
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, weak) NSTimer *timer;
@end

@implementation PayAndLoginPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        if (_type == 0) {
        self.title = @"修改登录密码";
    } else {
        if ([UserDataManager shareManager].usermodel.existFundPassWord) {
            self.title = @"修改支付密码";
        } else {
            self.title = @"设置支付密码";
        }
        _titleLB.text = @"支付密码为6位数字密码";
        _passwordTF.placeholder = @"请输入支付密码";
        _affirmPasswordTF.placeholder = @"请确认支付密码";
        _passwordTF.keyboardType = UIKeyboardTypeNumberPad;
        _affirmPasswordTF.keyboardType = UIKeyboardTypeNumberPad;
        [_affirmBtn setTitle:@"确认" forState:(UIControlStateNormal)];
    }
    
    _affirmBtn.layer.cornerRadius = 22.5;
    _affirmBtn.layer.masksToBounds = YES;
    self.typeNameLB.text = [UserDataManager shareManager].usermodel.mobile;
}

#pragma mark - 选择渠道
- (IBAction)channelTypeClick:(UIButton *)sender {
    [self actionSheetWithItems:@[@"手机号", @"邮箱"] complete:^(NSInteger index) {
        if (index == 0) {
            self.channelLB.text = @"手机号";
            self.typeNameLB.text = [UserDataManager shareManager].usermodel.mobile;
        } else {
            self.channelLB.text = @"邮箱";
            self.typeNameLB.text = [UserDataManager shareManager].usermodel.email;
        }
    }];
}

#pragma mark - 发送验证码
- (IBAction)codeBtnClick:(UIButton *)sender {
    NSString *urlStr,*nameStr,*nameValue,*templateCode;
    if ([_channelLB.text isEqualToString:@"手机号"]) {
        if ([UserDataManager shareManager].usermodel.mobile.length == 0) {
            [self alertWithTitle:@"温馨提示" message:@"请先绑定手机号" items:@[@"取消", @"去绑定"] action:^(NSInteger index) {
                if (index == 0) {
                    [self dismissViewControllerAnimated:NO completion:nil];
                } else {
                    SetReplacePhoneViewController *VC = [[SetReplacePhoneViewController alloc] init];
                    VC.type = 0; // 绑定手机
                    [self dismissViewControllerAnimated:NO completion:nil];
                    [self.navigationController pushViewController:VC animated:YES];
                }
            }];
            return;
        }
        if ([UserDataManager shareManager].usermodel.existFundPassWord) {
            templateCode = @"user_17";
        } else {
            templateCode = @"user_14";
        }
        urlStr = UserSendMobile;
        nameStr = @"mobile";
        nameValue = [UserDataManager shareManager].usermodel.mobile;
    } else {
        if ([UserDataManager shareManager].usermodel.email.length == 0) {
            [self alertWithTitle:@"温馨提示" message:@"请先绑定邮箱" items:@[@"取消", @"去绑定"] action:^(NSInteger index) {
                if (index == 0) {
                    [self dismissViewControllerAnimated:NO completion:nil];
                } else {
                    SetReplaceEmailViewController *VC = [[SetReplaceEmailViewController alloc] init];
                    VC.type = 0; // 绑定邮箱
                    [self dismissViewControllerAnimated:NO completion:nil];
                    [self.navigationController pushViewController:VC animated:YES];
                }
            }];
            return;
        }
        if ([UserDataManager shareManager].usermodel.existFundPassWord) {
            templateCode = @"user_18";
        } else {
            templateCode = @"user_15";
        }
        urlStr = UserSendEmail;
        nameStr = @"email";
        nameValue = [UserDataManager shareManager].usermodel.email;
    }
    sender.userInteractionEnabled = NO;
    NSDictionary *dict = @{nameStr         : nameValue,
                           @"templateCode" : templateCode,
                           @"areaCode"     : [UserDataManager shareManager].usermodel.areaCode
                           };
    [[NetworkManager sharedManager] postRequest:urlStr parameters:dict success:^(NSDictionary * _Nonnull data) {
        [self showMessage:@"验证码发送成功"];
        self.codeTF.text = @"";
        [self.codeTF becomeFirstResponder];
        if (self.count == 0) {
            //60秒后再次启动
            self.count = 60;
            self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                              target:self
                                                            selector:@selector(showTime)
                                                            userInfo:nil
                                                             repeats:YES];
        }
    } failure:^(NSError * _Nonnull error) {
        [self showErrow:error];
        self.codeBtn.userInteractionEnabled = YES;
    }];
}

- (void)showTime {
    if (_count != 0) {
        _codeBtn.titleLabel.text = [NSString stringWithFormat:@"%ld秒",self.count];
        [_codeBtn setTitle:[NSString stringWithFormat:@"%ld秒",self.count]
                  forState:UIControlStateNormal];
        _count --;
    } else {
        [_codeBtn setTitle:@"获取验证码"
                  forState:UIControlStateNormal];
        _codeBtn.userInteractionEnabled = YES;
        if (_timer) {
            [_timer invalidate];
            _timer = nil;
        }
    }
}
#pragma mark - 确认修改
- (IBAction)affirmBtnClick:(UIButton *)sender {
    if (_type == 0) {
        // 修改登录密码
        if (_passwordTF.text.length == 0) {
            [self showMessage:@"请输入新密码"];
            return;
        } else if (_affirmPasswordTF.text.length == 0) {
            [self showMessage:@"请输入确认密码"];
            return;
        } else if (_passwordTF.text.length < 6) {
            [self showMessage:@"支付密码少于6位数字"];
            return;
        } else if (![_passwordTF.text isEqualToString:_affirmPasswordTF.text]) {
            [self showMessage:@"密码不一致"];
            return;
        }
        [self loading];
        NSString *nameStr;
        if ([_channelLB.text isEqualToString:@"手机号"]) {
            nameStr = @"mobile";
        } else {
            nameStr = @"email";
        }
        NSDictionary *dict = @{@"newPassword"   : [NSString md5:_passwordTF.text],
                               @"validCode"     : _codeTF.text,
                               @"validCodeType" : nameStr,
                               };
        [[NetworkManager sharedManager] postRequest:UserPwdLoginModify parameters:dict success:^(NSDictionary * _Nonnull data) {
            [self hideHUD];
            [self showMessage:@"设置成功" complete:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        } failure:^(NSError * _Nonnull error) {
            [self hideHUD];
            [self showErrow:error];
        }];
    } else {
        // 修改支付密码
        if (_passwordTF.text.length == 0) {
            [self showMessage:@"请输入支付密码"];
            return;
        } else if (_affirmPasswordTF.text.length == 0) {
            [self showMessage:@"请输入确认支付密码"];
            return;
        } else if (_codeTF.text.length == 0) {
            [self showMessage:@"请输入验证码"];
            return;
        } else if (![_passwordTF.text isEqualToString:_affirmPasswordTF.text]) {
            [self showMessage:@"密码不一致"];
            return;
        }
        [self loading];
        NSString *nameStr,*userName;
        if ([_channelLB.text isEqualToString:@"手机号"]) {
            nameStr = @"mobile";
            userName = [UserDataManager shareManager].usermodel.mobile;
        } else {
            nameStr = @"email";
            userName = [UserDataManager shareManager].usermodel.email;
        }
        NSDictionary *dict = @{@"userName"      : userName,
                               @"password"      : [NSString md5:_passwordTF.text],
                               @"validCode"     : _codeTF.text,
                               @"validCodeType" : nameStr,
                               };
        [[NetworkManager sharedManager] postRequest:UserFundpwdSet parameters:dict success:^(NSDictionary * _Nonnull data) {
            [self hideHUD];
            NSString *msg;
            if ([UserDataManager shareManager].usermodel.existFundPassWord) {
                msg = @"修改成功";
            } else {
                msg = @"设置成功";
            }
            [UserDataManager shareManager].usermodel.existFundPassWord = YES;
            [self showMessage:msg complete:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        } failure:^(NSError * _Nonnull error) {
            [self hideHUD];
            [self showErrow:error];
        }];
    }
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
