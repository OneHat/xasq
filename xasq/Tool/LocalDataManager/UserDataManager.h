//
//  UserDataManager.h
//  xasq
//
//  Created by dssj on 2019/8/6.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserDataManager : NSObject

///是否登录，已经登录返回YES，否则返回NO
+ (BOOL)isLogin;

///登录成功后,保存登录状态
+ (void)saveLoginStatus;

///退出登录后,删除登录状态
+ (void)deleteLoginStatus;



///登录成功后返回的唯一标识
+ (NSString *)authorization;

///登录成功,存储唯一标识到本地
+ (void)saveAuthorization:(NSString *)authorization;

///登录成功,存储唯一标识到本地
+ (void)deleteAuthorization;

@end

NS_ASSUME_NONNULL_END
