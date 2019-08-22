//
//  LivingProofViewController.m
//  xasq
//
//  Created by dssj888@163.com on 2019/7/30.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "LivingProofViewController.h"
#import "AlterNicknameViewController.h"
#import "UIViewController+ActionSheet.h"
#import <Photos/PHPhotoLibrary.h>
#import "AFHTTPSessionManager.h"
#import "CredentialsViewController.h"
#import "UnauthorizedViewController.h"

@interface LivingProofViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *pictureImageV;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLB;
@property (weak, nonatomic) IBOutlet UILabel *certificationLB;


@end

@implementation LivingProofViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户信息";
    _pictureImageV.layer.cornerRadius = 30;
    _pictureImageV.layer.masksToBounds = YES;
    [_pictureImageV sd_setImageWithURL:[NSURL URLWithString:[UserDataManager shareManager].usermodel.headImg] placeholderImage:[UIImage imageNamed:@"head_portrait"]];
    if ([[UserDataManager shareManager].usermodel.authStatus integerValue] == 1) {
        _certificationLB.text = @"已认证";
    } else if ([[UserDataManager shareManager].usermodel.authStatus integerValue] == 2) {
        _certificationLB.text = @"审核中";
    } else {
        _certificationLB.text = @"未认证";
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([UserDataManager shareManager].usermodel.nickName.length > 0) {
        _nicknameLB.text = [UserDataManager shareManager].usermodel.nickName;
    } else {
        _nicknameLB.text = @"去设置";
    }
}

- (IBAction)certificationClick:(UIButton *)sender {
    if ([[UserDataManager shareManager].usermodel.authStatus integerValue] == 1) {
        // 已认证
        CredentialsViewController *VC = [[CredentialsViewController alloc] init];
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    } else if ([[UserDataManager shareManager].usermodel.authStatus integerValue] == 0){
        // 未认证
        UnauthorizedViewController *VC = [[UnauthorizedViewController alloc] init];
        VC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:VC animated:YES];
    }
}


- (IBAction)nickNameClick:(UIButton *)sender {
    
    AlterNicknameViewController *VC = [[AlterNicknameViewController alloc] init];
    VC.nickname = [UserDataManager shareManager].usermodel.nickName;
    [self.navigationController pushViewController:VC animated:YES];
}

- (IBAction)alterHeadPortraitClick:(UIButton *)sender {
    
    [self actionSheetWithItems:@[@"拍摄", @"从手机相册选择"] complete:^(NSInteger index) {
        if (index == 0) {
            [self takePhoto];
        } else {
            [self choseFromLib];
        }
    }];
}

#pragma mark  --从本地相册获取
- (void)choseFromLib {
    //----第一次不会进来
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied){
        // 无权限 做一个友好的提示
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"此应用没有权限访问您的照片或视频,若要设置头像等功能您可以在'隐私设置'中启用访问" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertVC addAction:cancel];
        [self presentViewController:alertVC animated:YES completion:nil];
        return ;
    }
    //----每次都会走进来
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status == PHAuthorizationStatusAuthorized) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.delegate = self;
            //    picker.allowsEditing = YES;
            [self presentViewController:picker animated:YES completion:^{
            }];
        }else {
            //----为什么没有在这个里面进行权限判断，因为会项目会蹦。。。
        }
    }];
}

- (void)takePhoto {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        // 设置拍照后的图片可以编辑
        picker.allowsEditing = YES;
        // 资源类型为照相机
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:^{
        }];
    }else {
        //如果没有提示用户
        [self showMessage:@"你没有摄像头"];
    }
}

#pragma Delegate method UIImagePickerControllerDelegate
// 图像选取器的委托方法，选完图片后回调该方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (!image) {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    UIImage *compressImg = [self imageWithImageSimple:image scaledToSize:CGSizeMake(60, 60)];//对选取的图片进行大小上的压缩
    [self transportImgToServerWithImg:compressImg]; //将裁剪后的图片上传至服务器

    [picker dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
}

//上传图片至服务器后台
- (void)transportImgToServerWithImg:(UIImage *)img {
    
    [[NetworkManager sharedManager] uploadRequest:OperationUploadImage image:img success:^(NSDictionary * _Nonnull data) {

        NSDictionary *params = @{@"userId" : [UserDataManager shareManager].userId,
                                 @"icon"   : data[@"data"][@"path"]
                                 };
        // 上传成功后绑定对应账户ID
        [[NetworkManager sharedManager] postRequest:UserSetIcon parameters:params success:^(NSDictionary * _Nonnull data) {
            [self hideHUD];
            [self showMessage:@"更换成功"];
            self.pictureImageV.image = img;

        } failure:^(NSError * _Nonnull error) {
            [self hideHUD];
            [self showErrow:error];
        }];


    } failure:^(NSError * _Nonnull error) {
        [self hideHUD];
        [self showErrow:error];
    }];
}
//压缩图片方法
- (UIImage*)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
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
