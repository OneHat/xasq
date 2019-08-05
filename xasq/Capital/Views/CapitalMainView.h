//
//  CapitalSubView.h
//  xasq
//
//  Created by dssj on 2019/8/1.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CapitalMainViewDelegate <NSObject>

//收支记录
- (void)capitalMainViewRecordClick;
//充币、提币、资金划转、交易
- (void)capitalMainViewButtonModuleClick:(NSInteger)index;
//点击币种
- (void)capitalMainViewCellSelect:(NSInteger)index;
//搜索
- (void)capitalMainViewSearchClick;

@end

@interface CapitalMainView : UIView


@property (nonatomic, assign, readonly) CGFloat topCapitalViewH;

@property (nonatomic, weak) id<CapitalMainViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
