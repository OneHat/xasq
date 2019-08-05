//
//  CapitalSubView.h
//  xasq
//
//  Created by dssj on 2019/8/1.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CapitalTopView.h"


NS_ASSUME_NONNULL_BEGIN

@interface CapitalSubView : UIView

@property (nonatomic, strong) CapitalTopView *topView;

@property (nonatomic, strong) void (^CellSelectBlock)(void);

@end

NS_ASSUME_NONNULL_END
