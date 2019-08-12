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

//查看个人总帐单 POST
FOUNDATION_EXPORT NSString *const ApiAccountSelectAccounntBill;
//帐号开户 POST
FOUNDATION_EXPORT NSString *const ApiAccountOpenAccount;
//查看金融工具币种 POST
FOUNDATION_EXPORT NSString *const ApiAccountSelectCurrency;


//获取系统版本信息 Get
FOUNDATION_EXPORT NSString *const OperationSystemVersion;
//获取banner信息 Get
FOUNDATION_EXPORT NSString *const OperationBanner;


//获取推荐任务 GET
FOUNDATION_EXPORT NSString *const CommunityTaskRecommend;
//获取用户好友社区资产动态（领币，偷币，奖励…）GetGet
FOUNDATION_EXPORT NSString *const CommunityCapitalWaterDynamics;
//获取高分任务 GET
FOUNDATION_EXPORT NSString *const CommunityTaskPower;
//获取用户社区资产账户流水 Get
FOUNDATION_EXPORT NSString *const CommunityCapitalWater;
//获取用户算力奖励 Get
FOUNDATION_EXPORT NSString *const CommunitySendPower;
//获取我的任务 Get
FOUNDATION_EXPORT NSString *const CommunityTask;
//用户算力记录 Get
FOUNDATION_EXPORT NSString *const CommunityPowerRecord;
//用户收取/领取的录 POST
FOUNDATION_EXPORT NSString *const CommunityAreaTakeRecord;
//用户收币 POST
FOUNDATION_EXPORT NSString *const CommunityAreaTakeCurrency;
//获取单个矿区信息 GET
FOUNDATION_EXPORT NSString *const CommunityArea;
//获取所有矿区信息 GET
FOUNDATION_EXPORT NSString *const CommunityAreaList;
//用户社区账户资产统计 POST
FOUNDATION_EXPORT NSString *const CommunityCapitalStatistics;
//新建社区资产账户 POST
FOUNDATION_EXPORT NSString *const CommunityUserSubAccount;
//用户偷币 POST
FOUNDATION_EXPORT NSString *const CommunityAreaStealCurrency;
//获取用户步行奖励 POST
FOUNDATION_EXPORT NSString *const CommunitySendWalk;


@interface RequestApi : NSObject

@end

NS_ASSUME_NONNULL_END
