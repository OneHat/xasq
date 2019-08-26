//
//  MentionMoneyResultViewController.h
//  xasq
//
//  Created by dssj888@163.com on 2019/8/5.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MentionMoneyResultViewController : UIViewController

@property (nonatomic, strong) NSString *count; // 提取金额
@property (nonatomic, strong) NSString *currency; // 提取币种
@property (nonatomic, strong) NSString *account; // 提取账户
@end

NS_ASSUME_NONNULL_END
