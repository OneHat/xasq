//
//  SelectCurrencyViewController.h
//  xasq
//
//  Created by dssj888@163.com on 2019/8/5.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CapitalModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface SelectCurrencyViewController : UIViewController

@property (nonatomic, copy) void (^CapitalModelBlock)(CapitalModel *model);


@end

NS_ASSUME_NONNULL_END
