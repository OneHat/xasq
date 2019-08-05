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
#import "ProceedAccountViewController.h"

@interface MentionMoneyViewController ()

@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

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
    self.navigationController.navigationBar.shadowImage = [UIImage imageFromColor:ThemeColorNavLine];;
}

#pragma mark - 选择币种
- (IBAction)selectCurrency:(UIButton *)sender {
    SelectCurrencyViewController *VC = [[SelectCurrencyViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}
#pragma mark - 收款账户
- (IBAction)proceedAccount:(UIButton *)sender {
    ProceedAccountViewController *VC = [[ProceedAccountViewController alloc] init];
    [self.navigationController pushViewController:VC animated:YES];
}

- (IBAction)confirmBtnClick:(UIButton *)sender {
    
    MentionMoneyResultViewController *VC = [[MentionMoneyResultViewController alloc] init];
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
