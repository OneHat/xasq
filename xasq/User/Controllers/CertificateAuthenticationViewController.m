//
//  CertificateAuthenticationViewController.m
//  xasq
//
//  Created by dssj888@163.com on 2019/8/16.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "CertificateAuthenticationViewController.h"

@interface CertificateAuthenticationViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *positiveImageV; // 正面照
@property (weak, nonatomic) IBOutlet UIImageView *positiveCamera; // 正面相机
@property (weak, nonatomic) IBOutlet UILabel *positiveLB;
@property (weak, nonatomic) IBOutlet UIImageView *reverseImageV; // 反面照
@property (weak, nonatomic) IBOutlet UIImageView *reverseCamera; // 反面相机
@property (weak, nonatomic) IBOutlet UILabel *reverseLB;
@property (weak, nonatomic) IBOutlet UIImageView *handheldImageV; // 手持照
@property (weak, nonatomic) IBOutlet UIImageView *handheldCamera; // 手持相机
@property (weak, nonatomic) IBOutlet UILabel *handheldLB;
@property (weak, nonatomic) IBOutlet UIView *reverseView; // 反面背景View
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *reverseTopCT;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *submitTopCT;

@end

@implementation CertificateAuthenticationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_type == 1) {
        self.title = @"驾照认证";
        _positiveLB.text = @"请上传驾照正面";
        _handheldLB.text = @"请上传手持驾照照片";
        _reverseView.hidden = YES;
        _reverseTopCT.constant = 15;
        _submitTopCT.constant = 50;
    } else if (_type == 2) {
        self.title = @"护照认证";
        _positiveLB.text = @"请上传护照正面";
        _handheldLB.text = @"请上传手持护照照片";
        _reverseView.hidden = YES;
        _reverseTopCT.constant = 15;
        _submitTopCT.constant = 50;
    } else {
        self.title = @"身份证认证";
    }
    _submitBtn.layer.cornerRadius = 22.5;
    _submitBtn.layer.masksToBounds = YES;
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
