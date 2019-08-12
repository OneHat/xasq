//
//  RequestApi.h
//  xasq
//
//  Created by dssj on 2019/7/29.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

//注册
FOUNDATION_EXPORT NSString *const UserRegister;
//手机登录
FOUNDATION_EXPORT NSString *const UserLoginMobile;
//邮箱登录
FOUNDATION_EXPORT NSString *const UserLoginEmail;

//用户基本信息
FOUNDATION_EXPORT NSString *const UserInfo;
//谷歌绑定
FOUNDATION_EXPORT NSString *const UserGoogleBind;
//查询用户通讯录
FOUNDATION_EXPORT NSString *const UserInviteAddresslist;
//发送邀请短信
FOUNDATION_EXPORT NSString *const UserInviteSendmessage;
//查询二级邀请算力奖励记录
FOUNDATION_EXPORT NSString *const UserInviteSecond;
//申请实名认证
FOUNDATION_EXPORT NSString *const UserIdentityApply;

@interface RequestApi : NSObject

@end

NS_ASSUME_NONNULL_END
