//
//  OurVersionViewController.m
//  xasq
//
//  Created by dssj888@163.com on 2019/7/30.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "OurVersionViewController.h"

@interface OurVersionViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageV;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UILabel *nameTapLB;
@property (weak, nonatomic) IBOutlet UILabel *nameBottomLB;
@property (weak, nonatomic) IBOutlet UILabel *conTapLB;
@property (weak, nonatomic) IBOutlet UILabel *conBottomLB;
@property (weak, nonatomic) IBOutlet UILabel *statementLB;


@end

@implementation OurVersionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (_type == 0) {
        self.title = @"版本升级";
        _titleLB.text = [NSString stringWithFormat:@"当前版本V%@",AppVersion];
        _nameTapLB.text = @"检查更新";
        _nameBottomLB.text = @"去评分";
    } else if (_type == 1) {
        self.title = @"关于我们";
        _titleLB.text = @"用科技驱动财富";
        _nameTapLB.text = @"用户协议";
        _nameBottomLB.text = @"隐私政策";
        _statementLB.hidden = NO;
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
