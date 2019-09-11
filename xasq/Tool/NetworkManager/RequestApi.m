//
//  RequestApi.m
//  xasq
//
//  Created by dssj on 2019/7/29.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "RequestApi.h"

NSString *const ErrorMessageKeyXasq = @"ErrorMessageKeyXasq";

NSString *const UserRegister = @"user/register/standard";
NSString *const UserLoginMobile = @"user/login/mobile";
NSString *const UserLoginEmail = @"user/login/email";

NSString *const UserHomePageInfo = @"user/home/page/info";
NSString *const UserGoogleBind = @"user/google/bind";
NSString *const UserEmailBind = @"user/email/bind";
NSString *const UserEmailRebind = @"user/email/rebind";
NSString *const UserInviteAddresslist = @"user/invite/addresslist";
NSString *const UserInviteSendmessage = @"user/invite/sendmessage";
NSString *const UserIdentityApply = @"user/identity/apply";
NSString *const UserMobileBind = @"user/mobile/bind";
NSString *const UserMobileRebind = @"user/mobile/rebind";
NSString *const UserInviteBind = @"user/invite/bind";
NSString *const UserInviteQrcode = @"user/invite/qrcode";
NSString *const UserPwdReset = @"user/pwd/reset";
NSString *const UserPwdLoginModify = @"user/pwd/login/modify";
NSString *const UserFundpwdSet = @"user/fundpwd/set";
NSString *const UserSignIn = @"user/sign/in";
NSString *const UserSignInfo = @"user/sign/info";
NSString *const UserSendEmail = @"user/send/email";
NSString *const UserSendMobile = @"user/send/mobile";
NSString *const UserSendLoginMobile = @"user/send/notlogin/mobile";
NSString *const UserSetIcon = @"user/set/icon";
NSString *const UserSetNickname = @"user/set/nickname";
NSString *const UserSyncWalk = @"user/syncWalk";
NSString *const UserCheckValidcode = @"user/check/validcode";
NSString *const UserInviteRankCount = @"user/invite/rank/count";
NSString *const UserIdentityDetails = @"user/identity/details";

NSString *const AcctTransferAccount = @"acct/transfer/account";

NSString *const OperationSystemVersion = @"oper/sys/version";
NSString *const OperationBanner = @"oper/banner/list";
NSString *const OperationCountry = @"oper/country";
NSString *const OperationUploadImage = @"oper/upload/image";


NSString *const MessageSysList = @"msg/sys/list";
NSString *const MessageSysUnreadNum = @"msg/sys/unread/num";
NSString *const MessageSysRead = @"msg/sys/read/all";
NSString *const MessageSysClear = @"msg/sys/clear/all";

NSString *const CommunityCapitalWaterDynamics = @"comm/capital/water/dynamics";
NSString *const CommunityCapitalWater = @"comm/capital/water";
NSString *const CommunitySendPower = @"comm/send/power";
NSString *const CommunityPowerRecord = @"comm/power/record";
NSString *const CommunityAreaTakeRecord = @"comm/area/take/record";
NSString *const CommunityAreaTakeCurrency = @"comm/area/takecurrency";
NSString *const CommunityArea = @"comm/area";
NSString *const CommunityAreaList = @"comm/area/list";
NSString *const CommunityCapitalStatistics = @"comm/capital/statistics";
NSString *const CommunityUserSubAccount = @"comm/user/sub/account";
NSString *const CommunityAreaStealCurrency = @"comm/area/stealcurrency";
NSString *const CommunitySendWalk = @"comm/send/walk";
NSString *const CommunityTaskDaily = @"comm/task/daily";
NSString *const CommunityTaskSingle = @"comm/task/single";
NSString *const CommunityTaskWeekly = @"comm/task/weekly";
NSString *const CommunityAreaCurrency = @"comm/area/currency";
NSString *const CommunityCapitalCurrencyBalance = @"comm/capital/currency/balance";
NSString *const CommunityStatisticsCount = @"comm/capital/statistics/count";
NSString *const CommunityStealFlow = @"comm/steal/flow";
NSString *const CommunityPowerUpinfo = @"comm/power/upinfo";
NSString *const CommunitySignReward = @"comm/sign/reward";
NSString *const CommunityInviteFlow = @"comm/invite/flow";
NSString *const CommunityInviteFlowFirst = @"comm/invite/flow/first";
NSString *const CommunityInviteFlowSecond = @"comm/invite/flow/second";
NSString *const CommunityPowerRank = @"comm/all/power/rank";
NSString *const CommunityPowerRankMyself = @"comm/power/rank/myself";
NSString *const CommunityRankFriends = @"comm/power/rank/friends";

NSString *const OperCategoryList = @"oper/category/list";
NSString *const OperEconomicDataList = @"oper/economic/data/list";
NSString *const OperEconomicEventList = @"oper/economic/event/list";
NSString *const OperEconomicHolidayList = @"oper/economic/holiday/list";
NSString *const OperEconomicCalendarList = @"oper/economic/calendar/list";
NSString *const OperInformationList = @"oper/information/list";


NSInteger const E010141 = 10141;
NSInteger const E010145 = 10145;
NSInteger const E010142 = 10142;
NSInteger const E010130 = 10130;

@implementation RequestApi

@end
