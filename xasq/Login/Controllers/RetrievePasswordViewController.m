//
//  RetrievePasswordViewController.m
//  xasq
//
//  Created by dssj888@163.com on 2019/7/31.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "RetrievePasswordViewController.h"
#import "ResetPasswordViewController.h"

@interface RetrievePasswordViewController ()

@property (weak, nonatomic) IBOutlet UITextField *accountTF; // 账号
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn; // 验证码Btn
@property (weak, nonatomic) IBOutlet UITextField *codeTF; // 验证码

@property (nonatomic, assign) NSInteger type;  // 0 手机找回 1邮箱找回
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, weak) NSTimer *timer;
@end

@implementation RetrievePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"找回密码";
    _type = 0;
    [self initRightBtnWithTitle:@"邮箱" color:ThemeColorText];
    
    _nextBtn.layer.cornerRadius = 22.5;
    _nextBtn.layer.masksToBounds = YES;

}

- (void)rightBtnAction {
    _accountTF.text = @"";
    _codeTF.text = @"";
    _count = 0;
    [self showTime];
    if (_type == 0) {
        [self initRightBtnWithTitle:@"手机号" color:ThemeColorText];
        // 邮箱注册
        _type = 1;
        _accountTF.placeholder = @"请输入绑定邮箱地址";
    } else {
        [self initRightBtnWithTitle:@"邮箱" color:ThemeColorText];
        // 手机注册
        _type = 0;
        _accountTF.placeholder = @"请输入绑定手机号";
    }
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


#pragma mark - 下一步
- (IBAction)nextBtnClick:(UIButton *)sender {
    ResetPasswordViewController *VC = [[ResetPasswordViewController alloc] init];
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
