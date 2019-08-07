//
//  LanguageSetViewController.m
//  xasq
//
//  Created by dssj888@163.com on 2019/7/30.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "LanguageSetViewController.h"

@interface LanguageSetViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *topSelection;
@property (weak, nonatomic) IBOutlet UIImageView *bottomSelection;
@property (weak, nonatomic) IBOutlet UIButton *chineseBtn;
@property (weak, nonatomic) IBOutlet UIButton *englishBtn;

@end

@implementation LanguageSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"语言设置";
}

- (IBAction)selectionChinese:(UIButton *)sender {
    _topSelection.image = [UIImage imageNamed:@"user_choose"];
    _bottomSelection.image = nil;
}

- (IBAction)SelectionEnglish:(UIButton *)sender {
    _topSelection.image = nil;
    _bottomSelection.image = [UIImage imageNamed:@"user_choose"];
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
