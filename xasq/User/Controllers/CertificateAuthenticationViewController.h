//
//  CertificateAuthenticationViewController.h
//  xasq
//
//  Created by dssj888@163.com on 2019/8/16.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CertificateAuthenticationViewController : UIViewController

@property (nonatomic, assign) NSInteger type; // 0 身份证 1 护照 2 驾照
@property (nonatomic, strong) NSString *certNo; // 证件号码
@property (nonatomic, strong) NSString *certName; // 姓名
@end

NS_ASSUME_NONNULL_END
