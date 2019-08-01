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

@property (weak, nonatomic) IBOutlet UIButton *bindBtn;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
