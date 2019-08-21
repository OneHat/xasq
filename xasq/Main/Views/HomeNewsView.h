//
//  HomeNewsView.h
//  xasq
//
//  Created by dssj on 2019/7/31.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserNewsModel.h"

NS_ASSUME_NONNULL_BEGIN

///首页的滚动消息
@interface HomeNewsView : UIView

@property (nonatomic, strong) NSArray *newsArray;

@end

NS_ASSUME_NONNULL_END
