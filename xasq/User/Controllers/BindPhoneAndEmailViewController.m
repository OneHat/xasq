//
//  BindPhoneAndEmailViewController.m
//  xasq
//
//  Created by dssj888@163.com on 2019/8/1.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "BindPhoneAndEmailViewController.h"

@interface BindPhoneAndEmailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UIView *countrieView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineViewTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *accountTFLead; // 账号左约束
@property (weak, nonatomic) IBOutlet UILabel *areaCodeLB; // 区号
@property (weak, nonatomic) IBOutlet UIView *areaLineView; // 区号竖线
@property (weak, nonatomic) IBOutlet UITextField *accountTF; // 账号
@property (weak, nonatomic) IBOutlet UIButton *codeBtn; // 验证码Btn
@property (weak, nonatomic) IBOutlet UITextField *codeTF; // 验证码
@property (weak, nonatomic) IBOutlet UIButton *bindBtn;

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
