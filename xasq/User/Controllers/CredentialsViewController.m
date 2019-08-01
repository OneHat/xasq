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


@end

@implementation CredentialsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"认证信息"; // 已认证
    
    _modifyBtn.layer.cornerRadius = 22.5;
    _modifyBtn.layer.masksToBounds = YES;
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
