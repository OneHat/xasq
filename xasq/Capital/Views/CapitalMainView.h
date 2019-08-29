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
// 更新隐藏0金额选择状态
- (void)updateAmountClick:(BOOL)isHidden;
// 隐藏Btn和LB
- (void)hiddenAmountClick:(BOOL)isHidden;

@end

@interface CapitalMainView : UIView

@property (nonatomic, assign, readonly) CGFloat topCapitalViewH;//

@property (nonatomic, weak) id<CapitalMainViewDelegate> delegate;

- (void)updateBtnStatus:(BOOL)isSelected;     // 更新隐藏Btn选择状态
- (void)hiddenBtnOrLabel:(BOOL)isHidden;     // 隐藏Btn和LB
- (void)setTotalAssets:(NSDictionary *)dict;  // 总资产
- (void)setCapitalDataArray:(NSDictionary *)dict; // 币种列表数据

@end

NS_ASSUME_NONNULL_END
