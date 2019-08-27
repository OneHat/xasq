//
//  RetrievePasswordViewController.m
//  xasq
//
//  Created by dssj888@163.com on 2019/7/31.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "RetrievePasswordViewController.h"
#import "ResetPasswordViewController.h"

@interface RetrievePasswordViewController ()

@property (weak, nonatomic) IBOutlet UITextField *accountTF; // 账号
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn; // 验证码Btn
@property (weak, nonatomic) IBOutlet UITextField *codeTF; // 验证码

@property (nonatomic, assign) NSInteger type;  // 0 手机找回 1邮箱找回
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, weak) NSTimer *timer;
@end

@implementation RetrievePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
    _type = 0;
    [self initRightBtnWithTitle:@"邮箱" color:ThemeColorText];
    
    _nextBtn.layer.cornerRadius = 22.5;
    _nextBtn.layer.masksToBounds = YES;

}

- (void)rightBtnAction {
    _accountTF.text = @"";
    _codeTF.text = @"";
    _count = 0;
    [self showTime];
    if (_type == 0) {
        [self initRightBtnWithTitle:@"手机号" color:ThemeColorText];
        // 邮箱注册
        _type = 1;
        _accountTF.placeholder = @"请输入绑定邮箱地址";
    } else {
        [self initRightBtnWithTitle:@"邮箱" color:ThemeColorText];
        // 手机注册
        _type = 0;
        _accountTF.placeholder = @"请输入绑定手机号";
    }
}

#pragma mark - 发送验证码
- (IBAction)codeBtnClick:(UIButton *)sender {
    if (_accountTF.text.length == 0) {
        if (_type == 0) {
            [self showMessage:@"请输入手机号"];
        } else {
            [self showMessage:@"请输入邮箱账号"];
        }
        return;
    }
    sender.userInteractionEnabled = NO;
    WeakObject;
    NSString *urlStr,*nameStr;
    if (_type == 0) {
        urlStr = UserSendLoginMobile;
        nameStr = @"mobile";
    } else {
        urlStr = UserSendEmail;
        nameStr = @"email";
    }
    NSDictionary *dict = @{nameStr : _accountTF.text,
                           @"codeLogo" : @"10",
                           };
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


#pragma mark - 下一步
- (IBAction)nextBtnClick:(UIButton *)sender {
    if (_codeTF.text.length == 0) {
        [self showMessage:@"请输入手机号或邮箱号"];
        return;
    } else if (_codeTF.text.length == 0) {
        [self showMessage:@"请输入验证码"];
        return;
    }
    [self loading];
    NSString *nameStr;
    if (_type == 0) {
        nameStr = @"mobile";
    } else {
        nameStr = @"email";
    }
    NSDictionary *dict = @{@"loginName"         : _accountTF.text,
                           @"validCode"         : _codeTF.text,
                           @"validCodeType"     : _codeTF.text,
                           @"codeLogo"          : @"2"
                           };
    [[NetworkManager sharedManager] postRequest:UserCheckValidcode parameters:dict success:^(NSDictionary * _Nonnull data) {
        [self hideHUD];
        ResetPasswordViewController *VC = [[ResetPasswordViewController alloc] init];
        VC.account = self->_accountTF.text;
        VC.code = self->_codeTF.text;
        VC.type = self->_type;
        [self.navigationController pushViewController:VC animated:YES];
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
