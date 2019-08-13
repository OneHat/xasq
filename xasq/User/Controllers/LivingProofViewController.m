//
//  LivingProofViewController.m
//  xasq
//
//  Created by dssj888@163.com on 2019/7/30.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "LivingProofViewController.h"
#import "AlterNicknameViewController.h"
#import "UIViewController+ActionSheet.h"

@interface LivingProofViewController ()



@end

@implementation LivingProofViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户信息";
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}


- (IBAction)alterHeadPortraitClick:(UIButton *)sender {
    
    [self actionSheetWithItems:@[@"拍摄", @"从手机相册选择"] complete:^(NSInteger index) {
        
    }];
}

- (IBAction)nickNameClick:(UIButton *)sender {
    
    AlterNicknameViewController *VC = [[AlterNicknameViewController alloc] init];
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
