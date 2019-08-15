//
//  ResetPasswordViewController.h
//  xasq
//
//  Created by dssj888@163.com on 2019/7/31.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ResetPasswordViewController : UIViewController

@property (nonatomic, strong) NSString *account; // 手机号或邮箱号码
@property (nonatomic, strong) NSString *code;    // 验证码
@property (nonatomic, assign) NSInteger type;    // 手机号找回还是邮箱找回

@end

NS_ASSUME_NONNULL_END
