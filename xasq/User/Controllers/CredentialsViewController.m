//
//  CredentialsViewController.m
//  xasq
//
//  Created by dssj888@163.com on 2019/7/29.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "CredentialsViewController.h"
#import "UnauthorizedViewController.h"

@interface CredentialsViewController ()

@property (weak, nonatomic) IBOutlet UIButton *modifyBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLB;    // 证件姓名
@property (weak, nonatomic) IBOutlet UILabel *accountTitleLB; // 证件类型名称
@property (weak, nonatomic) IBOutlet UILabel *accountLB;    // 证件号
@property (weak, nonatomic) IBOutlet UILabel *certificationLB; // 认证状态


@end

@implementation CredentialsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"认证信息"; // 已认证
    
    _modifyBtn.layer.cornerRadius = 22.5;
    _modifyBtn.layer.masksToBounds = YES;
    [self sendUserIdentityDetails];
}

- (void)sendUserIdentityDetails {
    [[NetworkManager sharedManager] getRequest:UserIdentityDetails parameters:nil success:^(NSDictionary * _Nonnull data) {
        if (data) {
            NSDictionary *dic = data[@"data"];
            self.nameLB.text = dic[@"certName"];
            self.accountLB.text = dic[@"certNo"];
            if ([dic[@"status"] integerValue] == 1) {
                self.certificationLB.text = @"已认证";
            } else if ([dic[@"status"] integerValue] == 2){
                self.certificationLB.text = @"审核中";
            } else {
                self.certificationLB.text = @"未认证";
            }
            if ([dic[@"certType"] integerValue] == 1) {
                self.accountTitleLB.text = @"护照证号";
            } else if ([dic[@"certType"] integerValue] == 2){
                self.accountTitleLB.text = @"驾照证号";
            } else {
                self.accountTitleLB.text = @"身份证号";
            }
        }
    } failure:^(NSError * _Nonnull error) {
        [self showErrow:error];
    }];
}

- (IBAction)modifyBtnClick:(UIButton *)sender {
    UnauthorizedViewController *VC = [[UnauthorizedViewController alloc] init];
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
