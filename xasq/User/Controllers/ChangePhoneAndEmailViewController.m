//
//  ChangePhoneAndEmailViewController.m
//  xasq
//
//  Created by dssj888@163.com on 2019/8/14.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "ChangePhoneAndEmailViewController.h"
#import "UIViewController+ActionSheet.h"
#import "SetReplacePhoneViewController.h"
#import "SetReplaceEmailViewController.h"

@interface ChangePhoneAndEmailViewController ()


@property (weak, nonatomic) IBOutlet UILabel *titleLB;

@property (weak, nonatomic) IBOutlet UILabel *accountLB;

@property (weak, nonatomic) IBOutlet UIButton *replaceBtn;
@end

@implementation ChangePhoneAndEmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_type == 0) {
        self.title = @"更换绑定手机";
        _titleLB.text = @"已绑定手机";
        _accountLB.text = [UserDataManager shareManager].usermodel.mobile;
        [_replaceBtn setTitle:@"更换绑定手机" forState:(UIControlStateNormal)];
    } else {
        self.title = @"更换绑定邮箱";
        _titleLB.text = @"已绑定邮箱";
        _accountLB.text = [UserDataManager shareManager].usermodel.email;
        [_replaceBtn setTitle:@"更换绑定邮箱" forState:(UIControlStateNormal)];
    }
    _replaceBtn.layer.cornerRadius = 22.5;
    _replaceBtn.layer.masksToBounds = YES;
}

- (IBAction)replaceBtnClick:(UIButton *)sender {
    if (_type == 0) {
        if ([UserDataManager shareManager].usermodel.email.length == 0) {
            [self alertWithTitle:@"温馨提示" message:@"请先绑定邮箱" items:@[@"取消", @"去绑定"] action:^(NSInteger index) {
                if (index == 0) {
                    [self dismissViewControllerAnimated:NO completion:nil];
                } else {
                    SetReplaceEmailViewController *VC = [[SetReplaceEmailViewController alloc] init];
                    VC.type = 0;
                    [self dismissViewControllerAnimated:NO completion:nil];
                    [self.navigationController pushViewController:VC animated:YES];
                }
            }];
            return;
        }
        // 更换绑定手机
        SetReplacePhoneViewController *VC = [[SetReplacePhoneViewController alloc] init];
        VC.type = 1;
        [self.navigationController pushViewController:VC animated:YES];
    } else {
        if ([UserDataManager shareManager].usermodel.mobile.length == 0) {
            [self alertWithTitle:@"温馨提示" message:@"请先绑定手机号" items:@[@"取消", @"去绑定"] action:^(NSInteger index) {
                if (index == 0) {
                    [self dismissViewControllerAnimated:NO completion:nil];
                } else {
                    SetReplacePhoneViewController *VC = [[SetReplacePhoneViewController alloc] init];
                    VC.type = 0;
                    [self dismissViewControllerAnimated:NO completion:nil];
                    [self.navigationController pushViewController:VC animated:YES];
                }
            }];
            return;
        }
        // 更换绑定邮箱
        SetReplaceEmailViewController *VC = [[SetReplaceEmailViewController alloc] init];
        VC.type = 1;
        [self.navigationController pushViewController:VC animated:YES];
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
