//
//  AlipayOrder.h
//  xasq
//
//  Created by dssj on 2019/8/8.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface APBizContent : NSObject

// NOTE: (非必填项)商品描述
@property (nonatomic, copy) NSString *body;

// NOTE: 商品的标题/交易标题/订单标题/订单关键字等。
@property (nonatomic, copy) NSString *subject;

// NOTE: 商户网站唯一订单号
@property (nonatomic, copy) NSString *out_trade_no;

// NOTE: 该笔订单允许的最晚付款时间，逾期将关闭交易。
//       取值范围：1m～15d m-分钟，h-小时，d-天，1c-当天(1c-当天的情况下，无论交易何时创建，都在0点关闭)
//       该参数数值不接受小数点， 如1.5h，可转换为90m。
@property (nonatomic, copy) NSString *timeout_express;

// NOTE: 订单总金额，单位为元，精确到小数点后两位，取值范围[0.01,100000000]
@property (nonatomic, copy) NSString *total_amount;

@end

@interface AlipayOrder : NSObject

// NOTE: 支付宝服务器主动通知商户服务器里指定的页面https路径
@property (nonatomic, copy) NSString *notify_url;

/**
 *  获取订单信息串
 *
 *  @param bEncoded       订单信息串中的各个value是否encode
 *                        非encode订单信息串，用于生成签名
 *                        encode订单信息串 + 签名，用于最终的支付请求订单信息串
 */
- (NSString *)orderInfoEncoded:(BOOL)bEncoded;

@end

NS_ASSUME_NONNULL_END
