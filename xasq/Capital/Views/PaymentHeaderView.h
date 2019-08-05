//
//  PaymentHeaderView.h
//  xasq
//
//  Created by dssj888@163.com on 2019/8/5.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PaymentHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIButton *typeBtn;  // 类型Btn

@property (weak, nonatomic) IBOutlet UIButton *currencyBtn; // 币种Btn

@end

NS_ASSUME_NONNULL_END
