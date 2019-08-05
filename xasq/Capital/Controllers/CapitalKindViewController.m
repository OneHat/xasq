//
//  CapitalKindViewController.m
//  xasq
//
//  Created by dssj on 2019/8/2.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "CapitalKindViewController.h"
#import "CapitalTopView.h"
#import "CapitalActionModuleView.h"

@interface CapitalKindViewController ()

@end

@implementation CapitalKindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"BTC";
    self.view.backgroundColor = ThemeColorBackground;
    
    //背景
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 20)];
    imageView.image = [UIImage imageNamed:@"capital_topBackground"];
    imageView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:imageView];
     
    //资产view
    CapitalTopView *topView = [[CapitalTopView alloc] initWithFrame:CGRectMake(0, NavHeight + 10, ScreenWidth, 20)];
    topView.viewStyle = CapitalTopViewHold;
    [self.view addSubview:topView];
    
    ////topView的高度会根据内容自己计算，这里重新赋值高度给外层
    CGFloat imageViewH = topView.frame.size.height + NavHeight + 10;
    imageView.frame = CGRectMake(0, 0, ScreenWidth, imageViewH);
    
    
    CapitalActionModuleView *modulView = [[CapitalActionModuleView alloc] initWithFrame:CGRectMake(0, imageViewH, ScreenWidth, 10)];
    modulView.ButtonClickBlock = ^(NSInteger index) {
        
    };
    [self.view addSubview:modulView];
    
    UIScrollView *introduceView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(modulView.frame) + 10, ScreenWidth, ScreenHeight - CGRectGetMaxY(modulView.frame) - 10)];
    introduceView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:introduceView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, ScreenWidth - 20, 30)];
    titleLabel.text = @"简介";
    titleLabel.font = [UIFont boldSystemFontOfSize:26];
    [introduceView addSubview:titleLabel];
    
    NSString *content = @"比特币（Bitcoin）的概念最初由中本聪在2008年11月1日提出，并于2009年1月3日正式诞生。根据中本聪的思路设计发布的开源软件以及建构其上的P2P网络。比特币是一种P2P形式的虚拟的加密数字货币。点对点的传输意味着一个去中心化的支付系统。";
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 1.1;//设置行间距
    paragraphStyle.lineHeightMultiple = 1.5;
    
    NSDictionary *attributes = @{NSFontAttributeName:ThemeFontText,NSParagraphStyleAttributeName:paragraphStyle};
    NSAttributedString *attributesString = [[NSAttributedString alloc] initWithString:content attributes:attributes];
    
    CGSize size = [content boundingRectWithSize:CGSizeMake(ScreenWidth-10, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 50,  ScreenWidth-20, ceil(size.height))];
    contentLabel.numberOfLines = 0;
    contentLabel.font = ThemeFontText;
    contentLabel.attributedText = attributesString;
    [introduceView addSubview:contentLabel];
    
    introduceView.contentSize = CGSizeMake(0,ceil(size.height) + 60);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self initLeftBtnWithImage:[UIImage imageNamed:@"leftBar_back_white"]];
}

@end
