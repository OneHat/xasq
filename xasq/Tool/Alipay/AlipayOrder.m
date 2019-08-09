//
//  AlipayOrder.m
//  xasq
//
//  Created by dssj on 2019/8/8.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "AlipayOrder.h"
#import <AlipaySDK/AlipaySDK.h>


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

// NOTE: 收款支付宝用户ID。 如果该值为空，则默认为商户签约账号对应的支付宝用户ID (如 2088102147948060)
@property (nonatomic, copy) NSString *seller_id;

// NOTE: 销售产品码，商家和支付宝签约的产品码 (如 QUICK_MSECURITY_PAY)
@property (nonatomic, copy) NSString *product_code;

@end

@implementation APBizContent

- (NSString *)description {
    
    NSMutableDictionary *tmpDict = [NSMutableDictionary new];
    // NOTE: 增加不变部分数据
    [tmpDict addEntriesFromDictionary:@{@"subject":_subject?:@"",
                                        @"out_trade_no":_out_trade_no?:@"",
                                        @"total_amount":_total_amount?:@"",
                                        @"seller_id":_seller_id?:@"",
                                        @"product_code":_product_code?:@"QUICK_MSECURITY_PAY"}];
    
    // NOTE: 增加可变部分数据
    if (_body.length > 0) {
        [tmpDict setObject:_body forKey:@"body"];
    }
    
    if (_timeout_express.length > 0) {
        [tmpDict setObject:_timeout_express forKey:@"timeout_express"];
    }
    
    // NOTE: 转变得到json string
    NSData* tmpData = [NSJSONSerialization dataWithJSONObject:tmpDict options:0 error:nil];
    NSString* tmpStr = [[NSString alloc]initWithData:tmpData encoding:NSUTF8StringEncoding];
    return tmpStr;
}

@end

@interface AlipayOrder ()

// NOTE: 具体业务请求数据
@property (nonatomic, strong) APBizContent *biz_content;

// NOTE: 支付宝分配给开发者的应用ID(如2014072300007148)
@property (nonatomic, copy) NSString *app_id;

//// NOTE: 支付接口名称 alipay.trade.app.pay
//@property (nonatomic, copy) NSString *method;

//// NOTE: (非必填项)仅支持JSON
//@property (nonatomic, copy) NSString *format;

// NOTE: (非必填项)HTTP/HTTPS开头字符串
@property (nonatomic, copy) NSString *return_url;

//// NOTE: 参数编码格式，如utf-8,gbk,gb2312等
//@property (nonatomic, copy) NSString *charset;

// NOTE: 请求发送的时间，格式"yyyy-MM-dd HH:mm:ss"
@property (nonatomic, copy) NSString *timestamp;

//// NOTE: 请求调用的接口版本，固定为：1.0
//@property (nonatomic, copy) NSString *version;

// NOTE: 支付宝服务器主动通知商户服务器里指定的页面http路径(本Demo仅做展示所用，商户需要配置这个参数)
@property (nonatomic, copy) NSString *notify_url;

// NOTE: (非必填项)商户授权令牌，通过该令牌来帮助商户发起请求，完成业务(如201510BBaabdb44d8fd04607abf8d5931ec75D84)
@property (nonatomic, copy) NSString *app_auth_token;

// NOTE: 签名类型
@property (nonatomic, copy) NSString *sign_type;



@end

@implementation AlipayOrder

- (NSString *)orderInfoEncoded:(BOOL)bEncoded {
    if (_app_id.length <= 0) {
        return nil;
    }
    
    // NOTE: 增加不变部分数据
    NSMutableDictionary *tmpDict = [NSMutableDictionary new];
    [tmpDict addEntriesFromDictionary:@{@"app_id":_app_id,
                                        @"method":@"alipay.trade.app.pay",
                                        @"charset":@"utf-8",
                                        @"timestamp":self.timestamp,
                                        @"version":@"1.0",
                                        @"biz_content":_biz_content.description?:@"",
                                        @"sign_type":_sign_type?:@"RSA"}];
    
    
    // NOTE: 增加可变部分数据
//    if (_format.length > 0) {
//        [tmpDict setObject:_format forKey:@"format"];
//    }
    
    if (_return_url.length > 0) {
        [tmpDict setObject:_return_url forKey:@"return_url"];
    }
    
    if (_notify_url.length > 0) {
        [tmpDict setObject:_notify_url forKey:@"notify_url"];
    }
    
    if (_app_auth_token.length > 0) {
        [tmpDict setObject:_app_auth_token forKey:@"app_auth_token"];
    }
    
    // NOTE: 排序，得出最终请求字串
    NSArray* sortedKeyArray = [[tmpDict allKeys] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    NSMutableArray *tmpArray = [NSMutableArray new];
    for (NSString* key in sortedKeyArray) {
        NSString* orderItem = [self orderItemWithKey:key andValue:[tmpDict objectForKey:key] encoded:bEncoded];
        if (orderItem.length > 0) {
            [tmpArray addObject:orderItem];
        }
    }
    return [tmpArray componentsJoinedByString:@"&"];
}

- (NSString*)orderItemWithKey:(NSString*)key andValue:(NSString*)value encoded:(BOOL)bEncoded {
    if (key.length > 0 && value.length > 0) {
        if (bEncoded) {
            value = [self encodeValue:value];
        }
        return [NSString stringWithFormat:@"%@=%@", key, value];
    }
    return nil;
}

- (NSString*)encodeValue:(NSString*)value {
    NSString* encodedValue = value;
    if (value.length > 0) {
        NSCharacterSet *charset = [[NSCharacterSet characterSetWithCharactersInString:@"!*'();:@&=+$,/?%#[]"] invertedSet];
        encodedValue = [value stringByAddingPercentEncodingWithAllowedCharacters:charset];
    }
    return encodedValue;
}

- (NSString *)timestamp {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *result = [formatter stringFromDate:[NSDate date]];
    return result;
}

@end
