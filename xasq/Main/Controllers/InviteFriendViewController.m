//
//  InviteFriendViewController.m
//  xasq
//
//  Created by dssj on 2019/8/16.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "InviteFriendViewController.h"

@interface InviteFriendViewController ()

@end

@implementation InviteFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"邀请好友";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - NavHeight - 70)];
    background.image = [UIImage imageNamed:@"invite_background"];
    [self.view addSubview:background];
    
    
    
    
    
    //////
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight - NavHeight - 70, ScreenWidth, 70)];
    bottomView.backgroundColor = ThemeColorBackground;
    [self.view addSubview:bottomView];
    
    UIButton *wechatButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    wechatButton.center = CGPointMake(ScreenWidth * 0.25, 25);
    [wechatButton setImage:[UIImage imageNamed:@"wechat_button"] forState:UIControlStateNormal];
    [bottomView addSubview:wechatButton];
    
    UILabel *wechatLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth * 0.5, 20)];
    wechatLabel.textAlignment = NSTextAlignmentCenter;
    wechatLabel.center = CGPointMake(ScreenWidth * 0.25, 57);
    wechatLabel.text = @"微信分享";
    wechatLabel.font = ThemeFontSmallText;
    [bottomView addSubview:wechatLabel];
    
    UIButton *downloadButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    downloadButton.center = CGPointMake(ScreenWidth * 0.75, 25);
    [downloadButton setImage:[UIImage imageNamed:@"download_button"] forState:UIControlStateNormal];
    [bottomView addSubview:downloadButton];
    
    UILabel *downloadLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth * 0.5, 20)];
    downloadLabel.textAlignment = NSTextAlignmentCenter;
    downloadLabel.center = CGPointMake(ScreenWidth * 0.75, 57);
    downloadLabel.text = @"下载图片";
    downloadLabel.font = ThemeFontSmallText;
    [bottomView addSubview:downloadLabel];
    
}

@end
