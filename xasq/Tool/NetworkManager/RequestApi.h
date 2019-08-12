//
//  RequestApi.h
//  xasq
//
//  Created by dssj on 2019/7/29.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 注册 POST
FOUNDATION_EXPORT NSString *const UserRegister;
/// 手机登录 POST
FOUNDATION_EXPORT NSString *const UserLoginMobile;
/// 邮箱登录 POST
FOUNDATION_EXPORT NSString *const UserLoginEmail;

/// 用户基本信息 GET
FOUNDATION_EXPORT NSString *const UserInfo;
/// 谷歌绑定 POST
FOUNDATION_EXPORT NSString *const UserGoogleBind;
/// 邮箱绑定 POST
FOUNDATION_EXPORT NSString *const UserEmailBind;
/// 查询用户通讯录 GET
FOUNDATION_EXPORT NSString *const UserInviteAddresslist;
/// 发送邀请短信 POST
FOUNDATION_EXPORT NSString *const UserInviteSendmessage;
/// 查询二级邀请算力奖励记录
FOUNDATION_EXPORT NSString *const UserInviteSecond;
/// 申请实名认证 POST
FOUNDATION_EXPORT NSString *const UserIdentityApply;
/// 手机绑定接口 POST
FOUNDATION_EXPORT NSString *const UserMobileBind;
/// 查询所有邀请算力奖励记录 GET
FOUNDATION_EXPORT NSString *const UserInviteAll;
/// 查询一级邀请算力奖励记录 GET
FOUNDATION_EXPORT NSString *const UserInviteFirst;
/// 获取我的界面信息 POST
FOUNDATION_EXPORT NSString *const HomePageInfo;
/// 邀请人绑定接口 POST
FOUNDATION_EXPORT NSString *const UserInviteBind;
/// 获取邀请码参数接口 GET
FOUNDATION_EXPORT NSString *const UserInviteQrcode;
/// 用户签到接口 POST
FOUNDATION_EXPORT NSString *const UserSignIn;
/// 修改密码接口 POST
FOUNDATION_EXPORT NSString *const UserPwdLoginModify;
/// 查询签到信息 GET
FOUNDATION_EXPORT NSString *const UserSignInfo;


@interface RequestApi : NSObject

@end

NS_ASSUME_NONNULL_END
