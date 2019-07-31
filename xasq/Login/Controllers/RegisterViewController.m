//
//  RegisterViewController.m
//  xasq
//
//  Created by dssj888@163.com on 2019/7/31.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineViewTop;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *accountTFLead; // 账号左约束

@property (weak, nonatomic) IBOutlet UILabel *countriesLB; // 国家标题
@property (weak, nonatomic) IBOutlet UILabel *countriesNameLB; // 国家名称
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageV; // 右箭头

@property (weak, nonatomic) IBOutlet UILabel *areaCodeLB; // 区号
@property (weak, nonatomic) IBOutlet UIView *areaLineView; // 区号竖线
@property (weak, nonatomic) IBOutlet UITextField *accountTF; // 账号

@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (nonatomic, assign) NSInteger type;  // 0 手机注册 1邮箱注册


@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    _type = 0;
    [self initRightBtnWithTitle:@"邮箱" color:ThemeColorTitle];
    
    _registerBtn.layer.cornerRadius = 22.5;
    _registerBtn.layer.masksToBounds = YES;
    
    NSString *titleStr = @"已有账号？立即登录";
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:titleStr];
    [attributeStr addAttribute:NSForegroundColorAttributeName value:ThemeColorBlue range:NSMakeRange(5, titleStr.length - 5)];
    self.loginBtn.titleLabel.attributedText = attributeStr;
}

- (IBAction)loginClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightBtnAction {
    if (_type == 0) {
        [self initRightBtnWithTitle:@"手机号" color:ThemeColorTitle];
        // 邮箱注册
        _type = 1;
        _countriesLB.hidden = YES;
        _countriesNameLB.hidden = YES;
        _arrowImageV.hidden = YES;
        _areaCodeLB.hidden = YES;
        _areaLineView.hidden = YES;
        _lineViewTop.constant = 0;
        _accountTFLead.constant = 35;
        _viewHeight.constant = 180;
        _accountTF.placeholder = @"请输入邮箱";
    } else {
        [self initRightBtnWithTitle:@"邮箱" color:ThemeColorTitle];
        // 手机注册
        _type = 0;
        _countriesLB.hidden = NO;
        _countriesNameLB.hidden = NO;
        _arrowImageV.hidden = NO;
        _areaCodeLB.hidden = NO;
        _areaLineView.hidden = NO;
        _lineViewTop.constant = 60;
        _accountTFLead.constant = 105;
        _viewHeight.constant = 240;
        _accountTF.placeholder = @"请输入手机号码";
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
