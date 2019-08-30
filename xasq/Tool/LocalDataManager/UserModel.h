//
//  UserModel.h
//  xasq
//
//  Created by dssj on 2019/8/13.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserModel : NSObject

/// 用户名
@property (nonatomic, strong) NSString *userName;
/// 区号
@property (nonatomic, strong) NSString *countryCode;
/// 手机号
@property (nonatomic, strong) NSString *mobile;
/// 邮箱
@property (nonatomic, strong) NSString *email;
/// 状态 0:正常,1:冻结,2:禁用
@property (nonatomic, assign) NSInteger status;
/// 用户类型 0:普通用户,1:管理人员,2:做市商,3:系统用户
@property (nonatomic, assign) NSInteger userType;
/// 头像
@property (nonatomic, strong) NSString *headImg;
/// 昵称
@property (nonatomic, strong) NSString *nickName;
/// 地区名称
@property (nonatomic, strong) NSString *areaName;
/// 地区号
@property (nonatomic, strong) NSString *areaCode;
/// 等级
@property (nonatomic, strong) NSString *level;
/// 是否认证 0:未认证 1:已认证 2:审核中3-打回
@property (nonatomic, strong) NSNumber *authStatus;
/// 是否设置了资金密码
@property (nonatomic, assign) BOOL existFundPassWord;

+ (instancetype)modelWithDictionary:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
