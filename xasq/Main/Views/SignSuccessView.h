//
//  SignSuccessView.h
//  xasq
//
//  Created by dssj on 2019/8/16.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SignSuccessView : UIView

@property (nonatomic, strong) void (^CloseViewBlock)(void);

@end

NS_ASSUME_NONNULL_END
