//
//  MentionMoneyResultViewController.m
//  xasq
//
//  Created by dssj888@163.com on 2019/8/5.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "MentionMoneyResultViewController.h"

@interface MentionMoneyResultViewController ()

@property (weak, nonatomic) IBOutlet UIButton *examineBtn;

@end

@implementation MentionMoneyResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提币结果";
    
    _examineBtn.layer.cornerRadius = 22.5;
    _examineBtn.layer.borderWidth = 1;
    _examineBtn.layer.borderColor = ThemeColorTextGray.CGColor;
    _examineBtn.layer.masksToBounds = YES;
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
