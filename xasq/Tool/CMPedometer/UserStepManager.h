//
//  UserStepManager.h
//  xasq
//
//  Created by dssj on 2019/8/7.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef void(^GetUserStepBlock)(NSInteger steps);

@interface UserStepManager : NSObject

+ (instancetype)manager;

//授权权限
//- (void)requestAuthorizationCompletion:(void (^)(void))completion;

///获取今天的步数
- (void)getTodayStepsCompletion:(GetUserStepBlock)completion;

///获取昨天的步数
- (void)getYesterdayStepsCompletion:(GetUserStepBlock)completion;

@end

NS_ASSUME_NONNULL_END
