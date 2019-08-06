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

@end

@implementation UnauthorizedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"认证信息"; // 未认证
}

- (IBAction)documentTypeClick:(UIButton *)sender {
    
    [self actionSheetWithItems:@[@"身份证", @"驾照", @"护照"] complete:^(NSInteger index) {
        
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
