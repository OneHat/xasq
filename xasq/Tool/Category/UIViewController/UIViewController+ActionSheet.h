//
//  UIViewController+ActionSheet.h
//  xasq
//
//  Created by dssj on 2019/7/31.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ActionSheetSelect)(NSInteger index);

typedef void(^AlertActionClick)(NSInteger index);

@interface UIViewController (ActionSheet)

/// 没有标题，关闭按钮默认“关闭”
- (void)actionSheetWithItems:(NSArray<NSString *> *)items
                    complete:(ActionSheetSelect)complete;

- (void)actionSheetWithTitle:(nullable NSString *)title
                       close:(nullable NSString *)close
                       items:(NSArray<NSString *> *)items
                    complete:(ActionSheetSelect)complete;


#pragma mark -
//没有标题
- (void)alertWithMessage:(NSString *)message
                 items:(NSArray<NSString *> *)items
                action:(AlertActionClick)action;

- (void)alertWithTitle:(nullable NSString *)title
               message:(NSString *)message
                 items:(NSArray<NSString *> *)items
                action:(AlertActionClick)action;



@end

NS_ASSUME_NONNULL_END
