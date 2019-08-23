//
//  MentionMoneyViewController.m
//  xasq
//
//  Created by dssj888@163.com on 2019/8/5.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "MentionMoneyViewController.h"
#import "MentionMoneyResultViewController.h"
#import "SelectCurrencyViewController.h"
#import "XLPasswordView.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "UIViewController+ActionSheet.h"
#import "PayAndLoginPasswordViewController.h"

@interface MentionMoneyViewController () <XLPasswordViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UILabel *currencyLB; // 币种名称
@property (weak, nonatomic) IBOutlet UIImageView *currencyImageV; // 币种图标
@property (weak, nonatomic) IBOutlet UITextField *amountTF; // 金额
@property (weak, nonatomic) IBOutlet UILabel *amountLB; // 当前币种余额
@property (weak, nonatomic) IBOutlet UILabel *exchangeLB;
@property (weak, nonatomic) IBOutlet UIButton *examineBtn;


@end

@implementation MentionMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提币";
    
    _confirmBtn.layer.cornerRadius = 22.5;
    _confirmBtn.layer.masksToBounds = YES;
    _examineBtn.layer.cornerRadius = 22.5;
    _examineBtn.layer.borderWidth = 1;
    _examineBtn.layer.borderColor = ThemeColorTextGray.CGColor;
    _examineBtn.layer.masksToBounds = YES;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [[IQKeyboardManager sharedManager] setEnable:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [[IQKeyboardManager sharedManager] setEnable:YES];
}
#pragma mark - 全部转入
- (IBAction)allAmountBtnClick:(UIButton *)sender {
    if (![_amountLB.text isEqualToString:@"--"]) {
        _amountTF.text = _amountLB.text;
    }
}

#pragma mark - 选择币种
- (IBAction)selectCurrency:(UIButton *)sender {
    WeakObject;
    SelectCurrencyViewController *VC = [[SelectCurrencyViewController alloc] init];
    VC.currency = _currencyLB.text;
    VC.CapitalModelBlock = ^(CapitalModel * _Nonnull model) {
        weakSelf.currencyLB.text = model.currency;
        weakSelf.amountLB.text = model.amount;
    };
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark - 收款账户
- (IBAction)proceedAccount:(UIButton *)sender {
    [self actionSheetWithItems:@[@"币币账户"] complete:^(NSInteger index) {
        if (index == 0) {
            
        }
    }];
}

- (IBAction)exchangeBtnClick:(UIButton *)sender {
    WeakObject;
    [self actionSheetWithItems:@[@"交易所"] complete:^(NSInteger index) {
        if (index == 0) {
            weakSelf.exchangeLB.text = @"交易所";
        }
    }];
}

- (void)showSetPasswordView {
    [self alertWithTitle:@"提示" message:@"您还未设置支付密码" items:@[@"取消",@"去设置"] action:^(NSInteger index) {
        
        if (index == 0) {
            [self dismissViewControllerAnimated:NO completion:nil];
        } else {
            [self dismissViewControllerAnimated:NO completion:nil];
            PayAndLoginPasswordViewController *VC = [[PayAndLoginPasswordViewController alloc] init];
            VC.type = 1; // 设置支付密码
            [self.navigationController pushViewController:VC animated:YES];
        }
    }];
}

- (IBAction)confirmBtnClick:(UIButton *)sender {
    [self.view endEditing:YES];
    if ([_currencyLB.text isEqualToString:@"币种"]) {
        [self showMessage:@"请选择币种"];
        return;
    } else if (_amountTF.text.length == 0) {
        [self showMessage:@"请选择转账金额"];
        return;
    } else if ([UserDataManager shareManager].usermodel.existFundPassWord == NO) {
        [self showSetPasswordView];
        return;
    }
    [self showSystemKeyboard];
}
#pragma mark - 弹出密码键盘
- (void)showSystemKeyboard
{
    XLPasswordView *passwordView = [XLPasswordView passwordViewWithKeyboardType:XLPasswordViewKeyboardTypeSystem];
    passwordView.delegate = self;
    [passwordView showPasswordInView:self.view];
}

#pragma mark    -   XLPasswordViewDelegate

/**
 *  输入密码位数已满时调用
 */
- (void)passwordView:(XLPasswordView *)passwordView didFinishInput:(NSString *)password
{
    [self loading];
    WeakObject;
    NSDictionary *dict = @{@"amount"         : _amountTF.text,
                           @"currency"       : _currencyLB.text,
                           @"outAccountType" : @"6",
                           @"inAccountType"  : @"13",
                           @"password"       : password,
                           };
    [[NetworkManager sharedManager] postRequest:AcctTransferAccount parameters:dict success:^(NSDictionary * _Nonnull data) {
        [self hideHUD];
        if (data[@"data"][@"success"]) {
            [self showMessage:@"转出成功"];
            weakSelf.amountLB.text = [NSString stringWithFormat:@"%@",data[@"data"][@"balance"]];
        }
        [passwordView hidePasswordView];
    } failure:^(NSError * _Nonnull error) {
        [self hideHUD];
        [self showErrow:error];
        if (error.code == 60206) {
            [passwordView clearPassword];
        }
    }];
}

/**
 *  用户输入密码时调用
 *
 *  @param passwordView 视图
 *  @param password     输入的密码文本
 */
- (void)passwordView:(XLPasswordView *)passwordView passwordTextDidChange:(NSString *)password
{
    NSLog(@"%@",password);
}

/**
 *  点击了忘记密码时调用
 */
- (void)passwordViewClickForgetPassword:(XLPasswordView *)passwordView
{
    PayAndLoginPasswordViewController *VC = [[PayAndLoginPasswordViewController alloc] init];
    VC.type = 1; // 设置支付密码
    [self.navigationController pushViewController:VC animated:YES];
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
