//
//  NetworkManager.m
//  xasq
//
//  Created by dssj on 2019/7/26.
//  Copyright © 2019 dssj. All rights reserved.
//

#import "NetworkManager.h"
#import "AFNetworking.h"
#import "DeviceInformation.h"
#import <UIImage+Metadata.h>

///dev
static NSString *xasqBaseUrlUserDev = @"http://192.168.100.200:7081/";
static NSString *xasqBaseUrlOperationDev = @"http://192.168.100.200:7281/";
static NSString *xasqBaseUrlCommunityDev = @"http://192.168.100.200:7481/";
static NSString *xasqBaseUrlMessageDev = @"http://192.168.100.200:7181/";
static NSString *xasqBaseUrlAcctDev = @"http://192.168.100.200:7581/";

///Test
static NSString *xasqBaseUrlUserTest = @"http://192.168.100.200:7081/";
static NSString *xasqBaseUrlOperationTest = @"http://192.168.100.200:7281/";
static NSString *xasqBaseUrlCommunityTest = @"http://192.168.100.200:7481/";
static NSString *xasqBaseUrlMessageTest = @"http://192.168.100.200:7181/";
static NSString *xasqBaseUrlAcctTest = @"http://192.168.100.200:7581/";

///Pro
static NSString *xasqBaseUrlUserPro = @"http://192.168.100.200:7081/";
static NSString *xasqBaseUrlOperationPro = @"http://192.168.100.200:7281/";
static NSString *xasqBaseUrlCommunityPro = @"http://192.168.100.200:7481/";
static NSString *xasqBaseUrlMessagePro = @"http://192.168.100.200:7181/";
static NSString *xasqBaseUrlAcctPro = @"http://192.168.100.200:7581/";


const NSTimeInterval xasqTimeoutInterval = 30;

typedef NS_ENUM(NSInteger, NetworkConnect) {
    NetworkConnectDev,//开发
    NetworkConnectTest,//测试
    NetworkConnectPro,//生产
};

@interface NetworkManager()
    
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, assign) NetworkConnect networkConnect;

@end

@implementation NetworkManager
    
+ (NetworkManager *)sharedManager {
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
    
- (instancetype)init {
    if (self = [super init]) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
        
//        [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",nil];
        NSSet *acceptableContentTypes = self.sessionManager.responseSerializer.acceptableContentTypes;
        NSSet *addSet = [NSSet setWithObjects:@"text/html",nil];
        
        self.sessionManager.responseSerializer.acceptableContentTypes = [acceptableContentTypes setByAddingObjectsFromSet:addSet];
//        self.sessionManager.requestSerializer = [[AFJSONRequestSerializer alloc] init];
        self.sessionManager.requestSerializer.timeoutInterval = xasqTimeoutInterval;
        
        self.networkConnect = NetworkConnectDev;
    }
    return self;
}
    
- (void)getRequest:(NSString *)URLString parameters:(nullable NSDictionary * )parameters success:(nonnull SuccessBlock)success failure:(nonnull FailureBlock)failure {
    
    [self updateHTTPHeaderField];
    
    NSString *absoluteString = [NSString stringWithFormat:@"%@%@",[self baseUrlWithPath:URLString],URLString];
    NSDictionary *parameter = [self updateParameters:parameters];
    
    [self.sessionManager GET:absoluteString
                  parameters:parameter
                    progress:^(NSProgress * _Nonnull downloadProgress) {}
                     success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                         
                         NSInteger code = [responseObject[@"code"] integerValue];
                         if (code == 200) {
                             success(responseObject);
                         } else {
#ifdef DEBUG
                             NSLog(@"get\n%@\ncode:%ld\nmsg:%@",absoluteString,code,responseObject[@"msg"]);
#endif
                             
                             NSError *result = [self handleResponseObject:responseObject];
                             failure(result);
                         }
                         
                     } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         
                         NSError *result = [self handleError:error];
                         failure(result);
                     }];
}

///post方法请求
- (void)postRequest:(NSString *)URLString parameters:(nullable NSDictionary *)parameters success:(SuccessBlock)success failure:(FailureBlock)failure {
    
    [self updateHTTPHeaderField];
    NSString *absoluteString = [NSString stringWithFormat:@"%@%@",[self baseUrlWithPath:URLString],URLString];
    NSDictionary *parameter = [self updateParameters:parameters];
    
    [self.sessionManager POST:absoluteString
                   parameters:parameter
                     progress:^(NSProgress * _Nonnull downloadProgress) {}
                      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                          NSInteger code = [responseObject[@"code"] integerValue];
                          if (code == 200) {
                              success(responseObject);
                          } else {
#ifdef DEBUG
                              NSLog(@"post\n%@\ncode:%ld\nmsg:%@",absoluteString,code,responseObject[@"msg"]);
#endif
                              
                              NSError *result = [self handleResponseObject:responseObject];
                              failure(result);
                          }
                          
                      } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                          NSError *result = [self handleError:error];
                          failure(result);
                      }];
}

