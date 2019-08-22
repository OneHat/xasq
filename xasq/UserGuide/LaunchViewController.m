//
//  LaunchViewController.m
//  xasq
//
//  Created by dssj on 2019/8/6.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "LaunchViewController.h"
#import "BannerObject.h"

@interface LaunchViewController ()

@property (weak, nonatomic) IBOutlet UILabel *secondLabel;
@property (nonatomic, assign) NSInteger second;

@property (weak, nonatomic) IBOutlet UIImageView *launchImageView;
@property (strong, nonatomic) UIImage *launchImage;

@end

static NSString *LaunchADCacheKey = @"LaunchADCacheKey";

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _second = 2;
    _secondLabel.hidden = YES;
    
    NSDictionary *cacheAD = [[NSUserDefaults standardUserDefaults] objectForKey:LaunchADCacheKey];
    if (cacheAD) {
        BannerObject *obj = [BannerObject modelWithDictionary:cacheAD];
        
        NSURL *url = [NSURL URLWithString:obj.imgPath];
        [_launchImageView sd_setImageWithURL:url];
    }
    
    //获取banner
    [[NetworkManager sharedManager] getRequest:OperationBanner parameters:@{@"type":@"1"} success:^(NSDictionary * _Nonnull data) {
        NSArray *dataList = data[@"data"];
        if (dataList && [dataList isKindOfClass:[NSArray class]] && dataList.count > 0) {
            NSDictionary *firstAD = dataList.firstObject;
            [[NSUserDefaults standardUserDefaults] setObject:firstAD forKey:LaunchADCacheKey];
            
            BannerObject *newObj = [BannerObject modelWithDictionary:firstAD];
            UIImageView *temp = [[UIImageView alloc] init];
            [temp sd_setImageWithURL:[NSURL URLWithString:newObj.imgPath]];
        }
        
    } failure:^(NSError * _Nonnull error) {
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        self.second--;
        self.secondLabel.text = [NSString stringWithFormat:@"%ld",self.second];
        
        if (self.second <= 0) {
            [timer invalidate];
            timer = nil;
            
            [self buttonAction:nil];
        }
        
    }];
}

- (IBAction)buttonAction:(UIButton *)sender {
    if (self.dissmissLaunch) {
        self.dissmissLaunch();
    }
    
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

@end
