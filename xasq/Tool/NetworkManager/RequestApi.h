//
//  RequestApi.h
//  xasq
//
//  Created by dssj on 2019/7/29.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 错误信息
FOUNDATION_EXPORT NSString *const ErrorMessageKeyXasq;


//********************************用户模块
/// 注册 POST
FOUNDATION_EXPORT NSString *const UserRegister;
/// 手机登录 POST
FOUNDATION_EXPORT NSString *const UserLoginMobile;
/// 邮箱登录 POST
FOUNDATION_EXPORT NSString *const UserLoginEmail;

/// 用户基本信息 GET
FOUNDATION_EXPORT NSString *const UserHomePageInfo;
/// 谷歌绑定 POST
FOUNDATION_EXPORT NSString *const UserGoogleBind;
/// 邮箱绑定 POST
FOUNDATION_EXPORT NSString *const UserEmailBind;
/// 邮箱绑定 POST
FOUNDATION_EXPORT NSString *const UserEmailRebind;
/// 查询用户通讯录 GET
FOUNDATION_EXPORT NSString *const UserInviteAddresslist;
/// 发送邀请短信 POST
FOUNDATION_EXPORT NSString *const UserInviteSendmessage;
/// 查询二级邀请算力奖励记录
FOUNDATION_EXPORT NSString *const UserInviteRecordSecond;
/// 申请实名认证 POST
FOUNDATION_EXPORT NSString *const UserIdentityApply;
/// 手机绑定接口 POST
FOUNDATION_EXPORT NSString *const UserMobileBind;
/// 更换绑定手机接口 POST
FOUNDATION_EXPORT NSString *const UserMobileRebind;
/// 查询所有邀请算力奖励记录 GET
FOUNDATION_EXPORT NSString *const UserInviteRecordAll;
/// 查询一级邀请算力奖励记录 GET
FOUNDATION_EXPORT NSString *const UserInviteRecordFirst;
/// 获取我的界面信息 POST
FOUNDATION_EXPORT NSString *const HomePageInfo;
/// 邀请人绑定接口 POST
FOUNDATION_EXPORT NSString *const UserInviteBind;
/// 获取邀请码参数接口 GET
FOUNDATION_EXPORT NSString *const UserInviteQrcode;
///// 用户签到接口 POST
//FOUNDATION_EXPORT NSString *const UserSignIn;
/// 修改(找回)支付密码接口 POST
FOUNDATION_EXPORT NSString *const UserPwdReset;
/// 修改登录密码接口 POST
FOUNDATION_EXPORT NSString *const UserPwdLoginModify;
/// 查询签到信息 GET
FOUNDATION_EXPORT NSString *const UserSignInfo;
/// 发送邮箱验证码接口 POST
FOUNDATION_EXPORT NSString *const UserSendEmail;
/// 发送手机验证码接口 POST
FOUNDATION_EXPORT NSString *const UserSendMobile;
/// 设置用户头像接口 POST
FOUNDATION_EXPORT NSString *const UserSetIcon;
/// 设置用户昵称接口 POST
FOUNDATION_EXPORT NSString *const UserSetNickname;
/// 同步步行步数 POST
FOUNDATION_EXPORT NSString *const UserSyncWalk;
/// 验证码校验接口 POST
FOUNDATION_EXPORT NSString *const UserCheckValidcode;
/// 算力、等级排行 全用户 GET
FOUNDATION_EXPORT NSString *const UserInviteRankAllpower;
/// 邀请人数排行 GET
FOUNDATION_EXPORT NSString *const UserInviteRankCount;
/// 算力、等级排行接口(我的好友) GET
FOUNDATION_EXPORT NSString *const UserInviteRankPower;
/// 认证信息接口 GET
FOUNDATION_EXPORT NSString *const UserIdentityDetails;


//********************************资产账单
///查看个人总帐单 POST
FOUNDATION_EXPORT NSString *const ApiAccountSelectAccounntBill;
///帐号开户 POST
FOUNDATION_EXPORT NSString *const ApiAccountOpenAccount;
///查看金融工具币种 POST
FOUNDATION_EXPORT NSString *const ApiAccountSelectCurrency;


//********************************运营
///获取系统版本信息 Get
FOUNDATION_EXPORT NSString *const OperationSystemVersion;
///获取banner信息 Get
FOUNDATION_EXPORT NSString *const OperationBanner;
///获取国家及其区号列表 Get
FOUNDATION_EXPORT NSString *const OperationCountry;
///用户上传头像接口 POST
FOUNDATION_EXPORT NSString *const OperationUploadImage;


//********************************消息模块
///站内信列表 POST
FOUNDATION_EXPORT NSString *const MessageSysList;


//********************************社区模块
///获取用户好友社区资产动态（领币，偷币，奖励…）Get
FOUNDATION_EXPORT NSString *const CommunityCapitalWaterDynamics;
///获取用户社区资产账户流水 Get
FOUNDATION_EXPORT NSString *const CommunityCapitalWater;
///获取用户算力奖励 Get
FOUNDATION_EXPORT NSString *const CommunitySendPower;
///用户算力记录 Get
FOUNDATION_EXPORT NSString *const CommunityPowerRecord;
///用户收取/领取的录 GET
FOUNDATION_EXPORT NSString *const CommunityAreaTakeRecord;
///用户收币 POST
FOUNDATION_EXPORT NSString *const CommunityAreaTakeCurrency;
///获取单个矿区信息 GET
FOUNDATION_EXPORT NSString *const CommunityArea;
///获取所有矿区信息 GET
FOUNDATION_EXPORT NSString *const CommunityAreaList;
///用户社区账户资产统计 GET
FOUNDATION_EXPORT NSString *const CommunityCapitalStatistics;
///新建社区资产账户 POST
FOUNDATION_EXPORT NSString *const CommunityUserSubAccount;
///用户偷币 POST
FOUNDATION_EXPORT NSString *const CommunityAreaStealCurrency;
///获取用户步行奖励 GET
FOUNDATION_EXPORT NSString *const CommunitySendWalk;
///获取每日重复任务 GET
FOUNDATION_EXPORT NSString *const CommunityTaskDaily;
///获取单次任务 GET
FOUNDATION_EXPORT NSString *const CommunityTaskSingle;
///获取每周重复任务 GET
FOUNDATION_EXPORT NSString *const CommunityTaskWeekly;
///获取所有货币信息接口 GET
FOUNDATION_EXPORT NSString *const CommunityAreaCurrency;
///获取币种和金额（金额大于0的） GET
FOUNDATION_EXPORT NSString *const CommunityCapitalCurrencyBalance;
///用户资产统计） GET
FOUNDATION_EXPORT NSString *const CommunityStatisticsCount;
///用户被偷取记录（最新动态） GET
FOUNDATION_EXPORT NSString *const CommunityStealFlow;
///用户等级信息和升级信息 GET
FOUNDATION_EXPORT NSString *const CommunityPowerUpinfo;
///用户签到 POST
FOUNDATION_EXPORT NSString *const CommunitySign;

//********************************错误码
FOUNDATION_EXPORT NSInteger const E010141;
FOUNDATION_EXPORT NSInteger const E010145;
FOUNDATION_EXPORT NSInteger const E010142;
FOUNDATION_EXPORT NSInteger const E010130;


@interface RequestApi : NSObject

@end

NS_ASSUME_NONNULL_END
