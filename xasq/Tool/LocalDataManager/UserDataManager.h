//
//  UserDataManager.h
//  xasq
//
//  Created by dssj on 2019/8/6.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserDataManager : NSObject

+ (instancetype)shareManager;

/// userId 这里同时用来判断是否登录
@property (nonatomic, strong, nullable) NSString *userId;

///登录成功后返回的唯一标识
@property (nonatomic, strong,nullable) NSString *authorization;

///用户模型
@property (nonatomic, strong,nullable) UserModel *usermodel;

///退出登录后,删除登录状态
- (void)deleteLoginStatus;

///登录成功,存储用户信息到本地
- (void)saveUserData:(NSDictionary *)userData;

@end

NS_ASSUME_NONNULL_END
