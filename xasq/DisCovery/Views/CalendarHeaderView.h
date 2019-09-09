//
//  CalendarHeaderView.h
//  xasq
//
//  Created by dssj888@163.com on 2019/9/9.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CalendarHeaderView : UIView

@property (nonatomic, strong) void (^eventBtnChangeBlock)(NSInteger type);
@property (nonatomic, strong) void (^dateBtnChangeBlock)(NSInteger type);

- (void)setDateSubViews:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
