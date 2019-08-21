//
//  MobilePhoneViewController.h
//  xasq
//
//  Created by dssj888@163.com on 2019/8/9.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountryCodeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MobilePhoneViewController : UIViewController

@property (nonatomic, copy) void (^countryCodeBlock)(CountryCodeModel *model);

@end

NS_ASSUME_NONNULL_END
