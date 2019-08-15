//
//  AlterNicknameViewController.m
//  xasq
//
//  Created by dssj888@163.com on 2019/7/30.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "AlterNicknameViewController.h"

@interface AlterNicknameViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end

@implementation AlterNicknameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改昵称";
    
    _saveBtn.layer.cornerRadius = 22.5;
    _saveBtn.layer.masksToBounds = YES;
    _nameTF.text = _nickname;
}

- (IBAction)saveBtnClick:(UIButton *)sender {
    if (_nameTF.text.length == 0) {
        [self showMessage:@"请输入昵称"];
        return;
    }
    [self loading];
    NSDictionary *dict = @{@"userId"   : [UserDataManager shareManager].userId,
                           @"nickName" : _nameTF.text
                           };
    [[NetworkManager sharedManager] postRequest:UserSetNickname parameters:dict success:^(NSDictionary * _Nonnull data) {
        [self hideHUD];
        [UserDataManager shareManager].usermodel.nickName = self->_nameTF.text;
        [self showMessage:@"修改成功" complete:^{
            [self.navigationController popViewControllerAnimated:YES];
        }];
    } failure:^(NSError * _Nonnull error) {
        [self hideHUD];
        [self showErrow:error];
    }];
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
