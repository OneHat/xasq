//
//  PaymentTypeView.h
//  xasq
//
//  Created by dssj888@163.com on 2019/8/5.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PaymentTypeView : UIView

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) void (^paymentTypeBlock)(NSInteger index);

- (void)setCommunityAreaCurrency:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
