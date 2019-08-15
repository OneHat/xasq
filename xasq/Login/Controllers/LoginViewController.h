//
//  LoginViewController.h
//  xasq
//
//  Created by dssj888@163.com on 2019/7/31.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN



@interface LoginViewController : UIViewController

@property (nonatomic, copy) void (^closeLoginBlock)(BOOL isLogin);

@end

NS_ASSUME_NONNULL_END
