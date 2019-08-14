//
//  CapitalDataManager.h
//  xasq
//
//  Created by dssj on 2019/8/14.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CapitalDataManager : NSObject

+ (instancetype)shareManager;

///是否隐藏资产
@property (nonatomic, assign) BOOL hideMoney;

@end

NS_ASSUME_NONNULL_END
