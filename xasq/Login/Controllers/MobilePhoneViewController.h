//
//  MobilePhoneViewController.h
//  xasq
//
//  Created by dssj888@163.com on 2019/8/9.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MobilePhoneViewController : UIViewController

@property (nonatomic, copy) void (^countryCodeBlock)(NSString *phoneCode, NSString *name);

@end

NS_ASSUME_NONNULL_END
