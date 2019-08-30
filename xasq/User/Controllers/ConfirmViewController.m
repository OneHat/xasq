//
//  ConfirmViewController.m
//  xasq
//
//  Created by dssj888@163.com on 2019/7/31.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "ConfirmViewController.h"
#import "UIViewController+ActionSheet.h"

@interface ConfirmViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@end

@implementation ConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"联系我们";
    
    _imageV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageVClick:)];
    [_imageV addGestureRecognizer:tap];
}

- (void)imageVClick:(UITapGestureRecognizer *)tap {
    [self alertWithTitle:@"提示" message:@"是否保存到相册?" items:@[@"取消",@"确定"] action:^(NSInteger index) {
        
        if (index == 0) {
            [self dismissViewControllerAnimated:NO completion:nil];
        } else {
            UIImageWriteToSavedPhotosAlbum(self.imageV.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
            [self dismissViewControllerAnimated:NO completion:nil];
        }
    }];
}

#pragma mark -- <保存到相册>
-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *msg = nil ;
    if(error){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    [self showMessage:msg];
}

@end
