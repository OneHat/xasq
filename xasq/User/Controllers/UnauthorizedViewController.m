//
//  UnauthorizedViewController.m
//  xasq
//
//  Created by dssj888@163.com on 2019/8/1.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "UnauthorizedViewController.h"
#import "UIViewController+ActionSheet.h"
#import "CertificateAuthenticationViewController.h"

@interface UnauthorizedViewController ()

@property (weak, nonatomic) IBOutlet UILabel *documentLB;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property (weak, nonatomic) IBOutlet UITextField *accountTF;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeight;
@end

@implementation UnauthorizedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"认证信息"; // 未认证
    
    _nextBtn.layer.cornerRadius = 22.5;
    _nextBtn.layer.masksToBounds = YES;
    
    if (@available(iOS 11.0, *)) {
        self.topHeight.constant = 10;
    } else {
        self.topHeight.constant = NavHeight + 10;
    }
}

- (IBAction)documentTypeClick:(UIButton *)sender {
    WeakObject;
    [self actionSheetWithItems:@[@"身份证", @"驾照", @"护照"] complete:^(NSInteger index) {
        if (index == 0) {
            weakSelf.documentLB.text = @"身份证";
            weakSelf.accountTF.placeholder = @"请输入身份证号";
        } else if (index == 1) {
            weakSelf.documentLB.text = @"驾照";
            weakSelf.accountTF.placeholder = @"请输入驾照号";
        } else {
            weakSelf.documentLB.text = @"护照";
            weakSelf.accountTF.placeholder = @"请输入护照号";
        }
    }];
}


- (IBAction)nextBtnClick:(UIButton *)sender {
    if (_nameTF.text.length == 0) {
        [self showMessage:@"请输入姓名"];
        return;
    } else if (_accountTF.text.length == 0) {
        [self showMessage:@"请输入证件号"];
        return;
    }
    NSInteger type;
    if ([_documentLB.text isEqualToString:@"身份证"]) {
        type = 0;
    } else if ([_documentLB.text isEqualToString:@"护照"]) {
        type = 1;
    } else {
        type = 2;
    }
    CertificateAuthenticationViewController *VC = [[CertificateAuthenticationViewController alloc] init];
    VC.type = type;
    VC.certNo = _accountTF.text;
    VC.certName = _nameTF.text;
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
