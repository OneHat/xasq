//
//  BindPhoneAndEmailViewController.m
//  xasq
//
//  Created by dssj888@163.com on 2019/8/1.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "BindPhoneAndEmailViewController.h"
#import "MobilePhoneViewController.h"
#import "CountryCodeModel.h"

@interface BindPhoneAndEmailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UIView *countrieView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineViewTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *accountTFLead; // 账号左约束
@property (weak, nonatomic) IBOutlet UILabel *countriesLB; // 国家
@property (weak, nonatomic) IBOutlet UILabel *areaCodeLB; // 区号
@property (weak, nonatomic) IBOutlet UIView *areaLineView; // 区号竖线
@property (weak, nonatomic) IBOutlet UITextField *accountTF; // 账号
@property (weak, nonatomic) IBOutlet UIButton *codeBtn; // 验证码Btn
@property (weak, nonatomic) IBOutlet UITextField *codeTF; // 验证码
@property (weak, nonatomic) IBOutlet UIButton *bindBtn;
@property (nonatomic, strong) NSString *codeStr;  // 手机code

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, weak) NSTimer *timer;

@end

@implementation BindPhoneAndEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_type == 0) {
        self.title = @"绑定手机号";
    } else {
        self.title = @"绑定邮箱";
        _lineViewTop.constant = 15;
        _accountTFLead.constant = 20;
        _areaCodeLB.hidden = YES;
        _areaLineView.hidden = YES;
        _titleLB.text = @"绑定邮箱后可使用邮箱登录";
        _accountTF.placeholder = @"请输入邮箱账号";
    }
    _bindBtn.layer.cornerRadius = 22.5;
    _bindBtn.layer.masksToBounds = YES;
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

#pragma mark - 发送验证码
- (IBAction)codeBtnClick:(UIButton *)sender {
    if (_accountTF.text.length == 0) {
        [self showMessage:@"请输入绑定账号"];
        return;
    }
    WeakObject;
    NSString *urlStr,*nameStr,*codeLogo;
    if (_type == 0) {
        urlStr = UserSendMobile;
        nameStr = @"mobile";
        codeLogo = @"4";
    } else {
        urlStr = UserSendEmail;
        nameStr = @"email";
        codeLogo = @"5";
    }
    sender.userInteractionEnabled = NO;
    NSDictionary *dict = @{nameStr     : _accountTF.text,
                           @"codeLogo" : codeLogo
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
#pragma mark - 绑定
- (IBAction)bindBtnClick:(UIButton *)sender {
    if (_accountTF.text.length == 0) {
        [self showMessage:@"请输入绑定账号"];
        return;
    } else if (_codeTF.text.length == 0) {
        [self showMessage:@"请输入验证码"];
        return;
    }
    WeakObject;
    NSString *urlStr,*nameStr;
    if (_type == 0) {
        urlStr = UserMobileBind;
        nameStr = @"mobile";
    } else {
        urlStr = UserEmailBind;
        nameStr = @"email";
    }
    [self loading];
    NSDictionary *dict = @{nameStr        : _accountTF.text,
                           @"validCode"   : _codeTF.text,
                           };
    [[NetworkManager sharedManager] postRequest:urlStr parameters:dict success:^(NSDictionary * _Nonnull data) {
        [self hideHUD];
        if (weakSelf.type == 0) {
            [UserDataManager shareManager].usermodel.mobile = weakSelf.accountTF.text;
        } else {
            [UserDataManager shareManager].usermodel.email = weakSelf.accountTF.text;
        }
        [self showMessage:@"绑定成功" complete:^{
            [self.navigationController popViewControllerAnimated:YES];
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
