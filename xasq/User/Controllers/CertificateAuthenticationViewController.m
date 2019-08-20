//
//  CertificateAuthenticationViewController.m
//  xasq
//
//  Created by dssj888@163.com on 2019/8/16.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "CertificateAuthenticationViewController.h"
#import "UIViewController+ActionSheet.h"
#import <Photos/PHPhotoLibrary.h>
#import "AFHTTPSessionManager.h"

@interface CertificateAuthenticationViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIView *positiveView;
@property (weak, nonatomic) IBOutlet UIImageView *positiveImageV; // 正面照
@property (weak, nonatomic) IBOutlet UIImageView *positiveCamera; // 正面相机
@property (weak, nonatomic) IBOutlet UILabel *positiveLB;
@property (weak, nonatomic) IBOutlet UIView *handheldView;
@property (weak, nonatomic) IBOutlet UIImageView *handheldImageV; // 手持照
@property (weak, nonatomic) IBOutlet UIImageView *handheldCamera; // 手持相机
@property (weak, nonatomic) IBOutlet UILabel *handheldLB;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (nonatomic, assign) NSInteger pictureType;  // 照片类型
@property (nonatomic, strong) UIImage *positiveImage; // 用户上传的图片
@property (nonatomic, strong) UIImage *handheldImage; // 用户上传的图片
@property (nonatomic, strong) NSString *positivePath; // 上传成功的图片地址
@property (nonatomic, strong) NSString *handheldPath; // 上传成功的图片地址
@property (nonatomic, assign) BOOL isPositive;        // 判断是否上传成功
@property (nonatomic, assign) BOOL isHandheld;        // 判断是否上传成功

@end

@implementation CertificateAuthenticationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_type == 2) {
        self.title = @"驾照认证";
    } else if (_type == 1) {
        self.title = @"护照认证";
    } else {
        self.title = @"身份证认证";
    }
    _submitBtn.layer.cornerRadius = 22.5;
    _submitBtn.layer.masksToBounds = YES;
    UITapGestureRecognizer *positiveTop = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(positiveTopClick)];
    _positiveView.userInteractionEnabled = YES;
    [_positiveView addGestureRecognizer:positiveTop];
    UITapGestureRecognizer *handheldTop = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handheldTopClick)];
    _handheldView.userInteractionEnabled = YES;
    [_handheldView addGestureRecognizer:handheldTop];
}

- (void)positiveTopClick {
    _pictureType = 0;
    [self showActionSheet];
}

- (void)handheldTopClick {
    _pictureType = 1;
    [self showActionSheet];
}

- (void)showActionSheet {
    [self actionSheetWithItems:@[@"拍摄", @"从手机相册选择"] complete:^(NSInteger index) {
        if (index == 0) {
            [self takePhoto];
        } else {
            [self choseFromLib];
        }
    }];
}

- (IBAction)submitClick:(UIButton *)sender {
    if (_positiveImage == nil || _handheldImage == nil) {
        [self showMessage:@"请上传图片"];
        return;
    }
    [self loading];
    [self transportImgToServerWithImg:_positiveImage pictureType:0];
    [self transportImgToServerWithImg:_handheldImage pictureType:1];
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
    UIImage *compressImg = [self imageWithImageSimple:image scaledToSize:CGSizeMake(250, 145)];//对选取的图片进行大小上的压缩
    if (_pictureType == 0) {
        _positiveImage = compressImg;
        _positiveImageV.image = compressImg;
        _positiveCamera.hidden = YES;
        _positiveLB.hidden = YES;
    } else {
        _handheldImage = compressImg;
        _handheldImageV.image = compressImg;
        _handheldCamera.hidden = YES;
        _handheldLB.hidden = YES;
    }
//    [self transportImgToServerWithImg:compressImg]; //将裁剪后的图片上传至服务器
    
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^{
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

- (void)transportImgToServerWithImg:(UIImage *)img pictureType:(NSInteger)pictureType {
    NSData *imageData;
    NSString *mimetype;
    WeakObject;
    //判断下图片是什么格式
    if (UIImagePNGRepresentation(img) != nil) {
        mimetype = @"image/png";
        imageData = UIImagePNGRepresentation(img);
    }else{
        mimetype = @"image/jpeg";
        imageData = UIImageJPEGRepresentation(img, 1.0);
    }
    NSString *urlStr = @"http://192.168.100.200:8281/operation/upload/image";
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager POST:urlStr parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSString *str = @"file";
        NSString *fileName = [[NSString alloc] init];
        if (UIImagePNGRepresentation(img) != nil) {
            fileName = [NSString stringWithFormat:@"%@.png", str];
        }else{
            fileName = [NSString stringWithFormat:@"%@.jpg", str];
        }
        // 上传图片，以文件流的格式
        /**
         *filedata : 图片的data
         *name     : 后台的提供的字段
         *mimeType : 类型
         */
        [formData appendPartWithFileData:imageData name:str fileName:fileName mimeType:mimetype];
    } progress:NULL success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *data = responseObject;
        if ([data[@"code"] integerValue] == 200) {
            if (pictureType == 0) {
                weakSelf.isPositive = YES;
                weakSelf.positivePath = data[@"data"][@"path"];
            } else {
                weakSelf.isHandheld = YES;
                weakSelf.handheldPath = data[@"data"][@"path"];
            }
            if (weakSelf.isPositive && weakSelf.isHandheld) {
                // 发送实名认证接口请求
                [self sendUserIdentityApply];
            }
        } else {
            [self hideHUD];
            [self showMessage:data[@"msg"]];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self hideHUD];
        [self showErrow:error];
    }];
}

- (void)sendUserIdentityApply {

    NSDictionary *dict = @{@"userId"       : [UserDataManager shareManager].userId,
                           @"certName"     : _certName,
                           @"certType"     : [NSString stringWithFormat:@"%ld",_type],
                           @"certNo"       : _certNo,
                           @"holdDate"     : _positivePath,
                           @"holdIdentity" : _handheldPath,
                           };
    [[NetworkManager sharedManager] postRequest:UserIdentityApply parameters:dict success:^(NSDictionary * _Nonnull data) {
        [self hideHUD];
        [self showMessage:@"上传成功" complete:^{
            [self popoverPresentationController];
        }];

    } failure:^(NSError * _Nonnull error) {
        [self hideHUD];
        [self showErrow:error];
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
