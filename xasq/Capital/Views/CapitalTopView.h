//
//  CapitalTopView.h
//  xasq
//
//  Created by dssj on 2019/8/2.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,CapitalTopViewStyle) {
    CapitalTopViewAll,//
    CapitalTopViewHold//持有
};

@interface CapitalTopView : UIView

@property (nonatomic, assign) CapitalTopViewStyle viewStyle;

@property (nonatomic, strong) void (^RecordClickBlock)(void);

@property (nonatomic, assign) BOOL hideMoney;

@property (nonatomic, strong) NSDictionary *capitalData;

@end

NS_ASSUME_NONNULL_END
