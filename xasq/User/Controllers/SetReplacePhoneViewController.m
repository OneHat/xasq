//
//  SetReplacePhoneViewController.m
//  xasq
//
//  Created by dssj888@163.com on 2019/9/3.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "SetReplacePhoneViewController.h"
#import "MobilePhoneViewController.h"
#import "CountryCodeModel.h"

@interface SetReplacePhoneViewController ()

@property (weak, nonatomic) IBOutlet UILabel *detailLB;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewTop;
@property (weak, nonatomic) IBOutlet UILabel *countriesLB; // 国家
@property (weak, nonatomic) IBOutlet UILabel *areaCodeLB; // 区号
@property (weak, nonatomic) IBOutlet UITextField *accountTF; // 手机号
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

@implementation SetReplacePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_type == 0) {
        self.title = @"绑定手机";
    } else {
        self.title = @"更换绑定手机";
        _topViewTop.constant = 10;
        _detailLB.hidden = YES;

    }
    _replaceBtn.layer.cornerRadius = 22.5;
    _replaceBtn.layer.masksToBounds = YES;
    [_emailCodeTF addTarget:self action:@selector(codeTextFeldImport:) forControlEvents:UIControlEventEditingChanged];
    [_phoneCodeTF addTarget:self action:@selector(codeTextFeldImport:) forControlEvents:UIControlEventEditingChanged];
}

- (void)codeTextFeldImport:(UITextField *)textField
{
    if (textField.text.length > 6) {
        textField.text = [textField.text substringToIndex:6];
    }
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
    [self sendPhoneVerificationCode];
}

- (IBAction)emailCodeBtnClick:(UIButton *)sender {
    [self sendEmailVerificationCode];
}

- (void)sendPhoneVerificationCode {
    if (_accountTF.text.length == 0) {
        [self showMessage:@"请输入手机号"];
        return;
    }
    NSString *templateCode;
    if (_type == 0) {
        templateCode = @"user_34";
    } else {
        templateCode = @"user_37";
    }
    NSDictionary *dict = @{@"mobile"         : _accountTF.text,
                           @"templateCode"   : templateCode,
                           @"areaCode"       : _areaCodeLB.text
                           };
    self.phoneCodeBtn.userInteractionEnabled = NO;
    [[NetworkManager sharedManager] postRequest:UserSendMobile parameters:dict success:^(NSDictionary * _Nonnull data) {
        [self showMessage:@"手机验证码发送成功"];
        self.phoneCodeBtn.userInteractionEnabled = YES;
        [self phoneCodeBtnClick];
    } failure:^(NSError * _Nonnull error) {
        [self showErrow:error];
        self.phoneCodeBtn.userInteractionEnabled = YES;
    }];
}

- (void)sendEmailVerificationCode {
    NSString *templateCode;
    if (_type == 0) {
        templateCode = @"user_33";
    } else {
        templateCode = @"user_36";
    }
    NSDictionary *dict = @{
//                           @"email"          : [UserDataManager shareManager].usermodel.email,
                           @"templateCode"   : templateCode
                           };
    self.emailCodeBtn.userInteractionEnabled = NO;
    [[NetworkManager sharedManager] postRequest:UserSendEmail parameters:dict success:^(NSDictionary * _Nonnull data) {
        [self showMessage:@"邮箱验证码发送成功"];
        self.emailCodeBtn.userInteractionEnabled = YES;
        [self emailCodeBtnClick];
    } failure:^(NSError * _Nonnull error) {
        [self showErrow:error];
        self.emailCodeBtn.userInteractionEnabled = YES;
    }];
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
        [self showMessage:@"请输入手机号"];
        return;
    } else if (_phoneCodeTF.text.length == 0 || _emailCodeTF.text.length == 0) {
        [self showMessage:@"请输入验证码"];
        return;
    }
    [self loading];
    if (_type == 0) {
        // 绑定
        NSDictionary *dict = @{@"mobile"            : _accountTF.text,
                               @"email"             : [UserDataManager shareManager].usermodel.email,
                               @"emailValidCode"    : _emailCodeTF.text,
                               @"mobileValidCode"   : _phoneCodeTF.text,
                               };
        [[NetworkManager sharedManager] postRequest:UserMobileBind parameters:dict success:^(NSDictionary * _Nonnull data) {
            [self hideHUD];
            [UserDataManager shareManager].usermodel.mobile = self.accountTF.text;
            [self showMessage:@"绑定成功" complete:^{
                [self.navigationController popViewControllerAnimated:YES];
            }];
        } failure:^(NSError * _Nonnull error) {
            [self hideHUD];
            [self showErrow:error];
        }];
    } else {
        // 更换绑定
        NSDictionary *dict = @{@"newMobile"         : _accountTF.text,
                               @"email"             : [UserDataManager shareManager].usermodel.email,
                               @"emailValidCode"    : _emailCodeTF.text,
                               @"mobileValidCode"   : _phoneCodeTF.text,
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
