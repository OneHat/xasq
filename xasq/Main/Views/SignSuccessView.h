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

@property (nonatomic, strong) DSSJBlock closeView;

@property (nonatomic, assign) NSInteger day;
@property (nonatomic, assign) NSInteger power;

@end

NS_ASSUME_NONNULL_END
