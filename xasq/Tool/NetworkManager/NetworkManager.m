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

#ifdef DEBUG
static NSString *xasqBaseUrlUser = @"http://192.168.100.200:8081/";
static NSString *xasqBaseUrlOperation = @"http://192.168.100.200:8281/";
static NSString *xasqBaseUrlCommunity = @"http://192.168.100.200:8481/";
#else
static NSString *xasqBaseUrl = @"http://192.168.100.200:18084/";
#endif

const NSTimeInterval xasqTimeoutInterval = 30;

@interface NetworkManager()
    
@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
    
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
        _sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
        
//        [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain",nil];
        NSSet *acceptableContentTypes = _sessionManager.responseSerializer.acceptableContentTypes;
        NSSet *addSet = [NSSet setWithObjects:@"text/html",nil];
        
        _sessionManager.responseSerializer.acceptableContentTypes = [acceptableContentTypes setByAddingObjectsFromSet:addSet];
        _sessionManager.requestSerializer.timeoutInterval = xasqTimeoutInterval;
    }
    return self;
}
    
- (void)getRequest:(NSString *)URLString parameters:(nullable NSDictionary * )parameters success:(nonnull SuccessBlock)success failure:(nonnull FailureBlock)failure {
    
    [self updateHTTPHeaderField];
    
    NSString *absoluteString = [self baseUrlWithPath:URLString];
    NSDictionary *parameter = [self updateParameters:parameters];
    
    [_sessionManager GET:absoluteString
              parameters:parameter
                progress:^(NSProgress * _Nonnull downloadProgress) {}
                 success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                     
                     NSInteger code = [responseObject[@"code"] integerValue];
                     if (code == 200) {
                         success(responseObject);
                     } else {
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
    NSString *absoluteString = [self baseUrlWithPath:URLString];
    NSDictionary *parameter = [self updateParameters:parameters];
    
    [_sessionManager POST:absoluteString
               parameters:parameter
                 progress:^(NSProgress * _Nonnull downloadProgress) {}
                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                      NSInteger code = [responseObject[@"code"] integerValue];
                      if (code == 200) {
                          success(responseObject);
                      } else {
                          NSError *result = [self handleResponseObject:responseObject];
                          failure(result);
                      }
                      
                  } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
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

- (NSString *)baseUrlWithPath:(NSString *)path {
    NSString *urlString = @"";
    
    if ([path hasPrefix:@"user"]) {
        urlString = [NSString stringWithFormat:@"%@%@",xasqBaseUrlUser,path];
        
    } else if ([path hasPrefix:@"operation"]) {
        urlString = [NSString stringWithFormat:@"%@%@",xasqBaseUrlOperation,path];
        
    } else if ([path hasPrefix:@"community"]) {
        urlString = [NSString stringWithFormat:@"%@%@",xasqBaseUrlCommunity,path];
        
    }
    
    return urlString;
}

- (NSString *)currentLanguage {
    if ([LanguageTool currentLanguageType] == LanguageTypeZhHans) {
        return @"zh-cn";
        
    } else if ([LanguageTool currentLanguageType] == LanguageTypeEn) {
        return @"en-us";
    }
    
    return @"zh-cn";;
}
    
@end
