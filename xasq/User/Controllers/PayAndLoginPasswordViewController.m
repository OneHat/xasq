//
//  PayPasswordViewController.m
//  xasq
//
//  Created by dssj888@163.com on 2019/8/1.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "PayAndLoginPasswordViewController.h"

@interface PayAndLoginPasswordViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UIView *oldView;  // 旧密码背景View
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineViewTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *affirmBtnTop;

@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTF; // 旧密码
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;  // 新密码
@property (weak, nonatomic) IBOutlet UITextField *affirmPasswordTF; // 确认密码
@property (weak, nonatomic) IBOutlet UIView *passwordView;

@property (weak, nonatomic) IBOutlet UIButton *affirmBtn; // 确认按钮
@end

@implementation PayAndLoginPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        if (_type == 0) {
        self.title = @"修改密码";
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
