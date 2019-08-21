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

//提币
- (void)capitalMainViewDrawClick;
//点击币种
- (void)capitalMainViewCellSelect:(NSInteger)index;
//搜索
- (void)capitalMainViewSearchClick;

@end

@interface CapitalMainView : UIView

@property (nonatomic, assign, readonly) CGFloat topCapitalViewH;//

@property (nonatomic, weak) id<CapitalMainViewDelegate> delegate;

- (void)setTotalAssets:(NSDictionary *)dict;  // 总资产
- (void)setCapitalDataArray:(NSDictionary *)dict; // 币种列表数据

@end

NS_ASSUME_NONNULL_END
