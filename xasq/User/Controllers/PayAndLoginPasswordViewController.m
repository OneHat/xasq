//
//  PayPasswordViewController.m
//  xasq
//
//  Created by dssj888@163.com on 2019/8/1.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "PayAndLoginPasswordViewController.h"
#import "UIViewController+ActionSheet.h"

@interface PayAndLoginPasswordViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UIView *oldView;  // 旧密码背景View
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineViewTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *affirmBtnTop;

@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTF; // 旧密码
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;  // 新密码
@property (weak, nonatomic) IBOutlet UITextField *affirmPasswordTF; // 确认密码
@property (weak, nonatomic) IBOutlet UIView *passwordView;
@property (weak, nonatomic) IBOutlet UILabel *channelLB;
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
            _affirmBtnTop.constant = 50;
    } else {
        self.title = @"设置支付密码";
        _titleLB.text = @"支付密码为6位数字密码";
        _oldView.hidden = YES;
        _passwordView.hidden = NO;
        _lineViewTop.constant = 15;
        _affirmBtnTop.constant = 180;
        _passwordTF.placeholder = @"请输入支付密码";
        _affirmPasswordTF.placeholder = @"请确认支付密码";
        [_affirmBtn setTitle:@"确认" forState:(UIControlStateNormal)];
    }
    
    _affirmBtn.layer.cornerRadius = 22.5;
    _affirmBtn.layer.masksToBounds = YES;
}

#pragma mark - 选择渠道
- (IBAction)channelTypeClick:(UIButton *)sender {
    WeakObject;
    [self actionSheetWithItems:@[@"手机号", @"邮箱"] complete:^(NSInteger index) {
        if (index == 0) {
            weakSelf.channelLB.text = @"手机号";
        } else {
            weakSelf.channelLB.text = @"邮箱";
        }
    }];
}

#pragma mark - 发送验证码
- (IBAction)codeBtnClick:(UIButton *)sender {
    NSString *urlStr,*nameStr;
    if ([_channelLB.text isEqualToString:@"手机号"]) {
        if ([UserDataManager shareManager].usermodel.mobile.length == 0) {
            [self showMessage:@"请先绑定手机号"];
            return;
        }
        urlStr = UserSendMobile;
        nameStr = @"mobile";
    } else {
        if ([UserDataManager shareManager].usermodel.email.length == 0) {
            [self showMessage:@"请先绑定邮箱"];
            return;
        }
        urlStr = UserSendEmail;
        nameStr = @"email";
    }
    sender.userInteractionEnabled = NO;
    WeakObject;
    NSDictionary *dict = @{nameStr : _codeTF.text};
    [[NetworkManager sharedManager] postRequest:urlStr parameters:dict success:^(NSDictionary * _Nonnull data) {
        [self showMessage:@"验证码发送成功"];
        if (weakSelf.count == 0) {
            //60秒后再次启动
            weakSelf.count = 60;
            weakSelf.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                              target:self
                                                            selector:@selector(showTime)
                                                            userInfo:nil
                                                             repeats:YES];
        }
    } failure:^(NSError * _Nonnull error) {
        [self showErrow:error];
        weakSelf.codeBtn.userInteractionEnabled = YES;
    }];
}

- (void)showTime {
    if (_count != 0) {
        _codeBtn.titleLabel.text = [NSString stringWithFormat:@"%ld秒",self.count];
        [_codeBtn setTitle:[NSString stringWithFormat:@"%ld秒",self.count]
                  forState:UIControlStateNormal];
        _count --;
    }else {
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
        if (_oldPasswordTF.text.length == 0) {
            [self showMessage:@"请输入旧密码"];
            return;
        } else if (_passwordTF.text.length == 0) {
            [self showMessage:@"请输入新密码"];
            return;
        } else if (_affirmPasswordTF.text.length == 0) {
            [self showMessage:@"请输入确认密码"];
            return;
        } else if (![_passwordTF.text isEqualToString:_affirmPasswordTF.text]) {
            [self showMessage:@"密码不一致"];
            return;
        }
        [self loading];
        NSDictionary *dict = @{@"userName"   : [UserDataManager shareManager].usermodel.userName,
                               @"oldPassword" : _oldPasswordTF.text,
                               @"newPassword" : _passwordTF.text,
                               @"type"        : @"0"
                               };
        [[NetworkManager sharedManager] postRequest:UserPwdLoginModify parameters:dict success:^(NSDictionary * _Nonnull data) {
            [self hideHUD];
            [self showMessage:@"修改成功" complete:^{
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
        NSString *nameStr;
        if ([_channelLB.text isEqualToString:@"手机号"]) {
            nameStr = @"mobile";
        } else {
            nameStr = @"email";
        }
        NSDictionary *dict = @{@"userName"     : [UserDataManager shareManager].usermodel.userName,
                               @"newPassword"   : _passwordTF.text,
                               @"validCode"     : _codeTF.text,
                               @"validCodeType" : nameStr,
                               @"type"          : @"1"
                               };
        [[NetworkManager sharedManager] postRequest:UserPwdLoginModify parameters:dict success:^(NSDictionary * _Nonnull data) {
            [self hideHUD];
            [self showMessage:@"修改成功" complete:^{
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
