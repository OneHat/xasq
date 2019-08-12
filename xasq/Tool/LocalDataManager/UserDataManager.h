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

+ (instancetype)shareManager;

/// userId 判断是否登录
@property (nonatomic, strong, nullable) NSString *userId;
/**
 *
 *  "userName":"185707767",      用户名
 *  "areaCode":"012",            地区
 *  "mobile":"18570747167",      手机号
 *  "email":"741794681@qq.com",  邮箱
 *  "status":"0",
 *  "userType":0,
 *  "headImg":"xx/xxx/xx.png",   头像
 *  "nickName":"杀手十七",         昵称
 *  "level":"lv1"                等级
 */
@property (nonatomic, strong, nullable) NSDictionary *userData;

///退出登录后,删除登录状态
- (void)deleteLoginStatus;



///登录成功后返回的唯一标识
+ (NSString *)authorization;

///登录成功,存储唯一标识到本地
+ (void)saveAuthorization:(NSString *)authorization;

///登录成功,存储唯一标识到本地
+ (void)deleteAuthorization;



@end

NS_ASSUME_NONNULL_END
