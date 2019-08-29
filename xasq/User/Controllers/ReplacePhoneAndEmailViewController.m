//
//  ReplacePhoneAndEmailViewController.m
//  xasq
//
//  Created by dssj888@163.com on 2019/8/15.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "ReplacePhoneAndEmailViewController.h"
#import "MobilePhoneViewController.h"
#import "CountryCodeModel.h"

@interface ReplacePhoneAndEmailViewController ()

@property (weak, nonatomic) IBOutlet UIView *countrieView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineViewTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *accountTFLead; // 账号左约束
@property (weak, nonatomic) IBOutlet UILabel *countriesLB; // 国家
@property (weak, nonatomic) IBOutlet UILabel *areaCodeLB; // 区号
@property (weak, nonatomic) IBOutlet UIView *areaLineView; // 区号竖线
@property (weak, nonatomic) IBOutlet UITextField *accountTF; // 账号
@property (weak, nonatomic) IBOutlet UIButton *phoneCodeBtn; // 手机验证码Btn
@property (weak, nonatomic) IBOutlet UITextField *phoneCodeTF; // 手机验证码
@property (weak, nonatomic) IBOutlet UIButton *emailCodeBtn; // 邮箱验证码Btn
@property (weak, nonatomic) IBOutlet UITextField *emailCodeTF; // 邮箱验证码
@property (nonatomic, strong) NSString *codeStr;  // 手机code
@property (weak, nonatomic) IBOutlet UIButton *replaceBtn;

@property (nonatomic, assign) NSInteger phoneCount;
@property (nonatomic, weak) NSTimer *phoneTimer;
@property (nonatomic, assign) NSInteger emailCount;
@property (nonatomic, weak) NSTimer *emailTimer;

@end

@implementation ReplacePhoneAndEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_type == 0) {
        self.title = @"更换绑定手机";
    } else {
        self.title = @"更换绑定邮箱";
        _lineViewTop.constant = 15;
        _accountTFLead.constant = 20;
        _areaCodeLB.hidden = YES;
        _areaLineView.hidden = YES;
        _accountTF.placeholder = @"请输入新邮箱";
        _phoneCodeTF.placeholder = @"请输入邮箱验证码";
        _emailCodeTF.placeholder = @"请输入短信验证码";
    }
    
    _replaceBtn.layer.cornerRadius = 22.5;
    _replaceBtn.layer.masksToBounds = YES;
}

#pragma mark - 手机区域选择
- (IBAction)countriesClick:(UIButton *)sender {
    MobilePhoneViewController *VC = [[MobilePhoneViewController alloc] init];
    WeakObject;
    VC.countryCodeBlock = ^(CountryCodeModel *model) {
        weakSelf.countriesLB.text = model.name;
        weakSelf.areaCodeLB.text = [NSString stringWithFormat:@"+%@",model.areaCode];
        weakSelf.codeStr = model.code;
    };
    [self.navigationController pushViewController:VC animated:YES];
}

- (IBAction)phoneCodeBtnClick:(UIButton *)sender {
    if (_type == 0) {
        [self sendPhoneVerificationCode];
    } else {
        [self sendEmailVerificationCode];
    }
}

- (IBAction)emailCodeBtnClick:(UIButton *)sender {
    if (_type == 0) {
        [self sendEmailVerificationCode];
    } else {
        [self sendPhoneVerificationCode];
    }
}

- (void)sendPhoneVerificationCode {
    if (_accountTF.text.length == 0 && _type == 0) {
        [self showMessage:@"请输入新手机"];
        return;
    }
    NSString *nameStr,*codeLogo,*areaCode;
    if (_type == 0) {
        nameStr = _accountTF.text;
        codeLogo = @"6";
        areaCode = _areaCodeLB.text;
        [self setBtnStatusType:0 isEnabled:NO];
    } else {
        nameStr = [UserDataManager shareManager].usermodel.mobile;
        codeLogo = @"7";
        areaCode = [UserDataManager shareManager].usermodel.areaCode;
        [self setBtnStatusType:1 isEnabled:NO];
    }
    NSDictionary *dict = @{@"mobile"     : nameStr,
                           @"codeLogo"   : codeLogo,
                           @"areaCode"   : areaCode
                           };
    [[NetworkManager sharedManager] postRequest:UserSendMobile parameters:dict success:^(NSDictionary * _Nonnull data) {
        [self showMessage:@"验证码发送成功"];
        if (self.type == 0) {
            [self phoneCodeBtnClick];
        } else {
            [self emailCodeBtnClick];
        }
    } failure:^(NSError * _Nonnull error) {
        [self showErrow:error];
        if (self.type == 0) {
            [self setBtnStatusType:0 isEnabled:NO];
        } else {
            [self setBtnStatusType:1 isEnabled:NO];
        }
    }];
}

