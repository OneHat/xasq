//
//  NetworkManager.h
//  xasq
//
//  Created by dssj on 2019/7/26.
//  Copyright © 2019 dssj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^SuccessBlock)(NSDictionary *data);
typedef void (^FailureBlock)(NSError *error);

@interface NetworkManager : NSObject

+ (NetworkManager *)sharedManager;

///get方法请求
- (void)getRequest:(NSString *)URLString
        parameters:(nullable NSDictionary *)parameters
           success:(SuccessBlock)success
           failure:(FailureBlock)failure;

///post方法请求
- (void)postRequest:(NSString *)URLString
        parameters:(nullable NSDictionary *)parameters
           success:(SuccessBlock)success
           failure:(FailureBlock)failure;

///上传图片
- (void)uploadRequest:(NSString *)URLString
                image:(UIImage *)image
              success:(SuccessBlock)success
              failure:(FailureBlock)failure;

@end

NS_ASSUME_NONNULL_END
