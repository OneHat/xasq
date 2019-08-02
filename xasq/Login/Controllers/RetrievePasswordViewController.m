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

@property (nonatomic, assign) NSInteger type;  // 0 手机找回 1邮箱找回

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