- (void)sendEmailVerificationCode {
    if (_accountTF.text.length == 0 && _type == 1) {
        [self showMessage:@"请输入新邮箱"];
        return;
    }
    NSString *nameStr,*codeLogo;
    if (_type == 0) {
        nameStr = [UserDataManager shareManager].usermodel.email;
        codeLogo = @"6";
        [self setBtnStatusType:1 isEnabled:NO];
    } else {
        nameStr = _accountTF.text;
        codeLogo = @"7";
        [self setBtnStatusType:0 isEnabled:NO];
    }
    NSDictionary *dict = @{@"email"      : nameStr,
                           @"codeLogo"   : codeLogo
                           };
    [[NetworkManager sharedManager] postRequest:UserSendEmail parameters:dict success:^(NSDictionary * _Nonnull data) {
        [self showMessage:@"验证码发送成功"];
        if (self.type == 1) {
            [self phoneCodeBtnClick];
        } else {
            [self emailCodeBtnClick];
        }
    } failure:^(NSError * _Nonnull error) {
        [self showErrow:error];
        if (self.type == 0) {
            [self setBtnStatusType:1 isEnabled:YES];
        } else {
            [self setBtnStatusType:0 isEnabled:YES];
        }
    }];
}

- (void)setBtnStatusType:(NSInteger)type isEnabled:(BOOL)isEnabled {
    if (type == 0) {
        self.phoneCodeBtn.userInteractionEnabled = isEnabled;
    } else {
        self.emailCodeBtn.userInteractionEnabled = isEnabled;
    }
}

- (void)phoneCodeBtnClick {
    if (self.phoneCount == 0) {
        //60秒后再次启动
        self.phoneCount = 60;
        self.phoneTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                               target:self
                                                             selector:@selector(showPhoneTime)
                                                             userInfo:nil
                                                              repeats:YES];
    }
}

- (void)showPhoneTime {
    if (_phoneCount != 0) {
        _phoneCodeBtn.titleLabel.text = [NSString stringWithFormat:@"%ld秒",self.phoneCount];
        [_phoneCodeBtn setTitle:[NSString stringWithFormat:@"%ld秒",self.phoneCount]
                  forState:UIControlStateNormal];
        _phoneCount --;
    }else {
        [_phoneCodeBtn setTitle:@"获取验证码"
                  forState:UIControlStateNormal];
        _phoneCodeBtn.userInteractionEnabled = YES;
        if (_phoneTimer) {
            [_phoneTimer invalidate];
            _phoneTimer = nil;
        }
    }
}

- (void)emailCodeBtnClick {
    if (self.emailCount == 0) {
        //60秒后再次启动
        self.emailCount = 60;
        self.emailTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                               target:self
                                                             selector:@selector(showEmailTime)
                                                             userInfo:nil
                                                              repeats:YES];
    }
}

- (void)showEmailTime {
    if (_emailCount != 0) {
        _emailCodeBtn.titleLabel.text = [NSString stringWithFormat:@"%ld秒",self.emailCount];
        [_emailCodeBtn setTitle:[NSString stringWithFormat:@"%ld秒",self.emailCount]
                  forState:UIControlStateNormal];
        _emailCount --;
    }else {
        [_emailCodeBtn setTitle:@"获取验证码"
                  forState:UIControlStateNormal];
        _emailCodeBtn.userInteractionEnabled = YES;
        if (_emailTimer) {
            [_emailTimer invalidate];
            _emailTimer = nil;
        }
    }
}

#pragma mark - 确认
- (IBAction)replaceBtnClick:(UIButton *)sender {
    if (_accountTF.text.length == 0) {
        [self showMessage:@"请输入新手机号或新邮箱"];
        return;
    } else if (_phoneCodeTF.text.length == 0 || _emailCodeTF.text.length == 0) {
        [self showMessage:@"请输入验证码"];
        return;
    }
    [self loading];
    if (_type == 0) {
        NSDictionary *dict = @{@"email"           : [UserDataManager shareManager].usermodel.email,
                               @"newMobile"       : _accountTF.text,
                               @"mobileValidCode" : _phoneCodeTF.text,
                               @"emailValidCode"  : _emailCodeTF.text
                               };
        [[NetworkManager sharedManager] postRequest:UserMobileRebind parameters:dict success:^(NSDictionary * _Nonnull data) {
            [self hideHUD];
            [UserDataManager shareManager].usermodel.mobile = self.accountTF.text;
            [self showMessage:@"更换新手机成功" complete:^{
                NSArray *vcArr = self.navigationController.viewControllers;
                UIViewController *VC = vcArr[vcArr.count - 3];
                [self.navigationController popToViewController:VC animated:YES];
            }];
        } failure:^(NSError * _Nonnull error) {
            [self hideHUD];
            [self showErrow:error];
            if (error.code == 10152) {
                self.phoneCodeTF.text = @"";
            }
        }];
    } else {
        NSDictionary *dict = @{@"mobile"          : [UserDataManager shareManager].usermodel.mobile,
                               @"newEmail"        : _accountTF.text,
                               @"mobileValidCode" : _emailCodeTF.text,
                               @"emailValidCode"  : _phoneCodeTF.text
                               };
        [[NetworkManager sharedManager] postRequest:UserEmailRebind parameters:dict success:^(NSDictionary * _Nonnull data) {
            [self hideHUD];
            [UserDataManager shareManager].usermodel.email = self.accountTF.text;
            [self showMessage:@"更换新邮箱成功" complete:^{
                NSArray *vcArr = self.navigationController.viewControllers;
                UIViewController *VC = vcArr[vcArr.count - 3];
                [self.navigationController popToViewController:VC animated:YES];
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
