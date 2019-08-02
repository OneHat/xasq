//
//  CapitalKindViewController.m
//  xasq
//
//  Created by dssj on 2019/8/2.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "CapitalKindViewController.h"
#import "CapitalTopView.h"

@interface CapitalKindViewController ()

@end

@implementation CapitalKindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"BTC";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //背景
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    imageView.image = [UIImage imageNamed:@"capital_topBackground"];
    imageView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:imageView];
     
    //资产view
    CapitalTopView *topView = [[CapitalTopView alloc] initWithFrame:CGRectMake(0, NavHeight + 10, ScreenWidth, 20)];
    [self.view addSubview:topView];
    
    ////topView的高度会根据内容自己计算，这里重新赋值高度给外层
    CGFloat topViewH = topView.frame.size.height;
    imageView.frame = CGRectMake(0, 0, ScreenWidth, topViewH + NavHeight + 10);
    
    
//    UIView *introduceView = [[UIView alloc] init];
    
}

@end