- (void)uploadRequest:(NSString *)URLString image:(UIImage *)image success:(SuccessBlock)success failure:(FailureBlock)failure {
    [self updateHTTPHeaderField];
    NSString *absoluteString = [NSString stringWithFormat:@"%@%@",[self baseUrlWithPath:URLString],URLString];
    
    [self.sessionManager POST:absoluteString
                   parameters:nil
    constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        /**
         *filedata : 图片的data
         *name     : 后台的提供的字段
         *mimeType : 类型
         */
        NSString *fileName;
        NSData *imageData;
        NSString *mimetype;
        if (image.sd_imageFormat == SDImageFormatPNG) {
            mimetype = @"image/png";
            fileName = @"file.png";
            imageData = UIImagePNGRepresentation(image);
            
        } else {
            mimetype = @"image/jpeg";
            fileName = @"file.jpg";
            imageData = UIImageJPEGRepresentation(image, 1.0);
        }
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:mimetype];
        
    }
                     progress:^(NSProgress * _Nonnull uploadProgress) {}
                      success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                          if ([responseObject[@"code"] integerValue] == 200) {
                              success(responseObject);
                          } else {
                              NSError *result = [self handleResponseObject:responseObject];
                              failure(result);
                          }
                      }
                      failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                          NSError *result = [self handleError:error];
                          failure(result);
                      }];
}

#pragma mark-
- (NSError *)handleError:(NSError *)error {
    NSDictionary *info = @{ErrorMessageKeyXasq:@"网络错误"};
    NSError *result = [NSError errorWithDomain:error.domain code:error.code userInfo:info];
    return result;
}

- (NSError *)handleResponseObject:(NSDictionary *)responseObject {
    NSInteger code = [responseObject[@"code"] integerValue];
    NSString *message = responseObject[@"msg"];
    
    NSDictionary *info = @{ErrorMessageKeyXasq:message};
    NSError *result = [NSError errorWithDomain:message code:code userInfo:info];
    return result;
}

#pragma mark-
///请求头信息
- (void)updateHTTPHeaderField {
    //Content-Language:zh-hk,en-us,vn,zh-cn
    if ([UserDataManager shareManager].authorization) {
        [_sessionManager.requestSerializer setValue:[UserDataManager shareManager].authorization forHTTPHeaderField:@"Authorization"];
    } else {
        [_sessionManager.requestSerializer setValue:nil forHTTPHeaderField:@"Authorization"];
    }
    [_sessionManager.requestSerializer setValue:[self currentLanguage] forHTTPHeaderField:@"Content-Language"];
    [_sessionManager.requestSerializer setValue:@"ios.xasq" forHTTPHeaderField:@"Content-origin"];
}

- (NSDictionary *)updateParameters:(NSDictionary *)parameters {
    NSMutableDictionary *result = [NSMutableDictionary dictionary];

    if (parameters) {
        [result addEntriesFromDictionary:parameters];
    }
    
    return result;
}

- (NSString *)currentLanguage {
    if ([LanguageTool currentLanguageType] == LanguageTypeZhHans) {
        return @"zh-cn";
        
    } else if ([LanguageTool currentLanguageType] == LanguageTypeEn) {
        return @"en-us";
    }
    
    return @"zh-cn";
}

#pragma mark -
- (NSString *)baseUrlWithPath:(NSString *)path {
    
    if ([path hasPrefix:@"user"]) {
        
        if (self.networkConnect == NetworkConnectPro) {
            return xasqBaseUrlUserPro;
            
        } else if (self.networkConnect == NetworkConnectTest) {
            return xasqBaseUrlUserTest;
            
        } else if (self.networkConnect == NetworkConnectDev) {
            return xasqBaseUrlUserDev;
        }
        
        return xasqBaseUrlUserPro;
        
    } else if ([path hasPrefix:@"oper"]) {
        
        if (self.networkConnect == NetworkConnectPro) {
            return xasqBaseUrlOperationPro;
            
        } else if (self.networkConnect == NetworkConnectTest) {
            return xasqBaseUrlOperationTest;
            
        } else if (self.networkConnect == NetworkConnectDev) {
            return xasqBaseUrlOperationDev;
        }
        
        return xasqBaseUrlOperationPro;
        
    } else if ([path hasPrefix:@"comm"]) {
        if (self.networkConnect == NetworkConnectPro) {
            return xasqBaseUrlCommunityPro;
            
        } else if (self.networkConnect == NetworkConnectTest) {
            return xasqBaseUrlCommunityTest;
            
        } else if (self.networkConnect == NetworkConnectDev) {
            return xasqBaseUrlCommunityDev;
        }
        
        return xasqBaseUrlCommunityPro;
        
    } else if ([path hasPrefix:@"msg"]) {
        if (self.networkConnect == NetworkConnectPro) {
            return xasqBaseUrlMessagePro;
            
        } else if (self.networkConnect == NetworkConnectTest) {
            return xasqBaseUrlMessageTest;
            
        } else if (self.networkConnect == NetworkConnectDev) {
            return xasqBaseUrlMessageDev;
        }
        
        return xasqBaseUrlMessagePro;
        
    } else if ([path hasPrefix:@"acct"]) {
        if (self.networkConnect == NetworkConnectPro) {
            return xasqBaseUrlAcctPro;
            
        } else if (self.networkConnect == NetworkConnectTest) {
            return xasqBaseUrlAcctTest;
            
        } else if (self.networkConnect == NetworkConnectDev) {
            return xasqBaseUrlAcctDev;
        }
        
        return xasqBaseUrlAcctPro;
        
    }
    
    return @"";
}

    
@end
