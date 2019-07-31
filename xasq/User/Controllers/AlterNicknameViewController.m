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
