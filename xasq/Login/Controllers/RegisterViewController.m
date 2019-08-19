//
//  RegisterViewController.m
//  xasq
//
//  Created by dssj888@163.com on 2019/7/31.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "RegisterViewController.h"
#import "MobilePhoneViewController.h"

@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineViewTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *accountTFLead; // 账号左约束

@property (weak, nonatomic) IBOutlet UILabel *countriesLB; // 国家标题
@property (weak, nonatomic) IBOutlet UILabel *countriesNameLB; // 国家名称
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageV; // 右箭头

@property (weak, nonatomic) IBOutlet UILabel *areaCodeLB; // 区号
@property (weak, nonatomic) IBOutlet UIView *areaLineView; // 区号竖线
@property (weak, nonatomic) IBOutlet UITextField *accountTF; // 账号
@property (weak, nonatomic) IBOutlet UIButton *removeBtn; // 清除Btn
@property (weak, nonatomic) IBOutlet UIButton *codeBtn; // 验证码Btn
@property (weak, nonatomic) IBOutlet UITextField *codeTF; // 验证码
@property (weak, nonatomic) IBOutlet UIButton *cipherBtn; // 密文切换Btn
@property (weak, nonatomic) IBOutlet UITextField *passwordTF; // 密码TF

@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (nonatomic, assign) NSInteger type;  // 0 手机注册 1邮箱注册
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, weak) NSTimer *timer;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    _type = 0;
    [self initRightBtnWithTitle:@"邮箱" color:ThemeColorText];
    
    _registerBtn.layer.cornerRadius = 22.5;
    _registerBtn.layer.masksToBounds = YES;
    
    [_cipherBtn setImage:[UIImage imageNamed:@"login_eyes_close"] forState:(UIControlStateNormal)];
    [_cipherBtn setImage:[UIImage imageNamed:@"login_eyes_open"] forState:(UIControlStateSelected)];
    
}

- (IBAction)loginClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBtnAction {
    _accountTF.text = @"";
    _codeTF.text = @"";
    _passwordTF.text = @"";
    _count = 0;
    [self showTime];
    if (_type == 0) {
        [self initRightBtnWithTitle:@"手机号" color:ThemeColorText];
        // 切换邮箱注册
        _type = 1;
        _countriesLB.hidden = YES;
        _countriesNameLB.hidden = YES;
        _arrowImageV.hidden = YES;
        _areaCodeLB.hidden = YES;
        _areaLineView.hidden = YES;
        _lineViewTop.constant = 0;
        _accountTFLead.constant = 35;
        _viewHeight.constant = 180;
        _accountTF.placeholder = @"请输入邮箱";
    } else {
        [self initRightBtnWithTitle:@"邮箱" color:ThemeColorText];
        // 切换手机注册
        _type = 0;
        _countriesLB.hidden = NO;
        _countriesNameLB.hidden = NO;
        _arrowImageV.hidden = NO;
        _areaCodeLB.hidden = NO;
        _areaLineView.hidden = NO;
        _lineViewTop.constant = 60;
        _accountTFLead.constant = 105;
        _viewHeight.constant = 240;
        _accountTF.placeholder = @"请输入手机号码";
    }
}
#pragma mark - 手机区域选择
- (IBAction)countriesClick:(UIButton *)sender {
    MobilePhoneViewController *VC = [[MobilePhoneViewController alloc] init];
    VC.hidesBottomBarWhenPushed = YES;
    WeakObject;
    VC.countryCodeBlock = ^(NSString * _Nonnull phoneCode, NSString *  _Nonnull name) {
        weakSelf.countriesLB.text = name;
        weakSelf.areaCodeLB.text = [NSString stringWithFormat:@"+%@",phoneCode];
    };
    [self.navigationController pushViewController:VC animated:YES];
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
        urlStr = UserSendMobile;
        nameStr = @"mobile";
    } else {
        urlStr = UserSendEmail;
        nameStr = @"email";
    }
    NSDictionary *dict = @{nameStr : _accountTF.text,
                           @"codeLogo" : @"0"
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

#pragma mark - 注册
- (IBAction)registerBtnClick:(UIButton *)sender {
    if (_accountTF.text.length == 0) {
        if (_type == 0) {
            [self showMessage:@"请输入手机号"];
        } else {
            [self showMessage:@"请输入邮箱账号"];
        }
        return;
    } else if (_codeTF.text.length == 0) {
        [self showMessage:@"请输入验证码"];
        return;
    } else if (_passwordTF.text.length == 0) {
        [self showMessage:@"请输入密码"];
        return;
    }
    WeakObject;
    [self loading];
    _registerBtn.userInteractionEnabled = NO;
    NSString *typeStr;
    if (_type == 0) {
        typeStr = @"mobile";
    } else {
        typeStr = @"email";
    }
    NSDictionary *dict = @{@"userName"      :   _accountTF.text,
                           @"language"      :   @"zh-cn",
                           @"countryCode"   :   _areaCodeLB.text,
                           typeStr          :   _accountTF.text,
                           @"password"      :   _passwordTF.text,
                           @"validCode"     :   _codeTF.text,
                           @"validCodeType" :   typeStr,
                           @"userType"      :   @"0"};
    [[NetworkManager sharedManager] postRequest:UserRegister parameters:dict success:^(NSDictionary * _Nonnull data) {
        [weakSelf hideHUD];
        weakSelf.registerBtn.userInteractionEnabled = YES;
        [self showMessage:@"注册成功" complete:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    } failure:^(NSError * _Nonnull error) {
        [weakSelf hideHUD];
        weakSelf.registerBtn.userInteractionEnabled = YES;
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
