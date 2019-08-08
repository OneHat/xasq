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
@property (weak, nonatomic) IBOutlet UIButton *codeBtn; // 验证码Btn
@property (weak, nonatomic) IBOutlet UITextField *codeTF; // 验证码
@property (weak, nonatomic) IBOutlet UIButton *affirmBtn; // 确认按钮
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, weak) NSTimer *timer;
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

#pragma mark - 发送验证码
- (IBAction)codeBtnClick:(UIButton *)sender {
    sender.userInteractionEnabled = NO;
    if (_count == 0) {
        //60秒后再次启动
        _count = 60;
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f
                                                  target:self
                                                selector:@selector(showTime)
                                                userInfo:nil
                                                 repeats:YES];
    }
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
