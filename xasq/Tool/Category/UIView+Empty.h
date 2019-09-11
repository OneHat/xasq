//
//  UIView+Empty.h
//  xasq
//
//  Created by dssj on 2019/7/30.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,EmptyViewReason) {
    //没有数据
    EmptyViewReasonNoData,
    //没有网络
    EmptyViewReasonNoNetwork
};

typedef void(^RefreshBlock)(void);

@interface UIView (Empty)

///block 回调可以为空
- (void)showEmptyView:(EmptyViewReason)reason msg:(nullable NSString *)msg refreshBlock:(nullable RefreshBlock)block;

- (void)hideEmptyView;

/**
 ** lineView:       需要绘制成虚线的view
 ** lineLength:     虚线的宽度
 ** lineSpacing:    虚线的间距
 ** lineColor:      虚线的颜色
 **/
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;
@end

NS_ASSUME_NONNULL_END
