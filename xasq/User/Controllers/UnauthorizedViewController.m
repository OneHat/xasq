//
//  UnauthorizedViewController.m
//  xasq
//
//  Created by dssj888@163.com on 2019/8/1.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "UnauthorizedViewController.h"
#import "UIViewController+ActionSheet.h"

@interface UnauthorizedViewController ()

@property (weak, nonatomic) IBOutlet UILabel *documentLB;

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@end

@implementation UnauthorizedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"认证信息"; // 未认证
    
    _nextBtn.layer.cornerRadius = 22.5;
    _nextBtn.layer.masksToBounds = YES;
}

- (IBAction)documentTypeClick:(UIButton *)sender {
    WeakObject;
    [self actionSheetWithItems:@[@"身份证", @"驾照", @"护照"] complete:^(NSInteger index) {
        if (index == 0) {
            weakSelf.documentLB.text = @"身份证";
        } else if (index == 1) {
            weakSelf.documentLB.text = @"驾照";
        } else {
            weakSelf.documentLB.text = @"护照";
        }
    }];

}


- (IBAction)nextBtnClick:(UIButton *)sender {
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
