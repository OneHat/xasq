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
/// 更换邮箱绑定 POST
FOUNDATION_EXPORT NSString *const UserEmailRebind;
/// 查询用户通讯录 GET
FOUNDATION_EXPORT NSString *const UserInviteAddresslist;
/// 发送邀请短信 POST
FOUNDATION_EXPORT NSString *const UserInviteSendmessage;
/// 申请实名认证 POST
FOUNDATION_EXPORT NSString *const UserIdentityApply;
/// 手机绑定接口 POST
FOUNDATION_EXPORT NSString *const UserMobileBind;
/// 更换绑定手机接口 POST
FOUNDATION_EXPORT NSString *const UserMobileRebind;
/// 邀请人绑定接口 POST
FOUNDATION_EXPORT NSString *const UserInviteBind;
/// 获取邀请码参数接口 GET
FOUNDATION_EXPORT NSString *const UserInviteQrcode;
/// 重置登录密码 POST
FOUNDATION_EXPORT NSString *const UserPwdReset;
/// 修改登录密码接口 POST
FOUNDATION_EXPORT NSString *const UserPwdLoginModify;
/// 设置(修改)支付密码 POST
FOUNDATION_EXPORT NSString *const UserFundpwdSet;
/// 用户签到 POST
FOUNDATION_EXPORT NSString *const UserSignIn;
/// 查询签到信息 GET
FOUNDATION_EXPORT NSString *const UserSignInfo;
/// 发送邮箱验证码接口 POST
FOUNDATION_EXPORT NSString *const UserSendEmail;
/// 发送手机验证码接口 POST
FOUNDATION_EXPORT NSString *const UserSendMobile;
/// 登录错误过多手机发送验证码接口 POST
FOUNDATION_EXPORT NSString *const UserSendLoginMobile;
/// 设置用户头像接口 POST
FOUNDATION_EXPORT NSString *const UserSetIcon;
/// 设置用户昵称接口 POST
FOUNDATION_EXPORT NSString *const UserSetNickname;
/// 同步步行步数 POST
FOUNDATION_EXPORT NSString *const UserSyncWalk;
/// 验证码校验接口 POST
FOUNDATION_EXPORT NSString *const UserCheckValidcode;
/// 邀请人数排行 GET
FOUNDATION_EXPORT NSString *const UserInviteRankCount;
/// 认证信息接口 GET
FOUNDATION_EXPORT NSString *const UserIdentityDetails;


//********************************资产账户
///社区账户划转（提币） POST
FOUNDATION_EXPORT NSString *const AcctTransferAccount;


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
///用户未读消息数量 GET
FOUNDATION_EXPORT NSString *const MessageSysUnreadNum;
///一键已读消息接口 GET
FOUNDATION_EXPORT NSString *const MessageSysRead;
///一键清除消息接口 GET
FOUNDATION_EXPORT NSString *const MessageSysClear;

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
///获取连续签到奖励 GET
FOUNDATION_EXPORT NSString *const CommunitySignReward;
/// 算力、等级排行接口(我的好友) POST
FOUNDATION_EXPORT NSString *const CommunityRankFriends;
/// 算力、等级排行 全用户 POST
FOUNDATION_EXPORT NSString *const CommunityPowerRank;
/// 查询所有邀请算力奖励记录 POST
FOUNDATION_EXPORT NSString *const CommunityInviteFlow;
/// 查询一级邀请算力奖励记录 POST
FOUNDATION_EXPORT NSString *const CommunityInviteFlowFirst;
/// 查询二级邀请算力奖励记录 POST
FOUNDATION_EXPORT NSString *const CommunityInviteFlowSecond;
/// 用户在总排行中的信息 GET
FOUNDATION_EXPORT NSString *const CommunityPowerRankMyself;

//********************************发现模块
/// 用户在总排行中的信息 GET
FOUNDATION_EXPORT NSString *const OperCategoryList;
/// 财经数据列表 GET
FOUNDATION_EXPORT NSString *const OperEconomicDataList;
/// 财经事件列表 GET
FOUNDATION_EXPORT NSString *const OperEconomicEventList;
/// 财经节假日列表 GET
FOUNDATION_EXPORT NSString *const OperEconomicHolidayList;
/// 财经日期 GET
FOUNDATION_EXPORT NSString *const OperEconomicCalendarList;

//********************************错误码
FOUNDATION_EXPORT NSInteger const E010141;
FOUNDATION_EXPORT NSInteger const E010145;
FOUNDATION_EXPORT NSInteger const E010142;
FOUNDATION_EXPORT NSInteger const E010130;


@interface RequestApi : NSObject

@end

NS_ASSUME_NONNULL_END
