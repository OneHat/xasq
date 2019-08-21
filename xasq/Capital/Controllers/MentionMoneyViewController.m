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

@interface MentionMoneyViewController () <XLPasswordViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;
@property (weak, nonatomic) IBOutlet UILabel *currencyLB; // 币种名称
@property (weak, nonatomic) IBOutlet UIImageView *currencyImageV; // 币种图标
@property (weak, nonatomic) IBOutlet UITextField *amountTF; // 金额
@property (weak, nonatomic) IBOutlet UILabel *amountLB; // 当前币种余额


@end

@implementation MentionMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提币";
    
    _confirmBtn.layer.cornerRadius = 22.5;
    _confirmBtn.layer.masksToBounds = YES;

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
            
        } else {
            
        }
    }];
//    ProceedAccountViewController *VC = [[ProceedAccountViewController alloc] init];
//    [self.navigationController pushViewController:VC animated:YES];
}

- (IBAction)confirmBtnClick:(UIButton *)sender {
    
//    MentionMoneyResultViewController *VC = [[MentionMoneyResultViewController alloc] init];
//    [self.navigationController pushViewController:VC animated:YES];
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
    NSLog(@"输入密码位数已满,在这里做一些事情,例如自动校验密码");
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
    NSLog(@"点击了忘记密码,在这里做一些事情");
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
